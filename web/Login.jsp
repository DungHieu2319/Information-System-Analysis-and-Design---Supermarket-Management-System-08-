<%-- 
    Document   : Login
    Created on : Nov 11, 2025, 1:57:02 PM
    Author     : Tran Tien Dung - B22DCAT054
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        
        <style>
            body {
                margin: 0;
                padding: 0;
                background-image: url('Images/supermarket_bg.jpg');
                background-size: cover;
                background-position: center;
                font-family: 'Segoe UI', sans-serif;
                height: 100vh;
                color: #333;
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
            }
            .overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.35);
                z-index: 0;
            }
            .login-container {
                position: relative;
                z-index: 1;
                background: rgba(255, 255, 255, 0.9);
                -webkit-backdrop-filter: blur(10px);
                padding: 50px 60px;
                border-radius: 20px;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
                width: 380px;
                text-align: center;
                animation: fadeIn 0.8s ease;
            }
            .login-container h2 {
                margin-bottom: 25px;
                color: #222;
                font-size: 28px;
                font-weight: 700;
            }
            .login-container input[type="text"],
            .login-container input[type="password"] {
                width: 90%;
                padding: 14px;
                margin: 10px 0;
                border: none;
                border-radius: 12px;
                background-color: rgba(255, 255, 255, 0.95);
                font-size: 15px;
                box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
                outline: none;
                transition: box-shadow 0.2s ease;
            }
            .login-container input:focus {
                box-shadow: 0 0 6px #f67c0f;
            }
            .login-container input::placeholder {
                color: #777;
            }
            .login-container button {
                width: 100%;
                padding: 14px;
                background: linear-gradient(135deg, #f67c0f, #ff9f45);
                color: white;
                border: none;
                border-radius: 12px;
                font-size: 17px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 8px;
            }
            .login-container button:hover {
                background: linear-gradient(135deg, #ff944d, #ffb366);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(255, 153, 51, 0.5);
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.9);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }
        </style>
        
    </head>
    <body>
        <div class="overlay"></div>

        <div class="login-container">
            <h2>Login</h2>
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div style="color: red; font-weight: bold; margin-bottom: 15px;">
                    <%= error %>
                </div>
            <%
                }
            %>
            <form action="UserController" method="post">
                <input type="text" name="username" placeholder="Username" required />
                <input type="password" name="password" placeholder="Password" required />
                <button type="submit">Login</button>
            </form>
        </div>
    </body>
</html>
