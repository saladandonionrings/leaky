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

    .form-select:focus {
        border-color: #555555;
    }
    .form-select, .upload-file {
        width: 32%;
        background-color: #222222;
        border: 1px solid #333333;
        border-radius: 8px;
        color: white;
        padding: 12px;
        margin-bottom: 10px;
        font-size: 16px;
    }

    .upload {
        background-color: #222222;
        border: 1px solid #333333;
        border-radius: 8px;
        color: white;
        padding: 12px;
        margin-bottom: 10px;
        font-size: 16px;
        width: 40%;
    }

    .upload-file:focus,
    .upload:focus {
        border-color: #555555;
    }

    .btn {
        width: 10%;
        padding: 12px;
        font-size: 16px;
        background-color: #5d000d;
        color: #FFFFFF;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        margin: auto;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    .btn:hover {
        background-color: #3a0516;
    }

    #messageArea {
        margin-bottom: 15px;
        font-size: 14px;
        color: #AAAAAA;
    }
</style>

<div>
  <h4 class="text-3xl font-semibold mb-4">Upload leak file</h2>
  <form method="POST" action="/upload" enctype="multipart/form-data">
    <p>Select the type of data to upload:</p>
    <select name="dataType" id="dataType" class="form-select" required>
      <option value="credentials">Credentials</option>
      <option value="phone_numbers">Phone Numbers</option>
      <option value="misc_file">Misc (SQL/CSV/JSON)</option>
    </select>
    
    <div id="messageArea"></div>

    <script>
        function showMessage() {
            var dataType = document.getElementById('dataType').value;
            var messageArea = document.getElementById('messageArea');
            messageArea.innerHTML = '';
            switch (dataType) {
                case 'credentials':
                    messageArea.innerHTML = '<p>Please select a file with credentials (format: email:password OR url:user:password).</p>';
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
    
    <input class="upload-file" type="file" name="file" accept=".txt,.sql,.json,.csv" required /><br>
    <input class="upload" type="text" name="leakName" placeholder="Leak Name" required /><br>
    <input class="upload" type="text" name="leakDate" placeholder="Leak Date (YYYY)" required />
    <br>
    <input type="submit" value="Upload" role="button" class="btn" />
  </form>
</div>

% include("footer")
