/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import Model.Product;
import Model.ShoppingCart;
import Model.ShoppingCartProductDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
public class OrderDAO extends DAO {
    
    public OrderDAO() {
        super();
    }
    
    // Function get list of product from a shopping cart
    public List<ShoppingCartProductDetail> getInvoice(ShoppingCart cart) {
        List<ShoppingCartProductDetail> list = new ArrayList<>();

        String sql = """
            SELECT d.id AS detailId, d.quantity, d.price,
                   p.id AS pid, p.code, p.name, p.category, 
                   p.price AS productPrice, p.stockQuantity, p.description
            FROM tblShoppingCartProductDetail d
            JOIN tblProduct p ON p.id = d.productID
            WHERE d.shoppingcartID = ?
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cart.getId());
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("pid"),
                        rs.getString("code"),
                        rs.getString("name"),
                        rs.getString("category"),
                        (float) rs.getDouble("productPrice"),
                        (float) rs.getDouble("stockQuantity"),
                        rs.getString("description")
                );

                ShoppingCartProductDetail detail = new ShoppingCartProductDetail(
                        rs.getInt("detailId"),
                        rs.getDouble("quantity"),
                        rs.getDouble("price"),
                        p
                );

                list.add(detail);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    // Function save an order into database
    public boolean saveInvoice(Order order, List<ShoppingCartProductDetail> cartItems) {

        String insertOrder = """
            INSERT INTO tblOrder(orderDate, status, customerID)
            VALUES (?, ?, ?)
        """;

        String insertDetail = """
            INSERT INTO tblOrderProductDetail(quantity, price, productID, orderID)
            VALUES (?, ?, ?, ?)
        """;

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);

            int orderId = 0;

            try (PreparedStatement psOrder = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setTimestamp(1, new Timestamp(order.getOrderDate().getTime()));
                psOrder.setString(2, order.getStatus());
                psOrder.setInt(3, order.getCustomer().getId());
                psOrder.executeUpdate();

                ResultSet keys = psOrder.getGeneratedKeys();
                if (keys.next()) {
                    orderId = keys.getInt(1);
                    order.setId(orderId);
                }
            }

            try (PreparedStatement psDetail = conn.prepareStatement(insertDetail)) {
                for (ShoppingCartProductDetail d : cartItems) {
                    psDetail.setDouble(1, d.getQuantity());
                    psDetail.setDouble(2, d.getPrice());
                    psDetail.setInt(3, d.getProduct().getId());
                    psDetail.setInt(4, orderId);
                    psDetail.addBatch();
                }
                psDetail.executeBatch();
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}