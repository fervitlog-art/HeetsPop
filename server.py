from http.server import HTTPServer, SimpleHTTPRequestHandler
from urllib.parse import urlparse
import os, threading
class H(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cache-Control","no-store")
        super().end_headers()
    def do_GET(self):
        if urlparse(self.path).path=="/__shutdown":
            self.send_response(200); self.end_headers(); self.wfile.write(b"Server chiuso"); threading.Thread(target=self.server.shutdown,daemon=True).start(); return
        super().do_GET()
os.chdir(os.path.dirname(os.path.abspath(__file__)))
HTTPServer(("127.0.0.1",8000),H).serve_forever()
