% include('header.tpl')
<style>
    /* Harmonisation avec le design premium 2026 */
    @import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;700&display=swap");

    * { font-family: 'Inter', sans-serif; }

    body {
        background-color: #050505;
        color: #e0e0e0;
    }

    .container {
        max-width: 1400px;
        padding: 40px 20px;
    }

    /* Carte de recherche centrée */
    .search-container {
        background: #0f0f0f;
        border: 1px solid #1e1e1e;
        border-radius: 20px;
        padding: 40px;
        max-width: 800px;
        margin: 0 auto 50px auto;
        box-shadow: 0 20px 50px rgba(0,0,0,0.5);
        text-align: center;
    }

    .search-title {
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 10px;
        color: #ffffff;
    }

    .stats-text {
        color: #888;
        margin-bottom: 30px;
    }

    .text-red-500 {
        color: #ff4d4d !important;
        font-weight: 700;
    }

    /* Input de recherche stylisé */
    .search {
        background-color: #121212 !important;
        border: 1px solid #2a2a2a !important;
        border-radius: 12px !important;
        color: white !important;
        padding: 15px 20px !important;
        font-family: 'JetBrains Mono', monospace !important;
        font-size: 16px;
        width: 100% !important;
        transition: all 0.3s ease;
        outline: none;
    }

    .search:focus {
        border-color: #7F0000 !important;
        box-shadow: 0 0 0 4px rgba(127, 0, 0, 0.15);
        background-color: #161616 !important;
    }

    .btn {
        background: linear-gradient(135deg, #7F0000 0%, #4d0000 100%) !important;
        border: none !important;
        border-radius: 12px !important;
        padding: 14px 40px !important;
        font-weight: 600 !important;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: white;
        cursor: pointer;
        transition: all 0.3s ease !important;
        margin-top: 20px;
    }

    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(127, 0, 0, 0.4);
        filter: brightness(1.1);
    }

    /* Tableau de résultats */
    .results-card {
        background: #0f0f0f;
        border: 1px solid #1e1e1e;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    }

    table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }

    th {
        background-color: #161616 !important;
        color: #666 !important;
        font-size: 0.75rem !important;
        text-transform: uppercase;
        letter-spacing: 0.1em;
        padding: 18px 20px !important;
        border-bottom: 1px solid #222 !important;
    }

    td {
        padding: 16px 20px !important;
        border-bottom: 1px solid #161616 !important;
        font-family: 'JetBrains Mono', monospace;
        font-size: 0.9rem;
        color: #ccc;
    }

    tr:hover td {
        background-color: rgba(255, 255, 255, 0.02) !important;
        color: #fff;
    }

    .data-column {
        white-space: normal;
        word-wrap: break-word;
        overflow-wrap: break-word;
    }

    .no-results {
        color: #888;
        text-align: center;
        padding: 40px;
        font-style: italic;
    }
</style>

<div class="container">
    <div class="search-container">
        <h4 class="search-title">SQL / CSV / JSON Lookup</h4>
        <p class="stats-text">Search within <b class="text-red-500">{{count}}</b> lines of structured data.</p>

        <form id="searchForm" method="GET" action="/miscsearch">
            <div class="text-left">
                <label for="search" class="small text-uppercase tracking-wider text-gray-500 mb-2 d-block">Search Term</label>
                <input id="search" name="search" type="text" placeholder="domain, name, or specific identifier..." class="search" required>
            </div>
            <input type="submit" value="Start Search" class="btn" />
        </form>
    </div>

    % if query:
    <div class="max-w-5xl mx-auto">
        % if results:
        <div class="results-card">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 50%;">Raw Data</th>
                            <th style="width: 30%;">Source Leak</th>
                            <th style="width: 20%;">Discovery Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        % for result in results:
                        <tr>
                            <td class="data-column">{{result['donnee']}}</td>
                            <td class="data-column opacity-75">{{result['leak_name']}}</td>
                            <td class="data-column small">{{result['leak_date']}}</td>
                        </tr>
                        % end
                    </tbody>
                </table>
            </div>
        </div>
        % else:
        <div class="no-results">
            <p>No matches found for "{{query}}". Try a different keyword.</p>
        </div>
        % end
    </div>
    % end
</div>

% include('footer.tpl')