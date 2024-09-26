<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Question</title>
</head>
<body>
    <h1>Add a New Question</h1>

    <!-- Display success or failure message -->
    <c:if test="${not empty message}">
        <p style="color: green;">${message}</p>
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


    <!-- Optional back button if needed -->

        <input type="submit" value="Go Back" formaction="welcome">
    </form>
</body>
</html>
