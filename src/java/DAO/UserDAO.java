/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Customer;
import Model.ShoppingCart;
import Model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
public class UserDAO extends DAO{
    private static final String SQL_LOGIN = 
            "SELECT * FROM tblUser WHERE username = ? AND password = ?";
    
    public User checkLogin(String username, String password) {
        try (Connection conn = DAO.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_LOGIN)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    String role = rs.getString("role");

                    if (role.equalsIgnoreCase("customer")) {
                        Customer cus = new Customer(
                                rs.getInt("id"),
                                rs.getString("code"),
                                rs.getString("name"),
                                rs.getString("username"),
                                rs.getString("password"),
                                rs.getDate("dateOfBirth"),
                                rs.getString("address"),
                                rs.getString("email"),
                                rs.getString("phoneNumber"),
                                role
                        );

                        cus.setCart(new ShoppingCart()); // tránh null
                        return cus;
                    }

                    return new User(
                            rs.getInt("id"),
                            rs.getString("code"),
                            rs.getString("name"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getDate("dateOfBirth"),
                            rs.getString("address"),
                            rs.getString("email"),
                            rs.getString("phoneNumber"),
                            role
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public String getUserRole(User user) {
        return user != null ? user.getRole() : "unknown";
    }

    public String getFullName(User user) {
        return user != null ? user.getName() : "";
    }
}
