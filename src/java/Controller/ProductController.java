/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import DAO.ProductDAO;
import Model.Product;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
@WebServlet("/ProductController")
public class ProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();

        if (action == null) {
            action = "search";
        }

        switch (action) {

            case "search": {
                String keyword = request.getParameter("key");
                if (keyword == null) keyword = "";

                List<Product> list = dao.getProductByName(keyword);

                request.setAttribute("productList", list);
                request.setAttribute("key", keyword);

                request.getRequestDispatcher("WarehouseStaff/EditProductView.jsp")
                       .forward(request, response);
                break;
            }

            case "detail": {
                String code = request.getParameter("code");
                String key = request.getParameter("key");

                Product product = dao.getProductDetail(code);

                request.setAttribute("product", product);
                request.setAttribute("key", key);

                request.getRequestDispatcher("WarehouseStaff/EditProductDetailView.jsp")
                       .forward(request, response);
                break;
            }

            case "searchCustomer": {
                String keyword = request.getParameter("key");
                if (keyword == null) keyword = "";

                List<Product> list = dao.getProductByName(keyword);

                request.setAttribute("productList", list);
                request.setAttribute("key", keyword);

                request.getRequestDispatcher("Customer/OnlineOrderView.jsp")
                       .forward(request, response);
                break;
            }

            case "detailCustomer": {
                String code = request.getParameter("code");
                String key = request.getParameter("key");

                Product product = dao.getProductDetail(code);

                request.setAttribute("product", product);
                request.setAttribute("key", key);

                request.getRequestDispatcher("Customer/ProductDetailView.jsp")
                       .forward(request, response);
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/Welcome.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();

        if ("update".equals(action)) {

            String code = request.getParameter("code");
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String category = request.getParameter("category");
            String description = request.getParameter("description");

            double price = 0;
            try {
                price = Double.parseDouble(priceStr);
            } catch (Exception e) {
                price = 0;
            }

            Product p = dao.getProductDetail(code);
            if (p == null) {
                response.sendRedirect(
                    request.getContextPath() +
                    "/ProductController?action=search&msg=fail"
                );
                return;
            }

            p.setName(name);
            p.setCategory(category);
            p.setDescription(description);
            p.setPrice(price);

            boolean success = dao.updateProductInfo(p);

            String oldKey = request.getParameter("oldKey");
            if (oldKey == null) oldKey = "";

            response.sendRedirect(
                request.getContextPath() +
                "/ProductController?action=search&key=" + oldKey +
                (success ? "&msg=success" : "&msg=fail")
            );
        }
    }
}
