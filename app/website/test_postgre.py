import os
import socket
import psycopg2

postgres_host = "db"
ip_address = socket.gethostbyname(postgres_host)

username = 'aymn'  # Replace with your PostgreSQL username
pwd = 'aymn'      # Replace with your PostgreSQL password
database = 'noteapp'  # Replace with your PostgreSQL database name
port_id = 5432

url = f'postgresql://{username}:{pwd}@{ip_address}:{port_id}/{database}'

try:
    connection = psycopg2.connect(url)
    cursor = connection.cursor()
    cursor.execute("SELECT version();")
    record = cursor.fetchone()
    print(f"Connected to the PostgreSQL database: {record[0]}")
    cursor.close()
    connection.close()
except Exception as e:
    print(f"Connection failed with error: {e}")

