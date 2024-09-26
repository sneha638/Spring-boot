<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome to the Quiz Application</title>
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
