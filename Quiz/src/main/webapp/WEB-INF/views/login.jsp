<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: white;
                      background-size: cover; /* Cover the entire screen */
            background-position: center; /* Center the image */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent white */
            padding: 40px; /* Increased padding for better spacing */
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        h2 {
            color: #002244; /* Green color */
            margin-bottom: 20px;
            font-size: 28px;
        }

        label {
            color: #333;
            font-size: 14px;
            margin-bottom: 8px;
            display: block; /* Make labels block elements */
            text-align: left; /* Align text to the left */
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0 20px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #33cc33; /* Change border color to green on focus */
            outline: none;
            box-shadow: 0 0 5px rgba(51, 204, 51, 0.3); /* Green glow effect */
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #003366; /* Dark blue button */
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #002244; /* Darker blue on hover */
        }

        .error-message {
            color: #ff4d4f;
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>
    <form action="/login" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Login</button>

        <!-- Display error message if present -->
        <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
        %>
        <div class="error-message"><%= error %></div>
        <%
        }
        %>
    </form>
</div>
</body>
</html>
