% include("header-log")
<style>
  body {
    background-color: #FFFFFF;
    font-family: Arial, sans-serif;
  }

  form {
    width: 300px;
    margin: 0 auto;
    padding: 20px;
    background-color: #FFF;
    border-radius: 10px;
    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
  }

  input[type="text"],
  input[type="password"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 5px;
    border: 1px solid #CCC;
  }

  input[type="submit"] {
    width: 100%;
    padding: 10px;
    background-color: #1971AC;
    color: #FFF;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }

  input[type="submit"]:hover {
    background-color: #488DBF;
  }
</style>

<form action="/login" method="post">
  <input type="text" name="username" placeholder="Username" required>
  <input type="password" name="password" placeholder="Password" required>
  <input type="submit" value="Log in">
</form>

% if failed:
    <p class="error">Incorrect credentials</p>
% end


