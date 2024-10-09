<head>
    <style>
        .error-message {
            color: red;
            font-size: 16px;
            font-weight: bold;
            margin-top: 20px;
            text-align: center;
        }
        .center-button {
            text-align: center;
            margin-top: 20px;
        }
        input[type="submit"] {
           background-color: #003366;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>
    <!-- Display error message if it exists -->
    <% if (request.getAttribute("errorMessage") != null) { %>
        <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <!-- Back to Home button -->
    <div class="center-button">
        <form action="/quiz" method="get">
            <input type="submit" value="Back to Home">
        </form>
    </div>
</body>
