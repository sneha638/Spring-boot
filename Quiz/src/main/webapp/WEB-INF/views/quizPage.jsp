<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Quiz.model.Question" %>
<html>
<head>
    <title>Quiz Page</title>
</head>
<body>
    <h1>Quiz Questions</h1>

    <form action="/submit-quiz" method="post">
        <%
            // Retrieve the list of questions from the request
            List<Question> questions = (List<Question>) request.getAttribute("questions");
            if (questions != null) {
                for (Question question : questions) {
        %>
                    <div>
                        <h3><%= question.getQuestion() %></h3>
                        <label>
                            <input type="radio" value="1" name="<%= question.getId() %>" required> <%= question.getOption1() %><br>
                        </label><br>
                        <label>
                            <input type="radio" value="2" name="<%= question.getId() %>" required> <%= question.getOption2() %><br>
                        </label><br>
                        <label>
                            <input type="radio" value="3" name="<%= question.getId() %>" required> <%= question.getOption3() %><br>
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
