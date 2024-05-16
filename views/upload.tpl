% include("header")

<!-- Jumbotron -->
<div class="jumbotron">
  <h1>Upload Leak File</h1>
  <form method="POST" action="/upload" enctype="multipart/form-data">
    <p>Select the type of data to upload:</p>
    <select name="dataType" id="dataType" class="form-select" required>
      <option value="credentials">Credentials</option>
      <option value="phone_numbers">Phone Numbers</option>
      <option value="misc_file">Misc (SQL/CSV/JSON)</option>
    </select>
    <br>
        <div id="messageArea">
        <!-- Message content -->
    </div>

    <script>
        function showMessage() {
            var dataType = document.getElementById('dataType').value;
            var messageArea = document.getElementById('messageArea');
            messageArea.innerHTML = '';
            switch(dataType) {
                case 'credentials':
                    messageArea.innerHTML = '<p>Please select a file with credentials (format: email:password).</p>';
                    break;
                case 'phone_numbers':
                    messageArea.innerHTML = '<p>Please select a file with phone numbers (one number per line).</p>';
                    break;
                case 'misc_file':
                    messageArea.innerHTML = '<p>Please select a file in SQL, CSV, or JSON format.</p>';
                    break;
                default:
                    messageArea.innerHTML = ''; // No message for other options
                    break;
            }
        }
        document.getElementById('dataType').addEventListener('change', showMessage);
        showMessage();
    </script>
    <p><input class="upload-file" type="file" name="file" accept=".txt,.sql,.json,.csv" required/></p>
    <p><input class="upload" type="text" name="leakName" placeholder="Leak Name" required/></p>
    <p><input class="upload" type="text" name="leakDate" placeholder="Leak Date (YYYY)" required/></p>
    <p><input type="submit" value="Upload" role="button" class="btn btn-lg btn-primary"/></p>
  </form>
</div>
% include("footer")
