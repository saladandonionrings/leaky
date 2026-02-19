<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Leaky | Leak Database</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="/static/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/static/css/style.css" />
    
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <style>
        .brand-logo {
            font-weight: 800;
            letter-spacing: -1px;
            background: linear-gradient(135deg, #fff 0%, #888 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-transform: lowercase;
            font-size: 1.8rem;
        }
        
        .masthead {
            padding: 20px 0 40px 0;
            border: none;
        }

        .nav-logout {
            color: #ff4d4d !important;
            font-weight: 600 !important;
        }
        
        .nav-logout:hover {
            background: rgba(255, 77, 77, 0.1) !important;
        }

        /* Animation d'apparition de la navbar */
        .navbar {
            animation: fadeInDown 0.5s ease-out;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body id="home">
    <div class="container-fluid">
      <div class="masthead">
        <div class="d-flex justify-content-between align-items-center mb-4 px-2">
            <h3 class="brand-logo m-0">leaky_</h3>
            <span class="badge badge-dark border border-secondary px-3 py-2" style="border-radius: 20px; font-weight: 400; opacity: 0.7;">
                <span class="text-danger">●</span> System Online
            </span>
        </div>

        <nav class="navbar navbar-expand-md">
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
          </button>
          
          <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav nav-justified w-100">
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownSearch" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  Search
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdownSearch">
                  <a class="dropdown-item" href="/index">Credentials</a>
                  <a class="dropdown-item" href="/phone">Phone numbers</a>
                  <a class="dropdown-item" href="/miscsearch">Misc files</a>
                </div>
              </li>

              <li class="nav-item">
                <a class="nav-link" href="/leaks">Breach inventory</a>
              </li>

              <li class="nav-item">
                <a class="nav-link" href="/upload">Upload</a>
              </li>

              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMisc" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  MISC
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdownMisc">
                  <a class="dropdown-item" href="/links-directory">Links</a>
                </div>
              </li>

              <li class="nav-item">
                <a class="nav-link nav-logout" href="/logout">Logout</a>
              </li>
            </ul>
          </div>
        </nav>
      </div>