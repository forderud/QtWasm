from http import server
import sys

match = {
    '/source/': '../sample/'
}


class CORSRequestHandler (server.SimpleHTTPRequestHandler):
    '''Custom HTTP request handler that adds CORS headers to enable SharedArrayBuffer'''
    def end_headers (self):
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        self.send_header('Cross-Origin-Embedder-Policy', 'require-corp')
        server.SimpleHTTPRequestHandler.end_headers(self)

    def translate_path(self, path):
        r = None
        for tag in match:
            if path.startswith(tag):
                r = path.replace(tag, match[tag])
                break
        if r is None:
            r =  server.SimpleHTTPRequestHandler.translate_path(self, path)
        print(path, r)
        return r

if __name__ == '__main__':
    port = int(sys.argv[1])
    print("serving at port", port)
    server.test(HandlerClass=CORSRequestHandler, port=port)
