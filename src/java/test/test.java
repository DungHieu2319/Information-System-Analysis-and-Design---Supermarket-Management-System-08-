/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

import DAO.DAO;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
public class test {
    public static void main(String[] args) {
        try {
            Connection conn = DAO.getConnection();
            
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Connected successfully!");
            } else {
                System.out.println("❌ Connection failed!");
            }

        } catch (SQLException e) {
            System.out.println("❌ SQLException occurred:");
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("❌ Unknown exception occurred:");
            e.printStackTrace();
        }
    }
}
