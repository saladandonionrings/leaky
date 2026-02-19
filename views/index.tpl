% include("header")
<style>
    @import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;700&display=swap");

    * { font-family: 'Inter', sans-serif; }

    body {
        background-color: #050505;
        color: #e0e0e0;
    }

    /* Section Recherche */
    .search-card {
        background: #0f0f0f;
        border: 1px solid #1e1e1e;
        border-radius: 20px;
        padding: 30px;
        margin-bottom: 30px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.4);
    }

    .search {
        background-color: #121212 !important;
        border: 1px solid #2a2a2a !important;
        border-radius: 10px !important;
        color: white !important;
        padding: 14px !important;
        font-family: 'JetBrains Mono', monospace !important;
        width: 100%;
        transition: all 0.3s ease;
    }

    .search:focus {
        border-color: #7F0000 !important;
        box-shadow: 0 0 0 4px rgba(127, 0, 0, 0.15);
        outline: none;
    }

    /* Style commun pour les boutons d'action (Audit & Export) */
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
        text-decoration: none !important;
        height: 42px; /* Hauteur fixe pour alignement parfait */
    }

    .action-control-btn:hover {
        background: #252525;
        border-color: #444;
        color: #fff;
    }

    .action-control-btn i {
        margin-right: 8px;
        font-size: 1rem;
    }

    /* État actif spécifique pour le mode Audit */
    .action-control-btn.active {
        border-color: #7F0000;
        color: #ff4d4d;
        background: rgba(127, 0, 0, 0.1);
        box-shadow: 0 0 15px rgba(127, 0, 0, 0.2);
    }

    /* Accentuation spécifique pour l'Export */
    .export-variant {
        color: #ff4d4d;
    }
    
    .export-variant:hover {
        background: rgba(255, 77, 77, 0.1);
        border-color: #7F0000;
    }

    /* Bouton Principal Lookup */
    .btn-lookup {
        background: linear-gradient(135deg, #7F0000 0%, #4d0000 100%) !important;
        border: none !important;
        border-radius: 10px !important;
        padding: 14px 30px !important;
        font-weight: 600 !important;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: white;
        transition: all 0.3s ease !important;
    }

    .btn-lookup:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(127, 0, 0, 0.4);
    }

    /* Tableau */
    .results-container {
        background: #0f0f0f;
        border: 1px solid #1e1e1e;
        border-radius: 16px;
        overflow: hidden;
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
        padding: 18px 15px !important;
        border-bottom: 1px solid #222 !important;
    }

    td {
        padding: 15px !important;
        border-bottom: 1px solid #161616 !important;
        font-family: 'JetBrains Mono', monospace;
        font-size: 0.9rem;
        color: #ccc;
    }

    tr:hover td {
        background-color: rgba(255, 255, 255, 0.02) !important;
        color: #fff;
    }

    .masked-text { filter: blur(4px); }

    .favicon-img {
        width: 18px;
        height: 18px;
        border-radius: 3px;
        margin-right: 10px;
        vertical-align: middle;
        opacity: 0.7;
    }

    .pages {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 15px;
        margin: 30px 0;
    }

    .prev-page, .next-page {
        background-color: #161616;
        border: 1px solid #2a2a2a;
        border-radius: 8px;
        padding: 10px 20px;
        color: white;
        text-decoration: none;
    }

    .text-red-500 { color: #ff4d4d !important; }
</style>

<div class="container-fluid py-5 px-4">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <div>
            <h4 class="text-4xl font-bold m-0">Credentials Lookup</h4>
            <p class="text-gray-500 mt-2">Search within <b class="text-red-500">{{ count }}</b> indexed credentials</p>
        </div>
        <div class="d-flex gap-3">
            <button id="toggleAudit" class="action-control-btn">
                <i class="fas fa-eye-slash"></i> Audit Mode
            </button>
            <a href="/export?p={{ query.get('p', '') }}&url={{ query.get('url', '') }}" class="action-control-btn export-variant">
                <i class="fas fa-file-csv"></i> Export CSV
            </a>
        </div>
    </div>

    <div class="search-card">
        <form id="searchForm" method="GET" action="/index" class="row align-items-end">
            <div class="col-md-5 mb-3 mb-md-0">
                <label for="pInput" class="small text-uppercase tracking-wider text-gray-500 mb-2 d-block">Username / Email</label>
                <input id="pInput" type="text" name="p" value="{{ query.get('p', '') }}" placeholder="john.doe@mail.org" class="search" />
            </div>
            <div class="col-md-5 mb-3 mb-md-0">
                <label for="urlInput" class="small text-uppercase tracking-wider text-gray-500 mb-2 d-block">Target URL</label>
                <input id="urlInput" type="text" name="url" value="{{ query.get('url', '') }}" placeholder="https://example.com" class="search" />
            </div>
            <div class="col-md-2">
                <input type="submit" value="Lookup" class="btn-lookup w-100" />
            </div>
        </form>
    </div>

    % if query and (query.get("search") or query.get("d") or query.get("p") or query.get("url") or query.get("leakname")):
    <div class="mt-5">
        % if total_filtered_results > 0:
            <div class="mb-4">
                <h5 class="m-0">
                    <span class="text-red-500 font-bold">{{ "{:,}".format(total_filtered_results).replace(",", " ") }}</span> matches found
                </h5>
            </div>

            <div class="results-container border border-gray-800">
                <div class="table-responsive">
                    <table id="resultsTable">
                        <thead>
                            <tr>
                                <th style="width: 35%;">URL</th>
                                <th style="width: 25%;">Email / Username</th>
                                <th style="width: 20%;">Password</th>
                                <th style="width: 10%;">Leak Source</th>
                                <th style="width: 10%;">Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            % for c in creds:
                            <tr>
                                <td>
                                    <div class="table-cell-content">
                                        <img class="favicon-img" src="https://www.google.com/s2/favicons?domain={{ c.get('url', 'unknown.com') }}&sz=32" onerror="this.src='https://cdn-icons-png.flaticon.com/512/1243/1243933.png'">
                                        <span class="text-info">{{ c.get("url", "N/A") }}</span>
                                    </div>
                                </td>
                                <td><div class="table-cell-content audit-target" data-full="{{ c['p'] }}">{{ c["p"] }}</div></td>
                                <td><div class="table-cell-content audit-target" data-full="{{ c['P'] }}" style="color: #ffaa00;">{{ c["P"] }}</div></td>
                                <td><div class="table-cell-content small opacity-75">{{ c["leakname"] }}</div></td>
                                <td><div class="table-cell-content small">{{ c["date"] }}</div></td>
                            </tr>
                            % end
                        </tbody>
                    </table>
                </div>
            </div>

            <nav class="pages">
                <a href="?page={{prevPage}}&p={{query.get('p', '')}}&url={{query.get('url', '')}}" class="prev-page {{'disabled' if page <= 1 else ''}}">← Prev</a>
                <span class="small text-gray-500">Page <b>{{page}}</b> of {{total}}</span>
                <a href="?page={{nextPage}}&p={{query.get('p', '')}}&url={{query.get('url', '')}}" class="next-page {{'disabled' if page >= total else ''}}">Next →</a>
            </nav>
        % else:
            <div class="text-center py-5">
                <p class="text-gray-400">No results found.</p>
            </div>
        % end
    </div>
    % end
</div>

<script>
    document.getElementById('toggleAudit').addEventListener('click', function() {
        this.classList.toggle('active');
        const targets = document.querySelectorAll('.audit-target');
        const isActive = this.classList.contains('active');

        targets.forEach(el => {
            const original = el.getAttribute('data-full');
            if (isActive && original.length > 4) {
                const visible = original.substring(0, 4);
                const hidden = original.substring(4);
                el.innerHTML = `${visible}<span class="masked-text">${hidden}</span>`;
            } else {
                el.innerHTML = original;
            }
        });
    });
</script>

% include("footer")