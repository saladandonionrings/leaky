% include("header")
<style>
    /* Intégration des polices modernes */
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

    /* En-tête de page */
    .page-header {
        text-align: center;
        margin-bottom: 50px;
    }

    .stats-badge {
        background: rgba(127, 0, 0, 0.1);
        border: 1px solid rgba(127, 0, 0, 0.3);
        color: #ff4d4d;
        padding: 8px 20px;
        border-radius: 30px;
        font-weight: 700;
        display: inline-block;
        margin-top: 10px;
    }

    /* Section Titres */
    .section-title {
        font-size: 1.5rem;
        font-weight: 700;
        margin: 40px 0 20px 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .section-title::before {
        content: '';
        display: inline-block;
        width: 4px;
        height: 24px;
        background: #7F0000;
        border-radius: 2px;
    }

    /* Tableaux modernisés */
    .table-card {
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

    tr:last-child td { border-bottom: none; }

    tr:hover td {
        background-color: rgba(255, 255, 255, 0.02) !important;
        color: #fff;
    }

    .text-red {
        color: #ff4d4d !important;
        text-decoration: none;
        transition: opacity 0.2s;
    }

    .text-red:hover {
        opacity: 0.7;
    }

    .count-cell {
        font-weight: 700;
        color: #7F0000 !important;
    }

</style>

<div class="container">
    <div class="page-header">
        <h4 class="text-4xl font-bold m-0">Leak Inventory</h4>
        <p class="text-gray-500 mt-2">Inventory of aggregated files within the database.</p>
        <div class="stats-badge">{{ nbLeaks }} indexed leaks</div>
    </div>

    <h3 class="section-title">Credentials</h3>
    <div class="table-card">
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th style="width: 40%;">Leak Name</th>
                        <th style="width: 25%;">Entry Count</th>
                        <th style="width: 20%;">Added Date</th>
                        <th style="width: 15%; text-align: center;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    % for leak in creds_leaks_info:
                    <tr>
                        <td>{{ leak["name"] }}</td>
                        <td class="count-cell">{{ leak["imported"] }}</td>
                        <td>{{ leak["date"] }}</td>
                        <td style="text-align: center;">
                            <a href="/removeLeak?id={{ leak['id'] }}" class="text-red" title="Remove Leak">🗑️</a>
                        </td>
                    </tr>
                    % end
                </tbody>
            </table>
        </div>
    </div>

    <h3 class="section-title">Phone Numbers</h3>
    <div class="table-card">
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th style="width: 40%;">Leak Name</th>
                        <th style="width: 25%;">Records</th>
                        <th style="width: 20%;">Added Date</th>
                        <th style="width: 15%; text-align: center;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    % for leak in phone_leaks_info:
                    <tr>
                        <td>{{ leak["name"] }}</td>
                        <td class="count-cell">{{ leak["imported"] }}</td>
                        <td>{{ leak["date"] }}</td>
                        <td style="text-align: center;">
                            <a href="/removeLeak?id={{ leak['id'] }}" class="text-red">🗑️</a>
                        </td>
                    </tr>
                    % end
                </tbody>
            </table>
        </div>
    </div>

    <h3 class="section-title">Misc Files (SQL, CSV, JSON)</h3>
    <div class="table-card">
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th style="width: 40%;">File Name</th>
                        <th style="width: 25%;">Total Lines</th>
                        <th style="width: 20%;">Added Date</th>
                        <th style="width: 15%; text-align: center;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    % for leak in miscfiles_leaks_info:
                    <tr>
                        <td>{{ leak["name"] }}</td>
                        <td class="count-cell">{{ leak["imported"] }}</td>
                        <td>{{ leak["date"] }}</td>
                        <td style="text-align: center;">
                            <a href="/removeLeak?id={{ leak['id'] }}" class="text-red">🗑️</a>
                        </td>
                    </tr>
                    % end
                </tbody>
            </table>
        </div>
    </div>
</div>

% include("footer")