FROM docker.elastic.co/beats/metricbeat:6.5.4
USER root
COPY --chown=root:metricbeat metricbeat.yml /usr/share/metricbeat/metricbeat.yml
COPY --chown=root:root init /usr/local/bin/init
RUN chmod 640 /usr/share/metricbeat/metricbeat.yml
CMD ["/usr/share/metricbeat/metricbeat","-e"]
