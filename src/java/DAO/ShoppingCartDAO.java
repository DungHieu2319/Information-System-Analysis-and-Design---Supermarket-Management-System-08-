/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

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
public class ShoppingCartDAO extends DAO {
    
    public ShoppingCartDAO() {
        super();
    }
    
    // Function get or create cart by Customer ID
    public ShoppingCart getOrCreateCart(int customerUserId) {
        try (Connection conn = getConnection()) {

            String sql = "SELECT id FROM tblShoppingCart WHERE customerID = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, customerUserId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    int cartId = rs.getInt("id");
                    List<ShoppingCartProductDetail> list = getListProductInCart(cartId);
                    return new ShoppingCart(cartId, list);
                }
            }

            String insert = "INSERT INTO tblShoppingCart(customerID) VALUES(?)";
            try (PreparedStatement ps2 = conn.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS)) {
                ps2.setInt(1, customerUserId);
                ps2.executeUpdate();

                ResultSet keys = ps2.getGeneratedKeys();
                if (keys.next()) {
                    int newCartId = keys.getInt(1);
                    return new ShoppingCart(newCartId, new ArrayList<>());
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ShoppingCart(0, new ArrayList<>());
    }
    
    // Function get list of products inside the cart
    public List<ShoppingCartProductDetail> getListProductInCart(int cartId) {
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

            ps.setInt(1, cartId);
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
    
    // Function add a product to the customer's shopping cart
    public boolean addToCart(int customerUserId, Product product, double quantity) {

        try (Connection conn = getConnection()) {
            ShoppingCart cart = getOrCreateCart(customerUserId);
            int cartId = cart.getId();

            String checkSQL = "SELECT id, quantity FROM tblShoppingCartProductDetail WHERE productID = ? AND shoppingcartID = ?";
            try (PreparedStatement checkPS = conn.prepareStatement(checkSQL)) {
                checkPS.setInt(1, product.getId());
                checkPS.setInt(2, cartId);
                ResultSet rs = checkPS.executeQuery();

                if (rs.next()) {
                    double oldQty = rs.getDouble("quantity");
                    double newQty = oldQty + quantity;

                    String update = "UPDATE tblShoppingCartProductDetail SET quantity = ? WHERE id = ?";
                    try (PreparedStatement ups = conn.prepareStatement(update)) {
                        ups.setDouble(1, newQty);
                        ups.setInt(2, rs.getInt("id"));
                        ups.executeUpdate();
                        return true;
                    }
                }
            }

            String insert = """
                INSERT INTO tblShoppingCartProductDetail(quantity, price, productID, shoppingcartID)
                VALUES(?, ?, ?, ?)
            """;
            try (PreparedStatement ps = conn.prepareStatement(insert)) {
                ps.setDouble(1, quantity);
                ps.setDouble(2, product.getPrice());
                ps.setInt(3, product.getId());
                ps.setInt(4, cartId);
                ps.executeUpdate();
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    // Function clear all products in a customer's cart after save to the database
    public boolean clearCart(int customerUserId) {
        String sql = """
            DELETE FROM tblShoppingCartProductDetail
            WHERE shoppingcartID = (
                SELECT id FROM tblShoppingCart WHERE customerID = ?
            )
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerUserId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
