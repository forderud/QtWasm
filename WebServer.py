from http.server import HTTPServer, SimpleHTTPRequestHandler
import sys

class CORSRequestHandler (SimpleHTTPRequestHandler):
    '''Custom HTTP request handler that adds CORS headers to enable SharedArrayBuffer'''
    def end_headers (self):
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        self.send_header('Cross-Origin-Embedder-Policy', 'require-corp')
        SimpleHTTPRequestHandler.end_headers(self)

if __name__ == '__main__':
    port = int(sys.argv[1])

    with HTTPServer(("", port), CORSRequestHandler) as httpd:
        print("serving at port", port)
        httpd.serve_forever()
