<%-- 
    Document   : ShoppingCartView
    Created on : Nov 12, 2025, 10:33:14 PM
    Author     : Tran Tien Dung - B22DCAT054
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Model.User user = (Model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }

    Model.ShoppingCart cart = (Model.ShoppingCart) request.getAttribute("cart");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart Page</title>
        
        <style>
            body {
                margin: 0;
                padding: 0;
                background-image: url('<%= request.getContextPath() %>/Images/supermarket_bg.jpg');
                background-size: cover;
                background-position: center;
                font-family: 'Segoe UI', sans-serif;
                height: 100vh;
                color: #333;
                position: relative;
            }

            .overlay {
                position: absolute;
                top: 0; left: 0;
                width: 100%; height: 100%;
                background-color: rgba(0,0,0,0.35);
                z-index: 0;
            }

            /* Menu bar */
            .menubar {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 60px;
                background: rgba(255, 255, 255, 0.65);
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
                white-space: nowrap;
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

            /* Box content */
            .box {
                margin: 110px auto 40px auto;
                width: 75%;
                max-width: 900px;
                background: rgba(255,255,255,0.92);
                -webkit-backdrop-filter: blur(10px);
                padding: 30px 40px;
                border-radius: 18px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.25);
                z-index: 2;
                position: relative;
            }

            h1 {
                text-align: center;
                margin-bottom: 25px;
                font-size: 28px;
                color: #ff7b00;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
            }
            th, td {
                border: 1px solid #555;
                padding: 10px;
                text-align: center;
            }
            th {
                background: #ffe1c2;
                font-size: 17px;
            }
            td {
                font-size: 16px;
            }

            td.left {
                text-align: left !important;
                padding-left: 15px;
            }

            td.right {
                text-align: right !important;
                padding-right: 15px;
            }

            .total-label {
                text-align: right;
                font-size: 20px;
                font-weight: bold;
                margin-top: 15px;
            }

            .checkout-btn {
                display: block;
                margin: 25px auto 0 auto;
                padding: 12px 35px;
                background: linear-gradient(135deg, #f67c0f, #ff9f45);
                border: none;
                border-radius: 15px;
                font-size: 18px;
                font-weight: bold;
                color: white;
                cursor: pointer;
                transition: 0.3s;
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
                <form action="<%= request.getContextPath() %>/Welcome.jsp" style="margin:0;">
                    <button class="logout-btn">Logout</button>
                </form>
            </div>
        </div>

        <div class="box">
            <h1>Shopping Cart</h1>

            <%
                double totalAmount = 0;
                if (cart != null && cart.getListProduct() != null && !cart.getListProduct().isEmpty()) {
            %>

            <table>
                <tr>
                    <th>No.</th>
                    <th>Product name</th>
                    <th>Quantity</th>
                    <th>Unit price</th>
                    <th>Total</th>
                </tr>

                <%
                    int index = 1;
                    for (Model.ShoppingCartProductDetail item : cart.getListProduct()) {
                        double lineTotal = item.getPrice() * item.getQuantity();
                        totalAmount += lineTotal;
                %>
                <tr>
                    <td><%= index++ %></td>
                    <td class="left"><%= item.getProduct().getName() %></td>
                    <td><%= (int)item.getQuantity() %></td>
                    <td class="right"><%= String.format("%,.1f", item.getPrice()) %> $</td>
                    <td class="right"><%= String.format("%,.1f", lineTotal) %> $</td>
                </tr>
                <% } %>
            </table>

            <p class="total-label">Total Amount: <%= String.format("%,.1f", totalAmount) %> $</p>

            <form action="<%=request.getContextPath()%>/ShoppingCartController" method="post">
                <input type="hidden" name="action" value="confirm" />
                <button class="checkout-btn">Submit</button>
            </form>
            <% } %>
        </div>
    </body>
</html>
