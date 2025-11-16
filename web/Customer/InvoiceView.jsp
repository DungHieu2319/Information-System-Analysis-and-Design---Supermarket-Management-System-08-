<%-- 
    Document   : InvoiceView
    Created on : Nov 12, 2025, 10:33:35 PM
    Author     : Tran Tien Dung - B22DCAT054
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="Model.ShoppingCartProductDetail"%>
<%@page import="java.util.List"%>
<%@page import="Model.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Model.User user = (Model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }

    Order order = (Order) request.getAttribute("order");
    List<ShoppingCartProductDetail> invoice =
        (List<ShoppingCartProductDetail>) request.getAttribute("invoice");
    
    if (order == null || invoice == null) {
        response.sendRedirect("../ShoppingCartController");
        return;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss", Locale.ENGLISH);
    String orderDateStr = sdf.format(order.getOrderDate());
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice Page</title>
        
        <style>
            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
            }

            body {
                background-image: url('<%= request.getContextPath() %>/Images/supermarket_bg.jpg');
                background-size: cover;
                background-position: center;
                font-family: 'Segoe UI', sans-serif;
                position: relative;
            }

            .overlay {
                position: fixed;
                top: 0; left: 0;
                width: 100%; height: 100%;
                background-color: rgba(0,0,0,0.35);
                z-index: 0;
            }

            /* MENU BAR */
            .menubar {
                position: fixed;
                top: 0; left: 0;
                width: 100vw;
                height: 60px;
                background: rgba(255,255,255,0.7);
                -webkit-backdrop-filter: blur(10px);
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 25px;
                box-sizing: border-box;
                z-index: 10;
            }

            .menubar-left {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .menubar-left img {
                width: 38px;
                height: 38px;
            }

            .menubar-left span {
                font-size: 20px;
                font-weight: bold;
                color: #2c3e50;
            }

            .menubar-right {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .user-info {
                font-size: 18px;
                font-weight: bold;
                color: #333;
            }

            .logout-btn {
                background: linear-gradient(90deg, #ff5d5d, #ff8080);
                border: none;
                padding: 8px 16px;
                color: white;
                font-weight: bold;
                border-radius: 6px;
                cursor: pointer;
                transition: 0.3s;
            }

            .logout-btn:hover {
                transform: translateY(-2px);
                background: linear-gradient(90deg, #ff6f6f, #ff9191);
            }

            /* INVOICE BOX */
            .invoice-box {
                position: relative;
                z-index: 2;
                width: 70%;
                margin: 120px auto;
                background: rgba(255,255,255,0.92);
                -webkit-backdrop-filter: blur(10px);
                padding: 40px 45px;
                border-radius: 22px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.25);
            }

            h1 {
                text-align: center;
                font-size: 30px;
                color: #ff7b00;
                margin-bottom: 20px;
                font-weight: bold;
            }

            .info-row {
                display: flex;
                font-size: 18px;
                margin: 6px 0;
            }

            .label {
                width: 160px;
                font-weight: bold;
            }

            .value {
                flex: 1;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                font-size: 17px;
                background: white;
            }

            th, td {
                border: 1px solid black;
                padding: 10px;
            }

            th {
                background: #ffe1c2;
            }

            td.left { text-align: left; padding-left: 10px; }
            td.center { text-align: center; }
            td.right { text-align: right; padding-right: 10px; }

            .total-text {
                text-align: right;
                margin-top: 20px;
                font-size: 20px;
                font-weight: bold;
            }

            .btn-wrapper {
                margin-top: 40px;
            }

            .btn-row-center {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }

            .confirm-btn {
                width: 180px;
                padding: 12px 22px;
                border-radius: 12px;
                background: #ffddb0;
                border: 2px solid black;
                font-weight: bold;
                cursor: pointer;
                font-size: 18px;
            }

            .confirm-btn {
                background: linear-gradient(135deg, #f67c0f, #ff9f45);
                color: white;
            }

            .confirm-btn:hover {
                transform: translateY(-2px);
            }
        </style>
        
    </head>
    <body>
        <div class="overlay"></div>

        <!-- MENU BAR -->
        <div class="menubar">
            <div class="menubar-left">
                <img src="<%= request.getContextPath() %>/Images/supermarket_icon.png" alt="Logo">
                <span>HN Supermarket</span>
            </div>

            <div class="menubar-right">
                <span class="user-info">Welcome, <%= user.getName() %></span>
                <form action="<%= request.getContextPath() %>/Welcome.jsp">
                    <button class="logout-btn">Logout</button>
                </form>
            </div>
        </div>

        <!-- INVOICE CONTENT -->
        <div class="invoice-box">
            <h1>Invoice</h1>

            <div class="info-row">
                <div class="label">- Name:</div> 
                <div class="value"><%= order.getCustomer().getName() %></div>
            </div>
            
            <div class="info-row">
                <div class="label">- Phone number:</div> 
                <div class="value"><%= order.getCustomer().getPhoneNumber() %></div>
            </div>
            
            <div class="info-row">
                <div class="label">- Address:</div> 
                <div class="value"><%= order.getCustomer().getAddress() %></div>
            </div>
            
            <div class="info-row">
                <div class="label">- Order date:</div> 
                <div class="value"><%= orderDateStr %></div>
            </div>

            <div class="info-row">
                <div class="label">- List of products:</div>
            </div>

            <table>
                <tr>
                    <th>No.</th>
                    <th>Product name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
                <%
                    int i = 1;
                    if (invoice != null) {
                        for (ShoppingCartProductDetail item : invoice) {
                %>
                <tr>
                    <td class="center"><%= i++ %></td>
                    <td class="left"><%= item.getProduct().getName() %></td>
                    <td class="center"><%= (int)item.getQuantity() %></td>
                    <td class="right"><%= String.format("%,.1f", item.getPrice() * item.getQuantity()) %> $</td>
                </tr>
                <% } } %>
            </table>

            <div class="total-text">
                Total: <%= String.format("%,.1f", (double) request.getAttribute("total")) %> $
            </div>

            <div class="btn-wrapper">

                <div class="btn-row-center">
                    <form action="<%= request.getContextPath() %>/Customer/MainCustomerView.jsp" method="get">
                        <input type="hidden" name="msg" value="success">
                        <button class="confirm-btn" type="submit">Confirm</button>
                    </form>
                </div>

            </div>
        </div>
    </body>
</html>
