<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.Quiz.model.Question" %>
<html>
<head>
    <title>Quiz Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .disabled {
            background-color: #ddd;
            color: #888;
            cursor: not-allowed;
            border: none;
        }

        .timeout-message {
            color: red;
            font-weight: bold;
            text-align: center;
        }

        .timer {
            font-size: 20px;
            color: green;
            text-align: center;
        }

        .quiz-form {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin: 10px 0;
        }

        input[type="radio"] {
            margin-right: 10px;
        }

        .pagination {
            text-align: center;
            margin: 20px 0;
        }

        input[type="submit"] {
            background-color: #003366; /* Dark blue */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin: 5px;
        }

        input[type="submit"]:hover {
            background-color: #002244; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <h1>Quiz Questions</h1>

    <%
        // Server-side logic for managing the timer
        Long quizStartTime = (Long) session.getAttribute("quizStartTime");
        if (quizStartTime == null) {
            quizStartTime = System.currentTimeMillis();
            session.setAttribute("quizStartTime", quizStartTime);
        }

        // Total time allowed for the quiz in milliseconds (e.g., 2 minutes = 120000 ms)
        Long totalQuizTime = 60000L; // 1 minute
        Long elapsedTime = System.currentTimeMillis() - quizStartTime;
        Long remainingTime = totalQuizTime - elapsedTime;

        if (remainingTime <= 0) {
    %>
        <!-- If time is up, show timeout message -->
        <div class="timeout-message">Time out! Please restart the quiz.</div>
        <form action="/quiz" method="get">
            <input type="submit" value="Back to Home">
        </form>
    <% } else { %>
        <!-- Display the remaining time -->
        <div class="timer">Time Remaining: <%= remainingTime / 1000 %> seconds</div>

        <!-- Quiz form that handles option selection and submission -->
        <div class="quiz-form">
            <form id="quiz-form" action="/submit-quiz" method="post">
                <%
                // Display the current question
                Question currentQuestion = (Question) request.getAttribute("currentQuestion");
                Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");

                String selectedAnswer = (String) session.getAttribute("question_" + currentQuestion.getId());
                %>

                <% if (currentQuestion != null && currentPage != null) { %>
                    <div>
                        <h3>Question <%= currentPage + 1 %> of <%= totalPages %></h3>
                        <h3><%= currentQuestion.getQuestion() %></h3>

                        <label>
                            <input type="radio" value="1" name="selectedAnswer" <% if ("1".equals(selectedAnswer)) { %> checked <% } %> required> <%= currentQuestion.getOption1() %>
                        </label>
                        <label>
                            <input type="radio" value="2" name="selectedAnswer" <% if ("2".equals(selectedAnswer)) { %> checked <% } %> required> <%= currentQuestion.getOption2() %>
                        </label>
                        <label>
                            <input type="radio" value="3" name="selectedAnswer" <% if ("3".equals(selectedAnswer)) { %> checked <% } %> required> <%= currentQuestion.getOption3() %>
                        </label>
                <% } else { %>
                    <p>No questions available at this time.</p>
                <% } %>
            </form>

            <!-- Pagination for navigating between questions -->
            <div class="pagination">
                <!-- Previous Button (Separate form to avoid validation) -->
                <form action="/start" method="post" style="display:inline;" onsubmit="document.getElementById('quiz-form').noValidate = true;">
                    <input type="hidden" name="username" value="<%= request.getAttribute("username") %>" />
                    <input type="hidden" name="page" value="<%= Math.max(currentPage - 1, 0) %>" />
                    <input type="submit" value="Previous" <% if (currentPage <= 0) { %> class="disabled" disabled <% } %> />
                </form>

                <!-- Next Button (Separate form to avoid validation) -->
                <form action="/start" method="post" style="display:inline;" onsubmit="document.getElementById('quiz-form').noValidate = true;">
                    <input type="hidden" name="username" value="<%= request.getAttribute("username") %>" />
                    <input type="hidden" name="page" value="<%= currentPage + 1 %>" />
                    <input type="submit" value="Next" <% if (currentPage >= totalPages - 1) { %> class="disabled" disabled <% } %> />
                </form>

                <!-- Submit Button on the Last Page (Validates and submits the form) -->
                <% if (currentPage >= totalPages - 1) { %>
                    <form id="submit-quiz-form" action="/submit-quiz" method="post" style="display:inline;">
                        <input type="hidden" name="username" value="<%= request.getAttribute("username") %>" />
                        <input type="submit" value="Submit Quiz" />
                    </form>
                <% } %>
            </div>

            <!-- Back to Home Button -->
            <form action="/quiz" method="get" style="text-align: center;">
                <input type="submit" value="Back to Home">
            </form>
        </div>
    <% } %>

</body>
</html>
