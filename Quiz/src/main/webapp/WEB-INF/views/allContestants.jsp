<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Quiz.model.Contestant" %>
<html>
<head>
    <title>All Contestants</title>
</head>
<body>
    <h1>All Contestants and Their Scores</h1>

    <form action="/allContestants" method="post">
        <!-- You can add any form elements here if needed -->
    </form>

    <%
        // Assuming 'contestants' is an attribute passed from the controller
        List<Contestant> contestants = (List<Contestant>) request.getAttribute("contestants");
        if (contestants != null && !contestants.isEmpty()) {
            for (Contestant contestant : contestants) {
    %>
                <p>Username: <%= contestant.getUsername() %>, Marks: <%= contestant.getMarks() %></p>
    <%
            }
        } else {
    %>
            <p>No contestants available.</p>
    <%
        }
    %>

    <form action="/" method="get">
        <input type="submit" value="Go Back">
    </form>
</body>
</html>
