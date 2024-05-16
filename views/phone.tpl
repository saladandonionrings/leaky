% include('header.tpl')

<div class="jumbotron">
  <h2>Phone Lookup</h2>
  <p class="lead">Search within <b style="color: red;">{{count}}</b> phone numbers</p>
<form id="searchForm" method="GET" action="/phone">
  <p style="text-align: center;">
    <span style="display: inline-block; width: 30%;">
      <label for="search">Phone number:</label>
      <input id="search" name="search" type="text" class="search" style="width: 100%; height: 60px; font-size: 25px;" placeholder="(609) 415-6122" />
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
                <th>Phone Number</th>
                <th>Leak Name</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            % for result in results:
            <tr>
                <td>{{result['phone']}}</td>
                <td>{{result['leak_name']}}</td>
                <td>{{result['leak_date']}}</td>
            </tr>
            % end
        </tbody>
    </table>
% else:
    <p>No results found.</p>
% end
