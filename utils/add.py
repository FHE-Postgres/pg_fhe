import psycopg2

insert_id = int(input("id: "))
ctext_file = input("ciphertext file: ")
# Read the binary file
with open(f"{ctext_file}", "rb") as file:
    binary_data = file.read()

# Connect to the PostgreSQL database
conn = psycopg2.connect("dbname=testdb user=dom")

# Insert the binary data
for i in range(10000):
    insert_id += 1
    id_str = str(insert_id)
    with conn.cursor() as cursor:
        cursor.execute(f"INSERT INTO test (user_id, data) VALUES ({id_str}, %s)", (psycopg2.Binary(binary_data),))
        conn.commit()

