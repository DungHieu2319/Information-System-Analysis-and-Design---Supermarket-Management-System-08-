/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
public class DAO {
    private static String URL;
    private static String USER;
    private static String PASSWORD;
    
    static {
        try {
            InputStream input = DAO.class.getResourceAsStream("/config/db.properties");

            if (input == null) {
                System.out.println("Cannot find db.properties!");
            } else {
                Properties prop = new Properties();
                prop.load(input);

                URL = prop.getProperty("db.url");
                USER = prop.getProperty("db.user");
                PASSWORD = prop.getProperty("db.password");

                Class.forName("com.mysql.cj.jdbc.Driver");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
