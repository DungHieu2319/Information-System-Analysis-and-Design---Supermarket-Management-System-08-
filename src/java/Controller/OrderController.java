/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import DAO.ShoppingCartDAO;
import Model.Order;
import Model.ShoppingCart;
import Model.ShoppingCartProductDetail;
import Model.User;

import java.sql.Timestamp;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("createFromCart".equals(action)) {
            processCreateFromCart(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/ShoppingCartController");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        doGet(req, resp);
    }

    private void processCreateFromCart(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        User customer = (User) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
            return;
        }

        ShoppingCartDAO cartDAO = new ShoppingCartDAO();
        ShoppingCart cart = cartDAO.getOrCreateCart(customer.getId());
        List<ShoppingCartProductDetail> cartItems = cart.getListProduct();

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ShoppingCartController?msg=empty");
            return;
        }

        double total = 0;
        for (ShoppingCartProductDetail item : cartItems) {
            total += item.getPrice() * item.getQuantity();
        }

        Order order = new Order();
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setStatus("Pending");
        order.setCustomer(customer);

        OrderDAO orderDAO = new OrderDAO();
        boolean success = orderDAO.saveInvoice(order, cartItems);

        cartDAO.clearCart(customer.getId());

        if (!success) {
            response.sendRedirect(request.getContextPath() + "/ShoppingCartController?msg=fail");
            return;
        }

        request.setAttribute("order", order);
        request.setAttribute("invoice", cartItems);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/Customer/InvoiceView.jsp").forward(request, response);
    }
}