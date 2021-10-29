from kafka import KafkaConsumer
from json import loads
import sys
import io
import pyarrow as pa
import pyarrow.parquet as pq
import pandas as pd


ip=str(sys.argv[1])
topic=str(sys.argv[2])
consume_count=int(sys.argv[3])
broker=f'{ip}:9092'
# This is a consumer test that communicates with a kafka broker exposed via the Metallb loadbalancer.
consumer = KafkaConsumer(
     topic,
     bootstrap_servers=[broker],
     auto_offset_reset='earliest')

for increment,message in enumerate(consumer):

    reader = pa.BufferReader(message.value)
    table = pq.read_table(reader)
    df = table.to_pandas()

    print(df)
    
    if increment >= consume_count:
        print("exiting")
        break
    
