% include("header")
	      <div class="jumbotron">
	        <h1>Leaks</h1>
	        <p class="lead">List of the different aggregated leaks/files in the database.<br/>
	        	<b style="color:red;">{{count}}</b> credentials indexed.</p>
	      </div>
	      % if leaks != None :
	      	<b style="color:red;">{{nbLeaks}} indexed leaks</b>

			<table class="table-striped table table-hover">
			  <tr>
			    <th>Name</th>
			    <th>Number of credentials</th>
			    <th>Date</th>  <!-- Add the Date column -->
			    <th>Remove</th>
			  </tr>
			  % for l in leaks:
			  <tr>
			    <td>{{ l["name"] }}</td>
			    <td>{{ l["imported"] }}</td>
			    <td>{{ l["date"] }}</td> 
			    <td><b><a style="color:red;text-decoration:none;" href="/removeLeak?id={{ l["id"] }}">X</a></b></td>
			  </tr>
			  % end
			</table>

		% end
% include("footer")
