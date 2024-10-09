<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quiz Result</title>
</head>
<body>
    <h1>Quiz Results</h1>

    <%
        // Retrieve the marks from the request attributes
        Integer marks = (Integer) request.getAttribute("marks");
        String username = (String) request.getAttribute("username");

        if (marks != null) {
    %>
        <h2>Thank you, <%= username %>!</h2>
        <p>Your total marks: <%= marks %></p>
    <% } else { %>
        <p>There was an error retrieving your results. Please try again.</p>
    <% } %>

    <form action="/quiz" method="get">
        <input type="submit" value="Back to Home">
    </form>
</body>
</html>
