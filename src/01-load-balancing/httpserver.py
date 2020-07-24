#!/usr/bin/python
from http.server import BaseHTTPRequestHandler,HTTPServer
from threading import Thread
from socketserver import ThreadingMixIn

class Handler1(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()
        self.wfile.write(b"hello world 1111")
        return
class Handler2(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()
        self.wfile.write(b"hello world 2222")
        return
class ThreadingHTTPServer(ThreadingMixIn, HTTPServer):
    daemon_threads = True

def serve_on_port(port, Handler):
    server = ThreadingHTTPServer(("localhost",port), Handler)
    print('HTTPServer started on port ',port)
    server.serve_forever()

Thread(target=serve_on_port, args=[1111, Handler1]).start()
serve_on_port(2222, Handler2)
