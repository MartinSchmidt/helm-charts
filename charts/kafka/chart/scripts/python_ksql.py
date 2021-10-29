from ksql import KSQLAPI
import sys
import string
import random
import json

endpoint=str(sys.argv[1])
topic=str(sys.argv[2])

client = KSQLAPI(endpoint)

## Create a stream from topic
stream_name_random =  ''.join(random.choice(string.ascii_uppercase) for _ in range(10))
client.create_stream(
        table_name=stream_name_random,
        columns_type=["number bigint","category varchar"],
        topic=topic,
        value_format="json"
    )

query_res = client.ksql("LIST STREAMS;")
streams_names = [stream['name'] for stream in query_res[0]['streams']]

if stream_name_random in streams_names:
    print("STREAM CREATED")
else:
    print("Stream not created")
    exit(1)

# Create a materialized table from stream for the average number over categories
materialized_table_random_name = ''.join(random.choice(string.ascii_uppercase) for _ in range(10))
client.ksql(f"CREATE TABLE {materialized_table_random_name} AS SELECT category, AVG(number) AS avg FROM {stream_name_random} GROUP BY category EMIT CHANGES;")

query_res = client.ksql("LIST TABLES;")
table_names = [table['name'] for table in query_res[0]['tables']]

if materialized_table_random_name in table_names:
    print("Materialized table created")
else:
    print("Table not created")
    exit(1)


# Query the table
query_res = client.query(
    f"SELECT * FROM {materialized_table_random_name} WHERE category='test' EMIT CHANGES LIMIT 1",
    return_objects=True,
    idle_timeout=30)

# 0 - 9 was generated. Query should return 5
try:
    res = next(query_res)['AVG']
    print(f"Got result {res}")
except:
    print("Query did not succeed")
    exit(1)
