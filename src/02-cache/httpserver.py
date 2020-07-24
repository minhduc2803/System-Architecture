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
