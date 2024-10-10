<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quiz Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        .result {
            font-size: 20px;
            margin-top: 20px;
        }
        .back-button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Quiz Completed</h1>
    <div class="result">
        <p>Thank you, <%= request.getAttribute("username") %>!</p>
        <p>Your score is: <%= request.getAttribute("marks") %> marks</p>
    </div>
    <form action="/quiz" method="get">
        <button type="submit" class="back-button">Back to Home</button>
    </form>
</body>
</html>
