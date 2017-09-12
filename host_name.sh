#!/bin/bash
<VirtualHost *:80>
    ProxyPreserveHost On
    ProxyPass / http://localhost:9000/
    ProxyPassReverse / http://localhost:9000/
    ServerName localhost
</VirtualHost>