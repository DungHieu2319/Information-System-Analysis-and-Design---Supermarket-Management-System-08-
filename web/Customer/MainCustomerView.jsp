<%-- 
    Document   : MainCustomerView
    Created on : Nov 11, 2025, 1:49:42 PM
    Author     : Tran Tien Dung - B22DCAT054
--%>

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
        <title>Main Customer Page</title>
        
        <style>
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
                overflow: hidden;
            }
            body {
                background-image: url('<%= request.getContextPath() %>/Images/supermarket_bg.jpg');
                background-size: cover;
                background-position: center;
                font-family: 'Segoe UI', sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
            }
            .overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.35);
                z-index: 0;
            }
            .menubar {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 60px;
                background: rgba(255,255,255,0.7);
                -webkit-backdrop-filter: blur(10px);
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 25px;
                box-sizing: border-box;
                z-index: 5;
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
                background: linear-gradient(90deg, #ff7a7a, #ff9999);
                transform: translateY(-2px);
            }
            .content-box {
                margin-top: 70px;
                width: 420px;
                background: rgba(255,255,255,0.92);
                -webkit-backdrop-filter: blur(10px);
                padding: 40px;
                border-radius: 20px;
                text-align: center;
                box-shadow: 0 8px 25px rgba(0,0,0,0.25);
                z-index: 2;
            }
            h1 {
                margin-bottom: 25px;
                color: #ff7b00;
                font-size: 30px;
            }
            .btn-order {
                width: 100%;
                padding: 14px;
                background: linear-gradient(135deg,#f67c0f,#ff9f45);
                border: none;
                color: white;
                font-size: 18px;
                font-weight: bold;
                border-radius: 16px;
                cursor: pointer;
                transition: 0.3s;
            }
            .btn-order:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 12px rgba(255,153,51,0.5);
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

                <form action="../LogoutController" method="get" style="display:inline;">
                    <button class="logout-btn">Logout</button>
                </form>
            </div>
        </div>

        <!-- Main content -->
        <div class="content-box">

            <% 
                String msg = (String) request.getAttribute("msg");
                if (msg != null) { 
            %>
                <p style="color: green; font-weight: bold; font-size: 20px;">
                    <%= msg %>
                </p>
            <% } %>

            <h1>Customer Homepage</h1>

            <button class="btn-order"
                    onclick="window.location='<%=request.getContextPath()%>/Customer/OnlineOrderView.jsp'">
                Order Online
            </button>

        </div>
    </body>
</html>
