# Create stream from a kafka topic
```sql
CREATE STREAM test_stream_1 (number INT) 
    WITH (KAFKA_TOPIC='topic-test-1', VALUE_FORMAT='JSON'); 
```

# Issue a pull query but terminate the connection after reading 5 events
```sql
SELECT * FROM test_stream_1 EMIT CHANGES LIMIT 5;
```


# Create a table from a topic
```sql
CREATE TABLE test_table_3 (number INT primary key, category VARCHAR) 
    WITH (KAFKA_TOPIC='topic-test-1', VALUE_FORMAT='JSON'); 
```

# Create an aggregation pull query from a stream 
```sql
SELECT number, count(*) FROM test_stream_1 
    GROUP BY number 
    EMIT CHANGES; 
```

# Create a materialized table from a stream aggreqation push query
```sql
CREATE TABLE test_table_2 AS SELECT number, count(*) FROM test_stream_1 
    GROUP BY number 
    EMIT CHANGES; 
```
