% include("header")
<style>
    /* Base styles */
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
    /* Button styles */
    .btn-glow:hover {
        box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
    }
    .pages {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 20px 0;
        font-size: 16px;
        text-decoration: none;

    }

    .prev-page, .next-page {
        background-color: #444444;
        border: 1px solid #333333;
        border-radius: 8px;
        padding: 8px 16px;
        color: white;
        text-decoration: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .prev-page:hover, .next-page:hover {
        background-color: #555555;
        color: white;
        text-decoration: none;

    }

    .prev-page:disabled, .next-page:disabled {
        cursor: not-allowed;
        background-color: #333333;
        color: #777777;
    }


    .btn {
        background-color: #5d000d;
        border: 1px solid #333333;
        border-radius: 8px;
        padding: 12px 20px;
        color: white;
        cursor: pointer;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    .btn:hover {
        background-color: #3a0516;
    }

    .export-btn {
        text-decoration: none;
        padding: 10px 16px;
        font-size: 15px;
        background-color: #FF5555;
        border: none;
        color: #FFFFFF;
        cursor: pointer;
        transition: background-color 0.3s ease;
        box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
        margin-left: auto;
    }

    .export-btn:hover {
        background-color: #FF8888;
    }

    /* Table styles */
    table {
        width: 100%;
        border-collapse: collapse;
        color: #FFFFFF;
    }

    th, td {
        padding: 12px;
        text-align: left;
        color: #FFFFFF;
        border-bottom: 1px solid #333333;
    }

    th {
        background-color: #000000;
        font-weight: 600;
        text-transform: uppercase;
        border-bottom: 2px solid #444444;
    }

    tr:nth-child(even) {
        background-color: #222222;
    }

    tr:hover {
        background-color: #333333;
    }

    .table-cell-content {
        white-space: normal;
        word-wrap: break-word;
        overflow-wrap: break-word;
        max-width: 300px;
    }

    /* Pagination styles */
    .pagination-link {
        background-color: #444444;
        border: 1px solid #333333;
        border-radius: 8px;
        padding: 8px 16px;
        color: white;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .pagination-link:hover {
        background-color: #555555;
    }

    .pagination-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 20px;
    }

    /* Reduce input width */
    .search {
        background-color: #222222;
        border: 1px solid #333333;
        border-radius: 8px;
        color: white;
        padding: 12px;
        font-size: 16px;
        width: 50%;  /* Set width to 50% */
    }

    /* Ensure full width for smaller screens */
    @media (max-width: 768px) {
        .search {
            width: 100%;
        }
    }

    .search:focus {
        outline: none;
        border-color: #444444;
    }

</style>
<div class="flex h-full bg-[#111111] text-white">
  <h4 class="text-3xl font-semibold mb-4">Credentials Lookup</h4>
    <p class="text-lg mb-4">Search within <b class="text-red-500">{{ count }}</b> credentials</p>
    <div class="flex-1 p-8">
        <div class="max-w-[1400px] mx-auto">
            <!-- Search Section -->
            <div class="mb-8">
                <form id="searchForm" method="GET" action="/index" class="flex flex-wrap gap-4 justify-between">
                    <div class="w-full sm:w-1/3">
                        <label for="pInput" class="block text-gray-400 mb-2">Username/Email:</label><br>
                        <input id="pInput" type="text" name="p" placeholder="john.doe / john.doe@mail.org" class="search" />
                    </div>
                    <div class="w-full sm:w-1/3">
                        <label for="urlInput" class="block text-gray-400 mb-2">URL:</label><br>
                        <input id="urlInput" type="text" name="url" placeholder="https://example.com" class="search" />
                    </div>
                    <div class="w-full mt-4">
                        <input type="submit" value="Lookup" class="btn" />
                    </div>
                </form>
            </div>
        <!-- Results Section -->
        % if query and (query.get("search") or query.get("d") or query.get("p") or query.get("url") or query.get("leakname")):
        <div class="mb-6">
            % if total_filtered_results > 0:
                <b class="block text-xl text-red-500 mb-4">
                    Results: {{ "{:,}".format(total_filtered_results).replace(",", " ") if total_filtered_results >= 1000 else total_filtered_results }}
                </b><br>

                <nav class="pages">
                    <a href="?page={{prevPage}}&search={{query.get('search', '')}}&p={{query.get('p', '')}}&url={{query.get('url', '')}}&leakname={{query.get('leakname', '')}}" class="prev-page">Previous</a>
                    <span>Page {{page}} of {{total}}</span>
                    <a href="?page={{nextPage}}&search={{query.get('search', '')}}&p={{query.get('p', '')}}&url={{query.get('url', '')}}&leakname={{query.get('leakname', '')}}" class="next-page">Next</a>
                    <a href="/export?p={{ query['p'] }}&url={{ query['url'] }}" class="export-btn">Export</a>
                </nav>

                <!-- Table Section -->
                <div class="overflow-x-auto border border-gray-800 rounded-xl">
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 37%;">URL</th>
                                <th style="width: 20%;">Email</th>
                                <th style="width: 20%;">Password</th>
                                <th style="width: 13%;">Leak</th>
                                <th style="width: 10%;">Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            % for c in creds:
                            <tr>
                                <td><div class="table-cell-content">{{ c.get("url", "N/A") }}</div></td>
                                <td><div class="table-cell-content">{{ c["p"] }}</div></td>
                                <td><div class="table-cell-content">{{ c["P"] }}</div></td>
                                <td><div class="table-cell-content">{{ c["leakname"] }}</div></td>
                                <td><div class="table-cell-content">{{ c["date"] }}</div></td>
                            </tr>
                            % end
                        </tbody>
                    </table>
                </div>

                % if nbRes == 0:
                    <p class="text-center text-gray-400 text-lg mt-4">Nothing to see here.</p>
                % end

            % else:
                <p class="text-center text-gray-400 text-lg mt-4">No entry for "{{query.get('search') or query.get('p') or query.get('url') or query.get('leakname')}}".</p>
            % end
        % end


        </div>
    </div>
</div>
% include("footer")
