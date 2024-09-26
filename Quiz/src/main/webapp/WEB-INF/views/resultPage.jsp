<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Submit Quiz</title>
</head>
<body>
<h2>Submit Quiz</h2>

<form action="/submit" method="post">
    <label for="username">Enter your username:</label>
    <input type="text" id="username" name="username" required><br><br>

    <label for="marks">Enter your marks:</label>
    <input type="number" id="marks" name="marks" required><br><br>

    <input type="submit" value="Submit Quiz">
</form>


</body>
</html>
