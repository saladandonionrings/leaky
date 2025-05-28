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
    .btn {
        background-color: #444444;
        border: 1px solid #333333;
        border-radius: 8px;
        padding: 12px 20px;
        color: white;
        cursor: pointer;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    .btn:hover {
        background-color: #555555;
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

    .text-red {
        color: #FF5555;
    }

</style>

<div class="flex flex-col items-center bg-[#111111] text-white py-8 px-6 rounded-xl shadow-lg">
  <h4 class="text-3xl font-semibold mb-4">List of Leaks</h2>
  <p class="text-lg mb-4">List of the different aggregated leaks and files in the database.</p>
  <p class="text-lg mb-6"> <b class="text-red">{{ nbLeaks }}</b> indexed leaks</p>

  <!-- Table for Credentials -->
  <h3 class="text-2xl mb-4">Credentials</h3>
  <div class="overflow-x-auto rounded-lg border border-gray-800 shadow-md mb-8">
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Number of Credentials</th>
          <th>Date</th>
          <th>Delete</th>
        </tr>
      </thead>
      <tbody>
        % for leak in creds_leaks_info:
        <tr>
          <td class="table-cell-content">{{ leak["name"] }}</td>
          <td class="table-cell-content">{{ leak["imported"] }}</td>
          <td class="table-cell-content">{{ leak["date"] }}</td>
          <td><a href="/removeLeak?id={{ leak["id"] }}" class="text-red">❌</a></td>
        </tr>
        % end
      </tbody>
    </table>
  </div>
<br>
  <!-- Table for Phone Numbers -->
  <h3 class="text-2xl mb-4">Phone Numbers</h3>
  <div class="overflow-x-auto rounded-lg border border-gray-800 shadow-md mb-8">
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Number of Phone Numbers</th>
          <th>Date</th>
          <th>Delete</th>
        </tr>
      </thead>
      <tbody>
        % for leak in phone_leaks_info:
        <tr>
          <td class="table-cell-content">{{ leak["name"] }}</td>
          <td class="table-cell-content">{{ leak["imported"] }}</td>
          <td class="table-cell-content">{{ leak["date"] }}</td>
          <td><a href="/removeLeak?id={{ leak["id"] }}" class="text-red">❌</a></td>
        </tr>
        % end
      </tbody>
    </table>
  </div>
<br>
  <!-- Table for Misc Files -->
  <h3 class="text-2xl mb-4">Misc Files (SQL, CSV, JSON)</h3>
  <div class="overflow-x-auto rounded-lg border border-gray-800 shadow-md mb-8">
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Number of Lines</th>
          <th>Date</th>
          <th>Delete</th>
        </tr>
      </thead>
      <tbody>
        % for leak in miscfiles_leaks_info:
        <tr>
          <td class="table-cell-content">{{ leak["name"] }}</td>
          <td class="table-cell-content">{{ leak["imported"] }}</td>
          <td class="table-cell-content">{{ leak["date"] }}</td>
          <td><a href="/removeLeak?id={{ leak["id"] }}" class="text-red">❌</a></td>
        </tr>
        % end
      </tbody>
    </table>
  </div>
</div>

% include("footer")
