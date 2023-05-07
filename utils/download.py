import psycopg2
import io

input_id = input("id: ")
table = input("table: ")
column = input("column: ")
# Connect to the database
conn = psycopg2.connect(database="testdb", user="dom")

# Open a cursor to perform database operations
cur = conn.cursor()

# Select one row from the table with bytea column
cur.execute(f"SELECT {column} FROM {table} WHERE user_id={input_id};")
row = cur.fetchone()

# Get the bytea data from the row
bytea_data = row[0]

# Write the bytea data to a file
with io.open('output.bin', 'wb') as f:
    f.write(bytea_data)

# Close the cursor and the connection
cur.close()
conn.close()

