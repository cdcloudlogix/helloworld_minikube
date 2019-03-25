#!/usr/bin/python
from http.server import BaseHTTPRequestHandler,HTTPServer

PORT_NUMBER = 8080

# This class will handle any incoming request from
# a browser
class myHandler(BaseHTTPRequestHandler):
    # Handler for the GET requests
    def do_GET(self):
        print('Get request received')
        # Send the html message
        self.wfile.write("Hello World !".encode())
        return

try:
    # Create a web server and define the handler to manage the
    # incoming request
    server = HTTPServer(('', PORT_NUMBER), myHandler)
    print ('Started httpserver on port ' , PORT_NUMBER)

    # Wait forever for incoming http requests
    server.serve_forever()

except KeyboardInterrupt:
    print ('^C received, shutting down the web server')
    server.socket.close()