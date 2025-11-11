<%-- 
    Document   : EditProductDetailView
    Created on : Nov 11, 2025, 10:52:24 PM
    Author     : Tran Tien Dung - B22DCAT054
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Model.User user = (Model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }

    Model.Product p = (Model.Product) request.getAttribute("product");
    if (p == null) {
        response.sendRedirect(request.getContextPath() + "/ProductController?action=search");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Product Detail Page</title>
        
        <style>
            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
                overflow-y: hidden;
            }
            body {
                background-image: url('<%=request.getContextPath()%>/Images/supermarket_bg.jpg');
                background-size: cover;
                background-position: center;
                font-family: 'Segoe UI', sans-serif;
            }
            .overlay {
                position: fixed;
                inset: 0;
                background-color: rgba(0,0,0,0.35);
                z-index: 0;
            }

            /* Menu Bar */
            .menubar {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 54px;
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
                padding: 8px 16px;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                color: white;
                cursor: pointer;
                transition: 0.3s;
            }
            .logout-btn:hover {
                background: linear-gradient(90deg,#ff7a7a,#ff9999);
            }

            /* Main Content Box */
            .box {
                width: 55%;
                min-width: 650px;
                max-width: 850px;

                background: rgba(255,255,255,0.92);
                -webkit-backdrop-filter: blur(10px);

                margin: 60px auto 40px auto;
                padding: 25px 32px;

                border-radius: 25px;
                box-shadow: 0 8px 30px rgba(0,0,0,0.25);
                position: relative;
                z-index: 2;
            }

            h1 {
                text-align: center;
                font-size: 32px;
                color: #ff7b00;
                margin-bottom: 20px;
                font-weight: bold;
            }

            .form-group {
                margin-bottom: 18px;
            }

            label {
                font-weight: bold;
                color: #333;
                margin-bottom: 6px;
                display: block;
            }

            input, textarea {
                width: 100%;
                padding: 12px 16px;
                border-radius: 12px;
                border: 1px solid #ddd;
                font-size: 15px;
                box-sizing: border-box;
            }

            input[readonly] {
                background: #f3f3f3;
                color: #666;
            }

            textarea {
                min-height: 120px;
                resize: vertical;
            }

            .btn-save {
                width: 100%;
                padding: 14px;
                border: none;
                border-radius: 18px;
                background: linear-gradient(135deg,#f67c0f,#ff9f45);
                color: white;
                font-weight: bold;
                font-size: 16px;
                cursor: pointer;
                margin-top: 15px;
            }

            .btn-cancel {
                margin-top: 15px;
                padding: 10px 20px;
                border-radius: 12px;
                border: none;
                background: #ffe1c4;
                font-weight: bold;
                cursor: pointer;
            }
            
            .form-row {
                display: flex;
                gap: 20px;
                margin-bottom: 18px;
            }

            .form-row .form-group {
                flex: 1;
                margin-bottom: 0;
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

                <form action="<%=request.getContextPath()%>/LogoutController">
                    <button class="logout-btn">Logout</button>
                </form>
            </div>
        </div>

        <!-- Content -->
        <div class="box">
            <h1>Edit Product Detail</h1>

            <form action="<%=request.getContextPath()%>/ProductController" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="oldKey" value="<%= request.getParameter("key") %>">

                <div class="form-group">
                    <label>Code:</label>
                    <input type="text" name="code" value="<%=p.getCode()%>" readonly>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Name:</label>
                        <input type="text" name="name" value="<%=p.getName()%>" required>
                    </div>

                    <div class="form-group">
                        <label>Category:</label>
                        <input type="text" name="category" value="<%=p.getCategory()%>" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Stock Quantity:</label>
                        <input type="text" value="<%= (int)p.getStockQuantity() %>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Price ($):</label>
                        <input type="number"
                               step="0.1"
                               min="0.1"
                               name="price"
                               value="<%= new java.text.DecimalFormat("0.0").format(p.getPrice()) %>"
                               required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Description:</label>
                    <textarea name="description"><%= p.getDescription() != null ? p.getDescription() : "" %></textarea>
                </div>

                <button class="btn-save">Save Changes</button>
                <button class="btn-cancel" type="button" onclick="history.back()">Cancel</button>

            </form>
        </div>
    </body>
</html>
