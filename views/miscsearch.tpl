% include('header.tpl')

<div class="jumbotron">
  <h2>SQL/CSV/JSON Lookup</h2>
  <p class="lead">Search within <b style="color: red;">{{count}}</b> lines of data</p>
<form id="searchForm" method="GET" action="/miscsearch">
  <p style="text-align: center;">
    <span style="display: inline-block; width: 50%;">
      <label for="search">Search term:</label>
      <input id="search" name="search" type="text" class="search" style="width: 100%; height: 60px; font-size: 25px;" placeholder="domain/name/phone" />
    </span>
  </p>

  <p style="text-align: center;">
    <input type="submit" value="Lookup" role="button" class="btn btn-lg btn-success" />
  </p>
  </form>

% if results:
    <table class="table-striped table table-hover">
        <thead>
            <tr>
                <th style="width: 80%;">Data</th>
                <th style="width: 15%;">Leak Name</th>
                <th style="width: 5%;">Date</th>
            </tr>
        </thead>
        <tbody>
            % for result in results:
            <tr>
                <!-- Apply the 'data-column' class to the 'td' element -->
                <td class="data-column">{{result['donnee']}}</td>
                <td>{{result['leak_name']}}</td>
                <td>{{result['leak_date']}}</td>
            </tr>
            % end
        </tbody>
    </table>
% else:
    <p>No results found.</p>
% end

