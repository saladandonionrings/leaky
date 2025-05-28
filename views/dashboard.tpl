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
        background-color: #444444;
        border: 1px solid #333333;
        border-radius: 8px;
        padding: 12px 20px;
        color: white;
        cursor: pointer;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    .btn:hover {

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

    /* Input fields */
    .search {
        background-color: #222222;
        border: 1px solid #333333;
        border-radius: 8px;
        color: white;
        padding: 12px;
        font-size: 16px;
        width: 100%;
    }

    .search:focus {
        outline: none;
        border-color: #555555;
    }

</style>
<!-- Jumbotron -->
<div class="jumbotron">
  <h2>Lookup</h2>
  <p class="lead">Search within <b style="color: red;">{{count}} credentials</b> in the database.</p>
  <form id="searchForm" method="GET" action="/index">
    <p><input id="dInput" type="text" class="search" style="width:100%;height:60px;font-size:25px;" name="d" placeholder="domain" /></p>
    <p><input id="pInput" type="text" class="search" style="width:100%;height:60px;font-size:25px;" name="p" placeholder="name"/></p>

    <p><input type="submit" value="Lookup" role="button" class="btn btn-lg btn-success"/></p>
  </form>

  <b class="nb">
    Results: <span style="color: red;">{{ nbRes }}</span>
  </b><br>


  <script>
    window.onload = function() {
      var urlParams = new URLSearchParams(window.location.search);
      var dParam = urlParams.get('d');
      var pParam = urlParams.get('p');
      var dateParam = urlParams.getAll('date');
      var pageParam = urlParams.get('page');
      document.getElementById('dInput').value = dParam ? dParam : '';
      document.getElementById('pInput').value = pParam ? pParam : '';

      var form = document.getElementById('searchForm');

      var pageInput = document.createElement('input');
      pageInput.type = 'hidden';
      pageInput.name = 'page';
      pageInput.value = pageParam ? pageParam : '1';
      form.appendChild(pageInput);

      var paginationLinks = document.getElementsByClassName('pagination-link');
      console.log(paginationLinks.length + " pagination links found");
      for (var i = 0; i < paginationLinks.length; i++) {
        paginationLinks[i].addEventListener('click', function(e) {
          console.log("Pagination link clicked");
          e.preventDefault();
          var newPage = this.getAttribute('data-page');
          console.log("Setting page to " + newPage);
          pageInput.value = newPage;
          form.submit();
        });
      }
    }

  </script>

  <br><a href="/export?d={{ query['d'] }}&p={{ query['p'] }}&leakname={{ query['leakname'] }}" class="export-btn">Export</a>
</div>
<div style="text-align: right;">
  <p class="page">Pages : {{page}} / {{total}} </p>
  <button class="pagination-link" data-page="{{prevPage}}">Previous</button>
  <button class="pagination-link" data-page="{{nextPage}}">Next</button>
</div>

<br>
<table class="table-striped table table-hover">
  <tr>
    <th><label>Email</label></th>
    <th><label>Password</label></th>
    <th><label>Leak</label></th>
    <th><label>Date</label></th>
  </tr>
  % for c in creds :
  <tr>
    <td><span class="email">{{c["p"]}}</span>@{{c["d"]}}</td>
    <td><span class="plain">{{c["P"]}}</span></td>
    <td><span class="leakname">{{c["leakname"]}}</span></td>
    <td><span class="date">{{c["date"]}}</span></td>
  </tr>
  % end
</table>
% end
