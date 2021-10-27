# services-jaeger
A umbrella helm chart for Jaeger.

## Jaeger components
Jaeger consist of 4 different components as shown in the picture below
![jaeger components](/images/Jaeger-components.PNG)
source: https://www.jaegertracing.io/docs/1.26/architecture/

### Query
This component contains a webserver that queries the database and show the result in a GUI 

### Storage
the recommended storage option, and the one we are using is Elasticsearch as a document oriented database/engine for us to store traces to make historic based analysis.

### Collecter
The collector is responsible for receiving the tracing data and store it in database.

### Agent
The agent is responsible for tracking the operations between services as described by the [OpenTracing specification](https://github.com/opentracing/specification/blob/master/specification.md)

