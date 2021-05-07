#!/bin/bash -eu

# Znajdź w pliku access_log zapytania, które mają frazę "denied" w linku
echo "Searching \"denied\" in link"
cat ./access_log | cut -d' ' -f6,7,8 | grep \/denied

# Znajdź w pliku access_log zapytania typu POST
echo "Searching POST requests"
cat ./access_log | cut -d' ' -f6,7,8 | grep \"POST

# Znajdź w pliku access_log zapytania wysłane z IP 64.242.88.10
echo "Searching requests sent from 64.242.88.10"
cat ./access_log | cut -d' ' -f1,6,7,8 | grep 64\.242\.88\.10

# Znajdź w pliku access_log zapytania NIEWYSŁANE z adresu IP tylko z FQDN
echo "Searching for requests sent from FQDN"
cat ./access_log | cut -d' ' -f1,6,7,8 | grep '^[a-z]'

# Znajdź w pliku access_log unikalne zapytania typu DELETE
echo "Searching for DELETE requests"
cat ./access_log | cut -d' ' -f6,7,8 | grep \"DELETE | sort -u

# Znajdź unikalnych 10 adresów IP w access_log
echo "Searching for 10 unique IP adresses"
cat ./access_log | cut -d' ' -f1 | grep '^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | sort | uniq | sed 10q

