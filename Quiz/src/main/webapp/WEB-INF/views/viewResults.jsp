<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.Quiz.model.Contestant" %>
<html>
<head>
    <title>View Quiz Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 50%;
            margin-bottom: 20px;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: block;
            margin: 0 auto;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .result-container {
            background-color: #e0f7fa;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            width: 50%;
            text-align: center;
        }
        .result-container p {
            font-size: 18px;
            color: #555;
        }
    </style>
</head>
<body>
    <h1>Quiz Result</h1>
    <form action="/view-results" method="post">
        <input type="text" name="username" placeholder="Enter Username" required>
        <input type="submit" value="View Result">
    </form>
    <%
        Contestant contestant = (Contestant) request.getAttribute("contestant");
        if (contestant != null) {
    %>
        <div class="result-container">
            <p>Username: <%= contestant.getUsername() %></p>
            <p>Marks: <%= contestant.getMarks() %></p>
        </div>
    <%
        }
    %>
     <form action="/quiz" method="get">
            <input type="submit" value="Back to Home">
        </form>
</body>
</html>
