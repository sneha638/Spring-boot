<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.Quiz.model.Contestant" %>
<html>
<head>
    <title>View Quiz Result</title>
</head>
<body>
    <h1>Quiz Result</h1>

    <form action="/view-results" method="post">
        <input type="text" name="username" placeholder="Enter Username" required>
        <input type="submit" value="View Result">
    </form>
    ${contestant}
</body>
</html>
