<%-- 
    Document   : OnlineOrderView
    Created on : Nov 11, 2025, 10:51:18 PM
    Author     : Tran Tien Dung - B22DCAT054
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Model.User user = (Model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Order Page</title>
        
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

            .menubar {
                position: fixed;
                top: 0; left: 0;
                width: 100vw; height: 60px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: rgba(255,255,255,0.75);
                -webkit-backdrop-filter: blur(10px);
                padding: 0 25px;
                z-index: 5;
                box-sizing: border-box;
            }

            .menubar-left {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .menubar-left img {
                width: 38px; height: 38px;
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

            .cart-btn {
                background: linear-gradient(135deg, #ff9f45, #f67c0f);
                border: none;
                padding: 8px 16px;
                color: white;
                font-weight: bold;
                border-radius: 6px;
                cursor: pointer;
                transition: 0.3s;
            }
            .cart-btn:hover {
                transform: translateY(-2px);
            }

            .content-box {
                position: relative;
                z-index: 2;
                width: 75%;
                margin: 120px auto 0 auto;
                background: rgba(255,255,255,0.92);
                -webkit-backdrop-filter: blur(10px);
                border-radius: 22px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.25);
                padding: 45px;
            }

            h1 {
                text-align: center;
                font-size: 32px;
                color: #ff7b00;
                margin-bottom: 25px;
                font-weight: bold;
            }

            .search-section {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-bottom: 30px;
            }

            .search-input {
                width: 350px;
                padding: 12px 20px;
                border-radius: 30px;
                border: 1px solid #ccc;
                font-size: 16px;
                outline: none;
            }

            .search-btn {
                padding: 10px 22px;
                background: linear-gradient(135deg, #f67c0f, #ff9f45);
                border: none;
                border-radius: 25px;
                color: white;
                font-weight: bold;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 6px;
                transition: 0.3s;
            }

            .search-btn:hover {
                transform: translateY(-2px);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 25px;
                background: white;
            }

            th {
                background: #ffddb0;
                padding: 10px;
            }

            td {
                text-align: center;
                padding: 8px;
            }

            td.name-col {
                text-align: left !important;
                padding-left: 15px;
            }

            .price-col {
                text-align: right;
                padding-right: 20px;
                font-weight: 500;
            }

            tr:nth-child(even) {
                background: #fff9f0;
            }

            tr:hover {
                background: #ffe7cc;
                transition: 0.2s;
            }

            .back-container {
                width: 100%;
                text-align: left;
                padding-left: 10px;
                margin-top: 10px;
            }

            .back-btn {
                padding: 10px 20px;
                border-radius: 12px;
                background: #ffddb0;
                border: none;
                font-weight: bold;
                cursor: pointer;
                transition: 0.3s;
            }

            .back-btn:hover {
                transform: translateY(-2px);
            }
        </style>
        
    </head>
    <body>
        <div class="overlay"></div>

        <!-- Menu Bar -->
        <div class="menubar">
            <div class="menubar-left">
                <img src="<%= request.getContextPath() %>/Images/supermarket_icon.png" alt="Icon">
                <span>HN Supermarket</span>
            </div>

            <div class="menubar-right">
                <span class="user-info">Welcome, <%= user.getName() %></span>

                <!-- View cart -->
                <form action="<%= request.getContextPath() %>/ShoppingCartController" method="get">
                    <button class="cart-btn">Shopping Cart</button>
                </form>

                <!-- Logout -->
                <form action="<%= request.getContextPath() %>/Welcome.jsp">
                    <button class="logout-btn">Logout</button>
                </form>
            </div>
        </div>

        <!-- Content Box -->
        <div class="content-box">
            <h1>Online Order</h1>

            <!-- Search -->
            <form action="<%= request.getContextPath() %>/ProductController" method="get" class="search-section">
                <input type="hidden" name="action" value="searchCustomer">
                
                <input type="text" name="key" class="search-input"
                       placeholder="Enter product name..."
                       value="<%= request.getAttribute("key") != null ? request.getAttribute("key") : "" %>">
                
                <button class="search-btn">Search</button>
            </form>

            <!-- Product Table -->
            <%
                List<Model.Product> productList = (List<Model.Product>) request.getAttribute("productList");
                if (productList != null && !productList.isEmpty()) {
            %>
            
            <table border="1">
                <tr>
                    <th>Code</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Stock</th>
                    <th>Price ($)</th>
                </tr>

                <% for (Model.Product p : productList) { %>
                    <tr>
                        <td><%= p.getCode() %></td>

                        <td class="name-col">
                            <a href="<%= request.getContextPath() %>/ProductController?action=detailCustomer&code=<%= p.getCode() %>&key=<%= request.getAttribute("key") %>"
                                 style="color:#ff7b00; font-weight:bold; text-decoration:none;">
                                <%= p.getName() %>
                            </a>
                        </td>

                        <td><%= p.getCategory() %></td>
                        <td><%= (int) p.getStockQuantity() %></td>
                        <td class="price-col"><%= String.format("%.2f", p.getPrice()) %></td>
                    </tr>
                <% } %>
            </table>

            <% } 
                else if (request.getAttribute("key") != null) { 
            %>
                <p style="text-align:center; color:red; margin-top:20px;">No product found.</p>
            <% 
                } 
            %>

            <div class="back-container">
                <button class="back-btn" onclick="window.location='<%=request.getContextPath()%>/Customer/MainCustomerView.jsp'">Back</button>
            </div>
        </div>
    </body>
</html>
