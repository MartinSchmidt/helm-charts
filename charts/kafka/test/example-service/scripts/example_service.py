from time import sleep
from json import dumps,loads
from kafka import KafkaProducer
from kafka import KafkaConsumer
import sys


host=str(sys.argv[1])
consume_topic=str(sys.argv[2])
produce_topic=str(sys.argv[3])

consumer = KafkaConsumer(
     consume_topic,
     bootstrap_servers=[host],
     auto_offset_reset='earliest',
     value_deserializer=lambda x: loads(x.decode('utf-8')))

producer = KafkaProducer(bootstrap_servers=[host],
                         value_serializer=lambda x: 
                         dumps(x).encode('utf-8'))

for increment,message in enumerate(consumer):
    consuming_value = message.value['number']
    
    print('Consuming: {} from topic {}'.format(consuming_value,consume_topic))
    calculation = consuming_value * 2 
    
    print('Producing: {} on topic {} \n'.format(calculation,produce_topic))
    producer.send(produce_topic, value=calculation)
    

