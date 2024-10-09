<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Quiz.model.Contestant" %>
<html>
<head>
    <title>All Contestants</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff; /* Light blue background for consistency */
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            color: #333;
        }

        .contestant-list {
            width: 60%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .contestant {
            padding: 10px;
            margin-bottom: 10px;
            background-color: #f1f1f1;
            border-radius: 5px;
        }

        p {
            font-size: 16px;
            color: #555;
        }

        input[type="submit"] {
            background-color: #003366; /* Dark blue */
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: block;
            margin: 0 auto; /* Center the button */
        }

        input[type="submit"]:hover {
            background-color: #002244; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <h1>All Contestants and Their Scores</h1>

    <div class="contestant-list">
        <%
            List<Contestant> contestants = (List<Contestant>) request.getAttribute("contestants");
            if (contestants != null && !contestants.isEmpty()) {
                for (Contestant contestant : contestants) {
        %>
                    <div class="contestant">
                        <p>Username: <%= contestant.getUsername() %>, Marks: <%= contestant.getMarks() %></p>
                    </div>
        <%
                }
            } else {
        %>
                <p>No contestants available.</p>
        <%
            }
        %>
    </div>

    <form action="/quiz" method="get">
        <input type="submit" value="Back to Home">
    </form>
</body>
</html>
