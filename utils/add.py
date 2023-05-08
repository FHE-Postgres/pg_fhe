import psycopg2

insert_id = int(input("id: "))
ctext_file = input("ciphertext file: ")
num_rows = int(input("num_rows: "))
username = input("username: ")
# Read the binary file
with open(f"{ctext_file}", "rb") as file:
    binary_data = file.read()

# Connect to the PostgreSQL database
conn = psycopg2.connect(f"dbname=testdb user={username}")

# Insert the binary data
for i in range(num_rows):
    insert_id += 1
    id_str = str(insert_id)
    with conn.cursor() as cursor:
        cursor.execute(f"INSERT INTO test (id, data) VALUES ({id_str}, %s)", (psycopg2.Binary(binary_data),))
conn.commit()
