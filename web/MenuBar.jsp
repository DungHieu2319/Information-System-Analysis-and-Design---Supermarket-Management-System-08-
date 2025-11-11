<%-- 
    Document   : MenuBar
    Created on : Nov 11, 2025, 1:56:46 PM
    Author     : Tran Tien Dung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="menubar">
    <div class="menubar-left">
        <img src="Images/supermarket_icon.png" alt="Icon" />
        <span>HN Supermarket</span>
    </div>
    
    <div class="menubar-right">
        <form action="Login.jsp" method="get">
            <button type="submit" class="login-btn">Login</button>
        </form>
    </div>
</div>

<style>
    .menubar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: rgba(255, 255, 255, 0.7);
        -webkit-backdrop-filter: blur(10px);
        padding: 10px 40px;
        font-family: 'Segoe UI', sans-serif;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        border-bottom: 1px solid rgba(0,0,0,0.08);
    }
    
    .menubar-left {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .menubar-left img {
        width: 38px;
        height: 38px;
        vertical-align: middle;
    }
    .menubar-left span {
        font-size: 20px;
        font-weight: bold;
        color: #2c3e50;
        line-height: 40px;
    }
    
    .login-btn {
        background: linear-gradient(90deg, #ff914d, #ffb347);
        border: none;
        padding: 8px 16px;
        color: white;
        font-weight: bold;
        border-radius: 6px;
        cursor: pointer;
        transition: 0.3s;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    .login-btn:hover {
        background: linear-gradient(90deg, #ffa95f, #ffd27f);
        transform: translateY(-2px);
    }
</style>
