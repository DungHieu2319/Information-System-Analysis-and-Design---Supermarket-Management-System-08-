/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tran Tien Dung - B22DCAT054
 */
public class ShoppingCart {
    private int id;
    private List<ShoppingCartProductDetail> listProduct;

    public ShoppingCart() {
        this.listProduct = new ArrayList<>();
    }

    public ShoppingCart(int id, List<ShoppingCartProductDetail> listProduct) {
        this.id = id;
        this.listProduct = listProduct;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public List<ShoppingCartProductDetail> getListProduct() {
        return listProduct;
    }
    public void setListProduct(List<ShoppingCartProductDetail> listProduct) {
        this.listProduct = listProduct;
    }
    
}
