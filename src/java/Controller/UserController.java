/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import Model.User;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form login
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.checkLogin(username, password);

        // Login success
        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("fullName", user.getName());
            session.setAttribute("role", user.getRole());

            String role = user.getRole().toLowerCase().trim();

            if (role.equals("customer")) {
                response.sendRedirect("Customer/MainCustomerView.jsp");

            } else if (role.equals("warehouse staff")) {
                response.sendRedirect("WarehouseStaff/MainWSView.jsp");

            } else {
                
                session.invalidate();
                request.setAttribute("error", "Role is invalid!");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }

        } else {
            // Login failed
            request.setAttribute("error", "Account not found or incorrect password!");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}
