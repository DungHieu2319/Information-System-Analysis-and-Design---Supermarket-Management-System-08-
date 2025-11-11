/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.security.Timestamp;
import java.util.List;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
public class Order {
    private int id;
    private Timestamp orderDate;
    private float totalPrice;
    private String status;
    private Customer customer;
    private List<OrderProductDetail> listProduct;

    public Order() {
    }

    public Order(int id, Timestamp orderDate, float totalPrice, String status, Customer customer, List<OrderProductDetail> listProduct) {
        this.id = id;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.customer = customer;
        this.listProduct = listProduct;
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

    public float getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public Customer getCustomer() {
        return customer;
    }
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public List<OrderProductDetail> getListProduct() {
        return listProduct;
    }
    public void setListProduct(List<OrderProductDetail> listProduct) {
        this.listProduct = listProduct;
    }
    
}
