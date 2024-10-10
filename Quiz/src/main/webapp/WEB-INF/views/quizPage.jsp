<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Quiz.model.Question" %>
<html>
<head>
    <title>Quiz Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
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
            width: 60%;
            margin-bottom: 20px;
        }
        div {
            margin-bottom: 15px;
        }
        label {
            font-size: 16px;
            color: #555;
        }
        input[type="radio"] {
            margin-right: 10px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .timer {
            font-size: 20px;
            color: #d9534f;
            margin-bottom: 20px;
        }
    </style>

</head>
<body>
    <h1>Quiz Questions</h1>


    <form id="quiz-form" action="/submit-quiz" method="post">
        <%
            // Retrieve the list of questions from the request
            List<Question> questions = (List<Question>) request.getAttribute("questions");
            if (questions != null) {
                for (Question question : questions) {
        %>
                    <div>
                        <h3><%= question.getQuestion() %></h3>
                        <label>
                            <input type="radio" value="1" name="<%= question.getId() %>" required> <%= question.getOption1() %>
                        </label><br>
                        <label>
                            <input type="radio" value="2" name="<%= question.getId() %>" required> <%= question.getOption2() %>
                        </label><br>
                        <label>
                            <input type="radio" value="3" name="<%= question.getId() %>" required> <%= question.getOption3() %>
                        </label><br>
                    </div>
        <%
                }
            } else {
        %>
                <p>No questions available.</p>
        <%
            }
        %>
        <input type="hidden" name="username" value="<%= request.getAttribute("username") %>">
        <input type="submit" value="Submit Quiz">
    </form>

    <form action="/quiz" method="get">
        <input type="submit" value="Back to Welcome">
    </form>
</body>
</html>

