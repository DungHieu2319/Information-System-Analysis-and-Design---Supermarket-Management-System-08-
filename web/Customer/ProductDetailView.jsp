<%-- 
    Document   : ProductDetailView
    Created on : Nov 12, 2025, 10:32:46 PM
    Author     : Tran Tien Dung - B22DCAT054
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Model.User user = (Model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }

    Model.Product p = (Model.Product) request.getAttribute("product");
    if (p == null) {
        response.sendRedirect(request.getContextPath() + "/ProductController?action=searchCustomer");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Detail Page</title>
        
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
                background-color: rgba(255,255,255,0.7);
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
            .logout-btn:hover {
                background: linear-gradient(90deg, #ff4040, #ff7070);
            }

            .box {
                position: relative;
                z-index: 2;
                width: 55%;
                max-width: 750px;
                min-width: 600px;
                margin: 110px auto 50px auto;
                background: rgba(255,255,255,0.92);
                -webkit-backdrop-filter: blur(10px);
                border-radius: 22px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.25);
                padding: 40px 45px;
            }

            h1 {
                text-align: center;
                font-size: 30px;
                color: #ff7b00;
                font-weight: bold;
                margin-bottom: 25px;
            }

            .message {
                text-align: center;
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 15px;
            }
            .success { color: green; }
            .fail { color: red; }

            .detail-row {
                display: flex;
                margin: 8px 0;
                font-size: 17px;
                color: #333;
            }

            .detail-label {
                width: 180px;
                font-weight: bold;
            }
            
            .detail-value {
                flex: 1;
            }

            .qty-input {
                width: 100px;
                padding: 10px;
                font-size: 16px;
                border-radius: 12px;
                border: 1px solid #ccc;
            }

            .btn-container {
                display: flex;
                justify-content: space-between;
                margin-top: 25px;
            }

            .btn {
                padding: 12px 28px;
                font-size: 16px;
                font-weight: bold;
                border-radius: 15px;
                border: none;
                cursor: pointer;
                transition: 0.3s;
            }

            .btn-back {
                background: #ffddb0;
            }

            .btn-add {
                background: linear-gradient(135deg, #f67c0f, #ff9f45);
                color: white;
            }

            .btn-add:hover {
                opacity: 0.9;
                transform: scale(1.02);
            }
        </style>
        
    </head>
    <body>
        <div class="overlay"></div>

        <!-- Menu bar -->
        <div class="menubar">
            <div class="menubar-left">
                <img src="<%= request.getContextPath() %>/Images/supermarket_icon.png">
                <span>HN Supermarket</span>
            </div>
                
            <div class="menubar-right">
                <span class="user-info">Welcome, <%= user.getName() %></span>
                <form action="<%= request.getContextPath() %>/Welcome.jsp">
                    <button class="logout-btn">Logout</button>
                </form>
            </div>
        </div>

        <div class="box">
            <h1>Product Details</h1>

            <% 
                String msg = request.getParameter("msg");
                if ("added".equals(msg)) {
            %>
                <p class="message success">Added to cart successfully!</p>
            <% 
                } else if ("fail".equals(msg)) { 
            %>
                <p class="message fail">Failed to add to cart!</p>
            <% 
                } 
            %>

            <!-- Product details -->
            <div class="detail-row">
                <div class="detail-label">Code:</div>
                <div class="detail-value"><%= p.getCode() %></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Name:</div>
                <div class="detail-value"><%= p.getName() %></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Category:</div>
                <div class="detail-value"><%= p.getCategory() %></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Stock quantity:</div>
                <div class="detail-value"><%= (int)p.getStockQuantity() %></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Price:</div>
                <div class="detail-value"><%= String.format("%.2f", p.getPrice()) %> $</div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Description:</div>
                <div class="detail-value"><%= p.getDescription() %></div>
            </div>

            <!-- Add to cart form -->
            <form action="<%= request.getContextPath() %>/ShoppingCartController" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="code" value="<%= p.getCode() %>">

                <div class="detail-row">
                    <div class="detail-label">Quantity:</div>
                    <div class="detail-value">
                        <input class="qty-input" type="number"
                               name="quantity"
                               min="1"
                               max="<%= (int)p.getStockQuantity() %>"
                               required>

                        <button type="submit" class="btn btn-add">Add to Cart</button>
                    </div>
                </div>

                <div class="btn-container">
                    <button type="button" class="btn btn-back"
                        onclick="location.href='<%= request.getContextPath() %>/Customer/OnlineOrderView.jsp'">
                        Back
                    </button>
                </div>
            </form>
        </div>
    </body>
</html>
