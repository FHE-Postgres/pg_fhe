import psycopg2

# Read the binary file
with open("ciphertext.bin", "rb") as file:
    binary_data = file.read()

# Connect to the PostgreSQL database
conn = psycopg2.connect("dbname=testdb user=dom")

# Insert the binary data
with conn.cursor() as cursor:
    cursor.execute("INSERT INTO fitness (user_id, minutes) VALUES (001, %s)", (psycopg2.Binary(binary_data),))
    conn.commit()

