/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import DAO.ProductDAO;
import DAO.ShoppingCartDAO;
import Model.Product;
import Model.ShoppingCart;
import Model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
@WebServlet(name = "ShoppingCartController", urlPatterns = {"/ShoppingCartController"})
public class ShoppingCartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User customer = (User) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        ShoppingCartDAO cartDAO = new ShoppingCartDAO();
        ShoppingCart cart = cartDAO.getOrCreateCart(customer.getId());
        request.setAttribute("cart", cart);

        request.getRequestDispatcher("Customer/ShoppingCartView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User customer = (User) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";

        if ("add".equals(action)) {
            String code = request.getParameter("code");
            double qty = Double.parseDouble(request.getParameter("quantity"));

            ProductDAO pdao = new ProductDAO();
            Product product = pdao.getProductDetail(code);

            ShoppingCartDAO cartDAO = new ShoppingCartDAO();
            boolean success = cartDAO.addToCart(customer.getId(), product, qty);

            response.sendRedirect("ProductController?action=detailCustomer&code=" 
                    + code + "&msg=" + (success ? "added" : "fail"));
        }

        else if ("confirm".equals(action)) {
            response.sendRedirect("OrderController?action=createFromCart");
        }

        else {
            response.sendRedirect("ShoppingCartController");
        }
    }
}