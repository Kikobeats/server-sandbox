#!/bin/bash

service exim4 restart # smtp
service dovecot restart # pop
service bind9 restart # dns

echo " ...done"
