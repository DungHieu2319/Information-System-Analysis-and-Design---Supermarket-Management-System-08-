<%-- 
    Document   : Welcome
    Created on : Nov 11, 2025, 1:56:16 PM
    Author     : Tran Tien Dung - B22DCAT054
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Page</title>
        
        <style>
            html, body {
                height: 100%;
                margin: 0;
            }
            body {
                background-image: url('Images/supermarket_bg.jpg');
                background-size: cover;
                background-position: center;
                font-family: 'Segoe UI', sans-serif;
                color: #f9f9f9;
            }
            .overlay {
                background-color: rgba(0,0,0,0.35);
                height: 100vh;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }
            .center-text {
                flex-grow: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                text-align: center;
                padding: 0 20px;
            }
            .center-text h1 {
                font-size: 26px;
                line-height: 1.8;
                max-width: 850px;
                color: #ffffff;
                text-shadow: 0 2px 6px rgba(0, 0, 0, 0.4);
            }
            footer {
                text-align: center;
                background-color: rgba(255, 255, 255, 0.2);
                -webkit-backdrop-filter: blur(8px);
                padding: 10px;
                font-size: 14px;
                color: #f8f8f8;
                border-top: 1px solid rgba(255,255,255,0.2);
            }
            footer b {
                color: #ffe082;
            }
        </style>
        
    </head>
    <body>
        <div class="overlay">
            <%@ include file="MenuBar.jsp" %>

            <div class="center-text">
                <h1>
                    Welcome to the <b>Supermarket Management System</b>!
                    <br>
                    <br>
                    This system was developed as a personal project for the course 
                    <b>Information System Analysis and Design</b>
                    <br>
                    under the guidance of <b>Dr. Đỗ Thị Bích Ngọc</b>.
                </h1>
            </div>

            <footer>
                ❤️ With our deepest gratitude and appreciation to  
                <b>Dr. Đỗ Thị Bích Ngọc</b> for her dedicated teaching and guidance. ❤️
            </footer>
        </div>
    </body>
</html>
