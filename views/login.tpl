<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Leaks Login</title>
<style>
    /* Base styles */
    @import url("https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&display=swap");
    * {
        font-family: "JetBrains Mono", monospace;
    }

    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background-color: #000000;
        color: #FFFFFF;
    }

    form {
        width: 100%;
        max-width: 400px;
        padding: 20px 30px;
        background-color: #222222;
        border: 1px solid #333333;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.7);
    }

    form label {
        display: block;
        font-size: 16px;
        margin-bottom: 10px;
        color: #AAAAAA;
    }

    form input[type="password"] {
        width: 90%;
        margin: auto;
        padding: 12px;
        font-size: 16px;
        background-color: #333333;
        color: #FFFFFF;
        border: 1px solid #444444;
        border-radius: 8px;
        margin-bottom: 20px;
        outline: none;
        transition: border-color 0.3s ease;
    }

    form input[type="password"]:focus {
        border-color: #555555;
    }

    form input[type="submit"] {
        width: 100%;
        padding: 12px;
        font-size: 16px;
        background-color: #7F0000;
        color: #FFFFFF;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    form input[type="submit"]:hover {
        background-color: #B22222;
        box-shadow: 0 0 10px rgba(255, 0, 0, 0.3);
    }

    .error {
        margin-top: 20px;
        color: #FF5555;
        font-size: 14px;
        text-align: center;
    }
</style>
    </head>
<div>
    <form method="post" action="/login">
        <label for="password">Access to leaky</label>
        <input id="password" type="password" name="password" required placeholder="Password">
        <input type="submit" value="Login">
    </form>

    % if failed:
        <p class="error">Incorrect credentials</p>
    % end
</div>
