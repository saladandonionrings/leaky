% include("header-log")
<style>
body {
    padding-top: 15px;
    background-color: #111;
    color: #fff;  
}

/* Custom styles for the login form */
form {
    width: 300px;
    margin: 0 auto;
    padding: 20px;
    background-color: #333333; 
    border-radius: 10px;
    color: #fff; 
}

input[type="submit"] {
    background-color: #7F0000; 
    color: #fff; 
}

input[type="submit"]:hover {
    background-color: #BFBFBF; 
}

.error {
    color: red; 
}
</style>

<form method="post" action="/login">
    <label for="password">Password</label>
    <input type="password" name="password" required>
    <input type="submit" value="Login">
</form>


% if failed:
    <p class="error">Incorrect credentials</p>
% end


