/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
public class Order {
    private int id;
    private Timestamp orderDate;
    private double totalPrice;
    private String status;
    private User customer;
    private List<OrderProductDetail> listProduct;

    public Order() {
    }

    public Order(int id, Timestamp orderDate, double totalPrice, String status, Customer customer, List<OrderProductDetail> listProduct) {
        this.id = id;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.customer = customer;
        this.listProduct = listProduct != null ? listProduct : new ArrayList<>();
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public User getCustomer() {
        return customer;
    }
    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public List<OrderProductDetail> getListProduct() {
        return listProduct;
    }
    public void setListProduct(List<OrderProductDetail> listProduct) {
        this.listProduct = listProduct != null ? listProduct : new ArrayList<>();
    }
    
}
