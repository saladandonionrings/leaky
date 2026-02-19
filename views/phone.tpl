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

    /* Carte de recherche centrale */
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

    .lookup-title {
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 10px;
        color: #ffffff;
    }

    .stats-text {
        color: #888;
        margin-bottom: 30px;
        font-size: 1.1rem;
    }

    .text-red-500 {
        color: #ff4d4d !important;
        font-weight: 700;
    }

    /* Champ de saisie stylisé */
    #search {
        background-color: #121212 !important;
        border: 1px solid #2a2a2a !important;
        border-radius: 12px !important;
        color: white !important;
        padding: 15px 20px !important;
        font-family: 'JetBrains Mono', monospace !important;
        font-size: 18px;
        width: 100% !important;
        transition: all 0.3s ease;
        outline: none;
        text-align: center;
    }

    #search:focus {
        border-color: #7F0000 !important;
        box-shadow: 0 0 0 4px rgba(127, 0, 0, 0.15);
        background-color: #161616 !important;
    }

    .btn {
        background: linear-gradient(135deg, #7F0000 0%, #4d0000 100%) !important;
        border: none !important;
        border-radius: 12px !important;
        padding: 14px 50px !important;
        font-weight: 600 !important;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: white;
        cursor: pointer;
        transition: all 0.3s ease !important;
        margin-top: 25px;
    }

    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(127, 0, 0, 0.4);
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
        padding: 18px 25px !important;
        border-bottom: 1px solid #222 !important;
    }

    td {
        padding: 16px 25px !important;
        border-bottom: 1px solid #161616 !important;
        font-family: 'JetBrains Mono', monospace;
        font-size: 1rem;
        color: #ccc;
    }

    .phone-cell {
        color: #ffaa00 !important; /* Couleur or pour les numéros */
        font-weight: 600;
    }

    tr:hover td {
        background-color: rgba(255, 255, 255, 0.02) !important;
        color: #fff;
    }

    .pagination-container {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 30px;
    }
</style>

<div class="container">
    <div class="search-container">
        <h4 class="lookup-title">Phone Lookup</h4>
        <p class="stats-text">Search within <b class="text-red-500">{{ count }}</b> indexed phone numbers</p>
        
        <form id="searchForm" method="GET" action="/phone">
            <div class="mb-4 text-left">
                <label for="search" class="small text-uppercase tracking-wider text-gray-500 mb-2 d-block text-center">Enter Number</label>
                <input id="search" name="search" type="text" placeholder="(609) 415-6122" required>
            </div>
            <input type="submit" value="Lookup" class="btn" />
        </form>
    </div>

    % if query:
    <div class="max-w-5xl mx-auto">
        % if results:
        <div class="results-card">
            <div class="table-responsive">
                <table class="w-full">
                    <thead>
                        <tr>
                            <th>Phone Number</th>
                            <th>Leak Source</th>
                            <th>Discovery Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        % for result in results:
                        <tr>
                            <td class="phone-cell">{{ result['phone'] }}</td>
                            <td class="opacity-75">{{ result['leak_name'] }}</td>
                            <td class="small opacity-60">{{ result['leak_date'] }}</td>
                        </tr>
                        % end
                    </tbody>
                </table>
            </div>
        </div>
        % else:
        <div class="text-center py-5">
            <p class="text-gray-500 italic">No records found for this phone number.</p>
        </div>
        % end
    </div>
    % end
</div>

% include('footer.tpl')