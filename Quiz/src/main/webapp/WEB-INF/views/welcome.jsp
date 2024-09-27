<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome to the Quiz Application</title>
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
        p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }
        form {
            margin: 10px 0;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 24px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 200px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Welcome to the Quiz Application!</h1>
    <p>Please choose an option below:</p>

    <form action="add-question" method="get">
        <input type="submit" value="Add Questions">
    </form>

    <form action="start-quiz" method="get">
        <input type="submit" value="Start Quiz">
    </form>

    <form action="view-results" method="get">
        <input type="submit" value="View Result">
    </form>

    <form action="all-contestants" method="get">
        <input type="submit" value="View All Contestants">
    </form>
</body>
</html>
