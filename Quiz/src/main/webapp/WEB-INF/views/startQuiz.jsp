<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Start Quiz</title>
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
        <p><%= message %></p>  <!-- Display the message if it exists -->
    <%
        }
    %>

    <form action="/" method="get">
        <input type="submit" value="Go Back">
    </form>
</body>
</html>
