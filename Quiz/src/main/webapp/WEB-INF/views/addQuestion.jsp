<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Question</title>
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
            margin: 10px 0 5px;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
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
            color: green;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Add a New Question</h1>

    <!-- Display success or failure message -->
    <c:if test="${not empty message}">
        <p>${message}</p>
    </c:if>

    <form action="/add-question" method="post">
        <label for="question">Question:</label>
        <input type="text" id="question" name="question" required><br>

        <label for="option1">Option 1:</label>
        <input type="text" id="option1" name="option1" required><br>

        <label for="option2">Option 2:</label>
        <input type="text" id="option2" name="option2" required><br>

        <label for="option3">Option 3:</label>
        <input type="text" id="option3" name="option3" required><br>

        <label for="correctOption">Correct Option:</label>
        <input type="number" id="correctOption" name="correctOption" required min="1" max="3"><br>

        <input type="submit" value="Submit Question">
    </form>


    <form action="/quiz" method="get">
           <input type="submit" value="Back to Home">
       </form>
</body>
</html>
