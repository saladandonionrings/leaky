% include('header.tpl')
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
        margin: 0 10px;
    }

    .prev-page:hover, .next-page:hover {
        background-color: #555555;
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

    #search {
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
        #search {
            width: 100%;
        }
    }

    #search:focus {
        outline: none;
        border-color: #444444;
    }

</style>

<div class="flex flex-col items-center bg-[#111111] text-white py-8 px-6 rounded-xl shadow-lg">
  <h4 class="text-3xl font-semibold mb-4">Phone Lookup</h4>
  <p class="text-lg mb-4">Search within <b class="text-red-500">{{ count }}</b> phone numbers</p>
  <form id="searchForm" method="GET" action="/phone" class="w-full max-w-lg">
    <div class="mb-6">
      <label for="search" class="block text-sm font-medium text-gray-300 mb-2">Phone number:</label><br>
      <input id="search" name="search" type="text" placeholder="(609) 415-6122"
             class="block w-full px-4 py-2 text-lg text-gray-300 bg-black border border-gray-700 rounded-md shadow-sm focus:ring focus:ring-gray-800 focus:outline-none">
    </div>
    <div class="w-full mt-4">
        <input type="submit" value="Lookup" class="btn" />
    </div>
  </form>
</div>

% if query:
  <div class="mt-8 max-w-5xl mx-auto">
    % if results:
      <div class="overflow-x-auto rounded-lg border border-gray-800 shadow-md">
        <table class="w-full table-fixed">
          <thead class="bg-black sticky top-0">
            <tr>
              <th class="w-1/3 py-3 px-6 text-left text-gray-400 font-normal text-lg border-b border-gray-800">Phone Number</th>
              <th class="w-1/3 py-3 px-6 text-left text-gray-400 font-normal text-lg border-b border-gray-800">Leak Name</th>
              <th class="w-1/3 py-3 px-6 text-left text-gray-400 font-normal text-lg border-b border-gray-800">Date</th>
            </tr>
          </thead>
          <tbody>
            % for result in results:
            <tr class="border-b border-gray-800 hover:bg-gray-900">
              <td class="py-3 px-6 text-gray-300">{{ result['phone'] }}</td>
              <td class="py-3 px-6 text-gray-300">{{ result['leak_name'] }}</td>
              <td class="py-3 px-6 text-gray-300">{{ result['leak_date'] }}</td>
            </tr>
            % end
          </tbody>
        </table>
      </div>
    % else:
      <p class="text-gray-400 text-center mt-4">No results found.</p>
    % end
  </div>
% end

% include('footer.tpl')

