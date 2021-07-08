
import socket
import json

host = 'localhost' 
port = 5200
backlog = 5 
size = 2048 


class Server():

    def __init__(self, id):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
        s.bind((host,port + id)) 
        s.listen(backlog)
        

        print("Waiting for client...")
        self.client, address = s.accept() 
        print ("Client connected")
        #s.settimeout(1)
        
    def read(self):
        byte_data = self.client.recv(size)
        try:
            str_data = byte_data.decode('utf8')
            json_data = json.loads(str_data)
            return json_data
        except Exception as e:
            pass
            #print("Error in server read: ", e)
            #print('json_data: ', json_data)


    def write(self, msg):
        msg = json.dumps(msg).encode('utf-8')
        print('trying to send...')
        self.client.send(msg)
        print('sent')

    def close(self):
        self.s.close()


        #client.close()