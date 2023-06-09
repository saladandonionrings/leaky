% include("header")

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
