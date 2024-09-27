<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Start Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
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
        label {
            font-size: 16px;
            color: #555;
            display: block;
            margin-bottom: 10px;
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
        p {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h1>Start the Quiz</h1>

    <form action="/start" method="post">
        <label for="username">Enter Username:</label>
        <input type="text" id="username" name="username" required><br>
        <input type="submit" value="Start Quiz">
    </form>

    <%
        // Check if there's a message attribute in the request
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <p style="color: green;"><%= message %></p>  <!-- Display the message if it exists -->
    <%
        }
    %>

    <form action="/quiz" method="get">
        <input type="submit" value="Back to Home">
    </form>
</body>
</html>