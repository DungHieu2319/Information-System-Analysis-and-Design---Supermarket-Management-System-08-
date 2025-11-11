/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Product;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
public class ProductDAO extends DAO {
    
    // Function ProductDAO
    public ProductDAO() {
        super();
    }
    
    // Function get product list by name
    public List<Product> getProductByName(String keyword) {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT * FROM tblProduct WHERE name LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("id"),
                            rs.getString("code"),
                            rs.getString("name"),
                            rs.getString("category"),
                            rs.getDouble("price"),
                            rs.getDouble("stockQuantity"),
                            rs.getString("description")
                    );

                    list.add(p);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    // Function get product detail by code
    public Product getProductDetail(String code) {
        Product p = null;

        String sql = "SELECT * FROM tblProduct WHERE code = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, code);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Product(
                            rs.getInt("id"),
                            rs.getString("code"),
                            rs.getString("name"),
                            rs.getString("category"),
                            rs.getDouble("price"),
                            rs.getDouble("stockQuantity"),
                            rs.getString("description")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }
    
    // Function update product info
    public boolean updateProductInfo(Product product) {
        String sql = "UPDATE tblProduct SET "
                   + "name = ?, category = ?, price = ?, description = ? "
                   + "WHERE code = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getCategory());
            ps.setDouble(3, product.getPrice());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getCode());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
