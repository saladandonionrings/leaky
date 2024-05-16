% include("header")
<div class="jumbotron">
  <h1>Leaks</h1>
  <p class="lead">List of the different aggregated leaks/files in the database.</p>
  <b style="color:red;">{{nbLeaks}} indexed leaks</b>

  <!-- Table for Credentials -->
  <h3>Credentials</h3>
  <table class="table-striped table table-hover">
    <tr>
      <th>Name</th>
      <th>Number of credentials</th>
      <th>Date</th>  
      <th>Remove</th>
    </tr>
	% for leak in creds_leaks_info:
	  <tr>
	    <td>{{ leak["name"] }}</td>
	    <td>{{ leak["imported"] }}</td>
	    <td>{{ leak["date"] }}</td> 
	    <td><a href="/removeLeak?id={{ leak["id"] }}">X</a></td>
	  </tr>
	  % end
	</table>

  <!-- Table for Phone Numbers -->
  <h3>Phone Numbers</h3>
  <table class="table-striped table table-hover">
    <tr>
      <th>Name</th>
      <th>Number of phone numbers</th>
      <th>Date</th>  
      <th>Remove</th>
    </tr>
	 % for leak in phone_leaks_info:
	  <tr>
	    <td>{{ leak["name"] }}</td>
	    <td>{{ leak["imported"] }}</td>
	    <td>{{ leak["date"] }}</td> 
	    <td><a href="/removeLeak?id={{ leak["id"] }}">X</a></td>
	  </tr>
	  % end
	</table>

  <!-- Table for MISC files -->
	<h3>Misc Files (SQL, CSV, JSON)</h3>
  <table class="table-striped table table-hover">
    <tr>
      <th>Name</th>
      <th>Number of lines</th>
      <th>Date</th>  
      <th>Remove</th>
    </tr>
	 % for leak in miscfiles_leaks_info:
	  <tr>
	    <td>{{ leak["name"] }}</td>
	    <td>{{ leak["imported"] }}</td>
	    <td>{{ leak["date"] }}</td> 
	    <td><a href="/removeLeak?id={{ leak["id"] }}">X</a></td>
	  </tr>
	  % end
	</table>
</div>
% include("footer")
