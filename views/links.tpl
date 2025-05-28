% include("header")
<style>
    /* Harmonisation du style avec les autres pages */
    @import url("https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&display=swap");
    
    * {
        font-family: "JetBrains Mono", monospace;
    }

    body {
        background-color: #000000;
        color: #FFFFFF;
    }

    .container {
        max-width: 1400px;
        padding: 20px;
    }

    h1 {
        font-size: 2.5rem;
        font-weight: 600;
        margin-bottom: 20px;
    }

    .links-list {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 20px;
        margin-top: 20px;
    }

    .link-card {
        background-color: #111111;
        border: 1px solid #333;
        border-radius: 12px;
        padding: 20px;
        text-align: center;
        transition: transform 0.2s, box-shadow 0.3s;
        width: 300px;
    }

    .link-card:hover {
        transform: scale(1.05);
        box-shadow: 0 0 15px rgba(255, 255, 255, 0.1);
    }

    .link-card .link-title {
        display: block;
        font-size: 1.4rem;
        font-weight: bold;
        color: #FF5555;
        text-decoration: none;
        margin-bottom: 10px;
    }

    .link-card .link-title:hover {
        color: #FF8888;
    }

    .link-card img {
        border-radius: 8px;
        border: 1px solid #444;
        width: 100%;
        height: auto;
    }
    .link-description {
        font-size: 0.9rem;
        color: #BBBBBB;
        margin-top: 10px;
    }
</style>

<div class="container">
    <h1>Links Directory</h1>
    <p class="text-lg">Curated list of useful external links.</p>

    <div class="links-list">
        % for link in links:
            <div class="link-card">
                <a href="{{ link['url'] }}" target="_blank" class="link-title">{{ link['title'] }}</a>
                <img src="https://api.microlink.io/?url={{ link['url'] }}&screenshot=true&meta=false&embed=screenshot.url" alt="Thumbnail">
                <p class="link-description">{{ link['description'] }}</p>
            </div>
        % end
    </div>
</div>

% include("footer")
