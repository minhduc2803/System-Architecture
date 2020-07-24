#!/bin/zsh

sudo cat > /etc/nginx/sites-enabled/default << EOF1
proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=myCache:8m max_size=100m inactive=1h;

server {
	listen 80;
	location / {
		proxy_pass http://localhost:2222;
        proxy_ignore_headers X-Accel-Expires Expires Cache-Control Set-Cookie;
        proxy_cache myCache;
        proxy_cache_valid any 60m;

	}
}
EOF1

sudo systemctl restart nginx

cat > httpserver.py << EOF2
#!/usr/bin/python
from http.server import BaseHTTPRequestHandler,HTTPServer
from threading import Thread
from socketserver import ThreadingMixIn

class Handler1(BaseHTTPRequestHandler):
    def do_GET(self):
        f = open("vk-quoc-dan.jpg", 'rb')
        self.send_response(200)
        self.send_header('Content-type', 'image/jpg')
        self.end_headers()
        self.wfile.write(f.read())
        f.close()
        return

class ThreadingHTTPServer(ThreadingMixIn, HTTPServer):
    daemon_threads = True

def serve_on_port(port, Handler):
    server = ThreadingHTTPServer(("localhost",port), Handler)
    print('HTTPServer started on port ',port)
    server.serve_forever()

serve_on_port(2222, Handler1)

EOF2

python3 ./httpserver.py

