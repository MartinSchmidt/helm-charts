#!/bin/bash
set -e

./scripts/install_kubectl.sh
pip install ksql

./scripts/wait_for_pod.sh cp-ksql-server
python /scripts/python_ksql.py http://"$1"-cp-ksql-server:8088 
