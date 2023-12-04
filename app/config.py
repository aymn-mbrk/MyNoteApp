import os
import socket

postgres_host = "db"
ip_address = socket.gethostbyname(postgres_host)

username= 'aymn' #os.environ.get('POSTGRES_USER')
pwd = 'aymn' #os.environ.get('POSTGRES_PASSWORD')
database = 'noteapp' #os.environ.get('POSTGRES_DB')
port_id = 5432

url= f'postgresql://{username}:{pwd}@{ip_address}:{port_id}/{database}'
