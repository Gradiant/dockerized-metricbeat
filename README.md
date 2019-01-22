This is a modification of the official metricbeat image [Metricbeat](https://www.elastic.co/products/beats/metricbeat).

## Properties

- This image has an 'init' command to create  small footprint ( base docker image is openjdk:8u171-jre-alpine3.8).
- This image has Spark-R support.
- This image has Kafka libraries included.

## Howto

This image has an 'init' command  to create elasticsearch index and kibana dashboards and exit. It should be configured with the following environment variables:
- ELASTICSEARCH_HOSTS default value is "[http://elasticsearch:9200]".
- KIBANA_URL default is "http://kibana:5601".

Running the image without command start a metricbeat process to collect metrics and send them to elasticsearch.  It should be configured with the following environment variables:
- ELASTICSEARCH_HOSTS default value is "[http://elasticsearch:9200]".

### Metricbeat configuration
This image provides a default metricbeat.yml at /usr/share/metricbeat/metricbeat.yml from [here](https://raw.githubusercontent.com/elastic/beats/6.5/deploy/docker/metricbeat.docker.yml).
The configuration enables docker container monitoring and autodiscover. 

You can also provide your own metricbeat configuration mounting your metricbeat.yml at the container path /usr/share/metricbeat/metricbeat.yml.

## Example of usage

To access host and container metrics you should mount /proc and /var/run/docker.sock into the container. To access host networking metrics you should use the docker host network.

Example of usage:

Run the metricbeat setup:

```
docker run --rm -ti \
       -e KIBANA_URL=kibana:5601 \
       -e ELASTICSEARCH_HOSTS=http://elasticsearch:9200 \
       gradiant/metricbeat:6.5.4 init 
```

Run metricbeat:

```
docker run -d \
  --name=metricbeat \
  --user=root \
  -v="/var/run/docker.sock:/var/run/docker.sock:ro" \
  -v="/sys/fs/cgroup:/hostfs/sys/fs/cgroup:ro" \
  -v="/proc:/hostfs/proc:ro" \
  -v="/:/hostfs:ro" \
  -e ELASTICSEARCH_HOSTS=http://elasticsearch:9200 \
  gradiant/metricbeat:6.5.4
```

