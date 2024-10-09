<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome to the Quiz Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center; /* Center content vertically */
            height: 100vh; /* Full height */
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }
        form {
            margin: 10px 0;
        }
        input[type="submit"] {
            border: none;
            padding: 12px 24px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 200px;
        }
        /* Style for the centered 'Start Quiz' button */
        .highlight {
            background-color: #003366; /* Dark blue */
            color: white;
        }
        .highlight:hover {
            background-color: #002244; /* Darker blue on hover */
        }
        /* Style for subdued buttons */
        .subdued {
            background-color: #d3d3d3; /* Ash color */
            color: black;
        }
        .subdued:hover {
            background-color: #c0c0c0; /* Darker ash on hover */
        }
        /* Layout for buttons */
        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center; /* Center the start quiz button */
        }
        .view-buttons {
                   display: flex;
                   flex-direction: column; /* Stack buttons vertically */
                   align-items: flex-end; /* Align items to the right */
                   margin-top: 20px; /* Space between the buttons */
                   position: absolute; /* Position it absolutely */
                   top: 20px; /* Distance from the top */
                   right: 20px; /* Distance from the right */
               }
    </style>
</head>
<body>
    <h1>Welcome to the Quiz Application!</h1>

        <!-- Display the greeting message -->
        <%
            String username = (String) request.getAttribute("username"); // Retrieve the username from the request
            if (username != null) {
        %>
            <p>Hi <%= username %>, let's start the Quiz.<br>Good Luck!</p>
        <%
            }
        %>


    <div class="button-container">
        <form action="start-quiz" method="get">
            <input type="submit" value="Start Quiz" class="highlight">
        </form>
    </div>

    <div class="view-buttons">
        <form action="view-results" method="get">
            <input type="submit" value="View Result" class="subdued">
        </form>

        <form action="all-contestants" method="get">
            <input type="submit" value="View All Contestants" class="subdued">
        </form>

        <form action="add-question" method="get">
            <input type="submit" value="Add Questions" class="subdued">
        </form>

        <form action="logout" method="get">
            <input type="submit" value="Logout" class="subdued">
        </form>
    </div>
</body>
</html>
