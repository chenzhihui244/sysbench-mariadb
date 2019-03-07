#!/bin/bash

ansible-playbook -i hosts sysbench_test_prepare.yml
#ansible-playbook -i hosts mariadb_stop_server.yml

#ansible-playbook -i hosts -k sysbench_test_prepare.yml
#ansible-playbook -i hosts -k mariadb_stop_server.yml
