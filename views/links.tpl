% include("header")
    <style>
        ul li a {
            text-decoration: none !important;
            color: white; 
        }

        body ul {
            list-style-type: none !important;
            padding-left: 0;
        }

        li {
            margin-bottom: 20px;
        }

        a:focus {
            outline: none;
        }
    </style>
<div class="jumbotron">
  <h2>Links Directory</h2>
  <br>
    <ul>
    % for link in links:
        <li>
            <a href="{{link['url']}}" target="_blank">{{link['title']}}</a>
            <br>
            <img href="{{link['url']}}" src="https://image.thum.io/get/width/200/crop/600/{{link['url']}}" width="200" height="100">
        </li>
    % end
    </ul>
</div>
% end
