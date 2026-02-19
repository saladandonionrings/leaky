<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Leaks Login</title>
<style>
    /* Harmonisation avec le thème sombre moderne 2026 */
    @import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=JetBrains+Mono:wght@400;700&display=swap");

    * {
        box-sizing: border-box;
        font-family: 'Inter', sans-serif;
    }

    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background-color: #050505; /* Noir profond */
        color: #FFFFFF;
    }

    /* Conteneur du formulaire avec effet Glassmorphism */
    form {
        width: 100%;
        max-width: 400px;
        padding: 40px;
        background-color: #0f0f0f;
        border: 1px solid #1e1e1e;
        border-radius: 20px;
        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
        text-align: center;
    }

    form label {
        display: block;
        font-size: 1.2rem;
        font-weight: 600;
        margin-bottom: 25px;
        color: #ffffff;
        letter-spacing: -0.5px;
    }

    /* Champ password stylisé */
    form input[type="password"] {
        width: 100%;
        padding: 14px 18px;
        font-size: 16px;
        background-color: #161616;
        color: #FFFFFF;
        border: 1px solid #2a2a2a;
        border-radius: 12px;
        margin-bottom: 20px;
        outline: none;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        font-family: 'JetBrains Mono', monospace;
    }

    form input[type="password"]:focus {
        border-color: #7F0000;
        box-shadow: 0 0 0 4px rgba(127, 0, 0, 0.15);
        background-color: #1a1a1a;
    }

    /* Bouton de soumission avec dégradé */
    form input[type="submit"] {
        width: 100%;
        padding: 14px;
        font-size: 14px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        background: linear-gradient(135deg, #7F0000 0%, #4d0000 100%);
        color: #FFFFFF;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    form input[type="submit"]:hover {
        background: linear-gradient(135deg, #a30000 0%, #7F0000 100%);
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(127, 0, 0, 0.3);
    }

    /* Message d'erreur moderne */
    .error {
        margin-top: 20px;
        color: #FF5555;
        font-size: 14px;
        text-align: center;
        padding: 10px;
        background: rgba(255, 85, 85, 0.1);
        border-radius: 8px;
        border: 1px solid rgba(255, 85, 85, 0.2);
    }
</style>
    </head>
<body>
    <div>
        <form method="post" action="/login">
            <label for="password">Access to leaky_</label>
            <input id="password" type="password" name="password" required placeholder="Enter Access Password">
            <input type="submit" value="Authenticate">
            
            % if failed:
                <p class="error">Incorrect credentials</p>
            % end
        </form>
    </div>
</body>
</html>