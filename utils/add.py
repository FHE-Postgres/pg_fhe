import psycopg2

insert_id = input("id: ")
ctext_file = input("ciphertext file: ")
# Read the binary file
with open(f"{ctext_file}", "rb") as file:
    binary_data = file.read()

# Connect to the PostgreSQL database
conn = psycopg2.connect("dbname=testdb user=dom")

# Insert the binary data
with conn.cursor() as cursor:
    cursor.execute(f"INSERT INTO fitness (user_id, minutes) VALUES ({insert_id}, %s)", (psycopg2.Binary(binary_data),))
    conn.commit()

