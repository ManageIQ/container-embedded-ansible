#!/bin/bash

# Set up the database
PGPASSWORD=${POSTGRESQL_PASSWORD} psql -d postgres -U ${POSTGRESQL_USER} -h ${DATABASE_SERVICE_NAME} -c "CREATE DATABASE ${POSTGRESQL_DATABASE} OWNER ${POSTGRESQL_USER} ENCODING 'utf8'"

# Print the inventory file
cat << EOF > /inventory
[tower]
localhost ansible_connection=local

[database]

[all:vars]
admin_password='${ADMIN_PASSWORD}'

pg_host='${DATABASE_SERVICE_NAME}'
pg_port='5432'

pg_database='${POSTGRESQL_DATABASE}'
pg_username='${POSTGRESQL_USER}'
pg_password='${POSTGRESQL_PASSWORD}'

rabbitmq_port=5672
rabbitmq_vhost=tower
rabbitmq_username='${RABBITMQ_USER_NAME}'
rabbitmq_password='${RABBITMQ_PASSWORD}'
rabbitmq_cookie=cookiemonster
rabbitmq_use_long_name=false
rabbitmq_enable_manager=false
EOF

ansible-tower-setup -e minimum_var_space=0 -e tower_package_name=ansible-tower-server -i /inventory -- --skip-tags=packages
