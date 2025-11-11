/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
public class Customer extends User {
    private ShoppingCart cart;

    public Customer() {
        super();
        this.cart = new ShoppingCart();
    }
    
    public Customer(int id, String code, String name, String username, String password, Date dateOfBirth, String address, String email, String phoneNumber, String role) {
        super(id, code, name, username, password, dateOfBirth, address, email, phoneNumber, role);
        this.cart = new ShoppingCart();
    }

    public Customer(ShoppingCart cart, int id, String code, String name, String username, String password, Date dateOfBirth, String address, String email, String phoneNumber, String role) {
        super(id, code, name, username, password, dateOfBirth, address, email, phoneNumber, role);
        this.cart = cart != null ? cart : new ShoppingCart();
    }

    public ShoppingCart getCart() {
        return cart;
    }
    public void setCart(ShoppingCart cart) {
        this.cart = cart != null ? cart : new ShoppingCart();
    }
    
}
