% include("header")

<!-- Jumbotron -->
<div class="jumbotron">
  <h1>Upload Leak File</h1>
  <form method="POST" action="/upload" enctype="multipart/form-data">
  <p>Only <b>.txt</b> files : email:password<p>
    <p><input type="file" name="file" accept=".txt" required/></p>
    <p><input type="text" name="leakName" placeholder="Leak Name" required/></p>
    <p><input type="text" name="leakDate" placeholder="Leak Date (YYYY)" required/></p>
    <p><input type="submit" value="Upload" role="button" class="btn btn-lg btn-primary"/></p>
  </form>
  <!-- Rest of your HTML code -->

<!-- Rest of your HTML code -->

</div>

% include("footer")
