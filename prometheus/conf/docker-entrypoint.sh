#!/bin/sh -e

cat /etc/prometheus/prometheus.yml > /tmp/prometheus.yml
cat /etc/prometheus/weave-cortex.yml | \
    sed "s@#password: <token>#@password: '$WEAVE_TOKEN'@g" > /tmp/weave-cortex.yml

# Example:
# CUSTOMJOBS="job-name='hostname1:80', 'hostname2:80';job-name2='hostname3:80', 'hostname4:80'"

if [ ${CUSTOMJOBS+x} ]; then

IFS=';' read -r -a array <<< "$CUSTOMJOBS"

for index in "${!array[@]}"
do
    job_name=`echo ${array[index]} | awk -F '=' '{print$1}'`
    job_value=`echo ${array[index]} | awk -F '=' '{print$2}'`
    echo "adding job $job_name"

cat >>/tmp/prometheus.yml <<EOF

  - job_name: '${job_name}'
    static_configs:
      - targets: [
        ${job_value}
      ]
EOF


if [ ${JOBS+x} ]; then

for job in $JOBS
do
echo "adding job $job"

SERVICE=$(echo "$job" | cut -d":" -f1)
PORT=$(echo "$job" | cut -d":" -f2)

# cat >>/tmp/prometheus.yml <<EOF

#   - job_name: '${SERVICE}'
#     static_configs:
#       - targets: [
#         '${SERVICE}'
#       ]
# EOF

cat >>/tmp/weave-cortex.yml <<EOF

  - job_name: '${SERVICE}'
    dns_sd_configs:
    - names:
      - 'tasks.${SERVICE}'
      type: 'A'
      port: ${PORT}
EOF

done

fi

if [ -f /etc/prometheus/custom-scrape.yml ]; then
  cat /etc/prometheus/custom-scrape.yml >> /tmp/prometheus.yml 
fi

mv /tmp/prometheus.yml /etc/prometheus/prometheus.yml
mv /tmp/weave-cortex.yml /etc/prometheus/weave-cortex.yml

set -- /bin/prometheus "$@"

exec "$@"

