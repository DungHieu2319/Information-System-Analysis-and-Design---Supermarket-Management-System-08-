<%-- 
    Document   : EditProductView
    Created on : Nov 11, 2025, 10:50:17 PM
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
        <title>Edit Product Page</title>
        
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
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.35);
                z-index: 0;
            }
            .menubar {
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 60px;
                background: rgba(255,255,255,0.7);
                -webkit-backdrop-filter: blur(10px);
                display: flex;
                justify-content: space-between;
                align-items: center;
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
                background: linear-gradient(90deg,#ff5d5d,#ff8080);
                border: none;
                padding: 8px 16px;
                border-radius: 6px;
                color: white;
                cursor: pointer;
                font-weight: bold;
                transition: 0.3s;
            }
            .logout-btn:hover {
                background: linear-gradient(90deg,#ff7a7a,#ff9999);
            }
            .content-box {
                position: relative;
                width: 75%;
                margin: 120px auto 0 auto;
                background: rgba(255,255,255,0.92);
                -webkit-backdrop-filter: blur(10px);
                padding: 45px;
                border-radius: 22px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.25);
                z-index: 2;
            }
            h1 {
                text-align: center;
                color: #ff7b00;
                font-size: 32px;
                margin-bottom: 25px;
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
            }
            .search-btn {
                padding: 10px 22px;
                background: linear-gradient(135deg,#f67c0f,#ff9f45);
                border: none;
                color: white;
                border-radius: 25px;
                font-weight: bold;
                cursor: pointer;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                margin-top: 25px;
            }
            th {
                background: #ffddb0;
                padding: 10px;
            }
            td {
                padding: 8px;
                text-align: center;
            }
            .name-col {
                text-align: left !important;
                padding-left: 15px;
            }
            .price-col {
                text-align: right;
                padding-right: 20px;
            }
            .back-container {
                margin-top: 25px;
                text-align: left;
            }
            .back-btn {
                padding: 10px 20px;
                border-radius: 12px;
                border: none;
                font-weight: bold;
                background: #ffddb0;
                cursor: pointer;
            }
        </style>
        
    </head>
    <body>
        <div class="overlay"></div>

        <!-- Menu Bar -->
        <div class="menubar">
            <div class="menubar-left">
                <img src="<%= request.getContextPath() %>/Images/supermarket_icon.png">
                <span>HN Supermarket</span>
            </div>

            <div class="menubar-right">
                <span class="user-info">Welcome, <%= user.getName() %></span>

                <form action="<%= request.getContextPath() %>/LogoutController" method="get">
                    <button class="logout-btn">Logout</button>
                </form>
            </div>
        </div>

        <!-- Content Box -->
        <div class="content-box">

            <% 
                String msg = request.getParameter("msg");
                if ("success".equals(msg)) { 
            %>
                <p style="text-align:center; color:green; font-weight:bold;">Update product successfully!</p>
            <% 
                } else if ("fail".equals(msg)) { 
            %>
                <p style="text-align:center; color:red; font-weight:bold;">Update failed!</p>
            <% } %>

            <h1>Edit Product</h1>

            <!-- Search -->
            <form action="<%= request.getContextPath() %>/ProductController" method="get" class="search-section">
                <input type="hidden" name="action" value="search">

                <input type="text" class="search-input"
                       name="key"
                       placeholder="Enter product name..."
                       value="<%= request.getAttribute("key") != null ? request.getAttribute("key") : "" %>">

                <button class="search-btn">Search</button>
            </form>

            <!-- Product Table -->
            <%
                List<Model.Product> list = (List<Model.Product>) request.getAttribute("productList");

                if (list != null && !list.isEmpty()) {
            %>

                <table border="1">
                    <tr>
                        <th>Code</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Stock Quantity</th>
                        <th>Price ($)</th>
                    </tr>

                    <% for (Model.Product p : list) { %>
                    <tr>
                        <td><%= p.getCode() %></td>

                        <td class="name-col">
                            <a href="<%= request.getContextPath() %>/ProductController?action=detail&code=<%= p.getCode() %>&key=<%= request.getAttribute("key") %>"
                               style="color:#ff7b00; font-weight:bold; text-decoration:none;">
                                <%= p.getName() %>
                            </a>
                        </td>

                        <td><%= p.getCategory() %></td>
                        <td><%= (int) p.getStockQuantity() %></td>
                        <td class="price-col"><%= p.getPrice() %></td>
                    </tr>
                    <% } %>
                </table>

            <% } else if (request.getAttribute("key") != null) { %>

                <p style="text-align:center; color:red; margin-top:20px;">
                    No product found.
                </p>

            <% } %>

            <div class="back-container">
                <button class="back-btn" onclick="window.location='<%= request.getContextPath() %>/WarehouseStaff/MainWSView.jsp'">
                    Back
                </button>
            </div>
        </div>
    </body>
</html>
