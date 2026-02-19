% include("header")
<style>
    @import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;700&display=swap");

    * { font-family: 'Inter', sans-serif; }

    body {
        background-color: #050505;
        color: #e0e0e0;
    }

    h1 {
        font-size: 3rem;
        font-weight: 800;
        letter-spacing: -1.5px;
        margin-bottom: 10px;
        background: linear-gradient(135deg, #fff 0%, #666 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .directory-subtitle {
        font-size: 1.1rem;
        color: #888;
        margin-bottom: 20px;
    }

    /* Style du bouton Audit (identique à index) */
    .action-control-btn {
        background: #1a1a1a;
        border: 1px solid #333;
        color: #eee;
        padding: 10px 18px;
        border-radius: 10px;
        cursor: pointer;
        font-size: 0.85rem;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        height: 42px;
    }

    .action-control-btn:hover { background: #252525; color: #fff; }
    
    .action-control-btn.active {
        border-color: #7F0000;
        color: #ff4d4d;
        background: rgba(127, 0, 0, 0.1);
        box-shadow: 0 0 15px rgba(127, 0, 0, 0.2);
    }

    .links-list {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 25px;
        margin-top: 20px;
    }

    .link-card {
        background: rgba(15, 15, 15, 0.6);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.05);
        border-radius: 20px;
        padding: 20px;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        display: flex;
        flex-direction: column;
        height: 100%;
    }

    .link-card:hover {
        transform: translateY(-10px);
        background: rgba(20, 20, 20, 0.8);
        border-color: rgba(127, 0, 0, 0.4);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.6);
    }

    .link-title-container {
        margin-bottom: 15px;
        min-height: 1.5rem;
    }

    .link-card .link-title {
        font-size: 1.25rem;
        font-weight: 700;
        color: #ffffff;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .link-card:hover .link-title { color: #ff4d4d; }

    .img-container {
        width: 100%;
        border-radius: 12px;
        overflow: hidden;
        margin-bottom: 15px;
        border: 1px solid #222;
        background: #000;
    }

    .link-card img {
        width: 100%;
        height: 180px;
        object-fit: cover;
        transition: transform 0.5s ease;
        opacity: 0.8;
    }

    .link-card:hover img { transform: scale(1.1); opacity: 1; }

    .link-description {
        font-size: 0.9rem;
        color: #888;
        line-height: 1.5;
        margin-top: auto;
    }

    .link-meta {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 15px;
        font-size: 0.7rem;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: #555;
    }

    .masked-text { filter: blur(6px); }
</style>

<div class="container-fluid py-5">
    <div class="mb-5 d-flex justify-content-between align-items-center">
        <div>
            <h1>Links Directory</h1>
            <p class="directory-subtitle">Curated list of external intelligence tools and platforms.</p>
        </div>
    </div>

    <div class="links-list">
        % for link in links:
            <div class="link-card">
                <div class="link-meta">
                    <span style="color: #7F0000;">●</span> External Resource
                </div>
                
                <div class="link-title-container">
                    <a href="{{ link['url'] }}" target="_blank" class="link-title audit-target" data-full="{{ link['title'] }}">
                        {{ link['title'] }}
                    </a>
                </div>
                
                <div class="img-container">
                    <img src="https://api.microlink.io/?url={{ link['url'] }}&screenshot=true&meta=false&embed=screenshot.url" alt="Preview">
                </div>
                
                <p class="link-description audit-target" data-full="{{ link['description'] }}">
                    {{ link['description'] }}
                </p>
            </div>
        % end
    </div>
</div>

% include("footer")