#!/bin/zsh

sudo cat > /etc/nginx/sites-enabled/default << EOF1
upstream web_backend {
	server localhost:1111;
	server localhost:2222;
}
server {
	listen 80;
	location / {
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_pass http://web_backend;

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
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()
        self.wfile.write(b"hello world from port 1111")
        return
class Handler2(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()
        self.wfile.write(b"hello world from port 2222")
        return
class ThreadingHTTPServer(ThreadingMixIn, HTTPServer):
    daemon_threads = True

def serve_on_port(port, Handler):
    server = ThreadingHTTPServer(("localhost",port), Handler)
    print('HTTPServer started on port ',port)
    server.serve_forever()

Thread(target=serve_on_port, args=[1111, Handler1]).start()
serve_on_port(2222, Handler2)
EOF2

python3 ./httpserver.py

