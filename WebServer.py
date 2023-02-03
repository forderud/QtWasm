from http import server
import sys

class CORSRequestHandler (server.SimpleHTTPRequestHandler):
    '''Custom HTTP request handler that adds CORS headers to enable SharedArrayBuffer'''
    def end_headers (self):
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        self.send_header('Cross-Origin-Embedder-Policy', 'require-corp')
        server.SimpleHTTPRequestHandler.end_headers(self)

if __name__ == '__main__':
    port = int(sys.argv[1])
    print("serving at port", port)
    server.test(HandlerClass=CORSRequestHandler, port=port)
