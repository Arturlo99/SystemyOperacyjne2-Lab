#!/bin/bash -eu

# z pliku yolo.csv wypisz wszystkich, których id jest liczbą nieparzystą. Wyniki zapisz na standardowe wyjście błędu

for RECORD in $(cat yolo.csv | grep -E '^[0-9]{0,}[1,3,5,7,9]{1},'); do
    echo ${RECORD} >&2
done

# Z pliku yolo.csv wypisz każdego, kto jest wart dokładnie $2.99 lub $5.99 lub $9.99. Nie ważne czy milionow, czy miliardow
for PERSON in $(cat yolo.csv | cut -d',' -f3,7 | grep -E '\$[2,5,9]\.[9][9][B|M]'); do
    echo ${PERSON} >&2
done

# Z pliku yolo.csv wypisz każdy numer IP, który w pierwszym i drugim okrecie ma po jednej cyfrze. Wyniki zapisz na standardowe wyjście błędów
for IP in $(cat yolo.csv | cut -d',' -f6 | grep -E '^.\..\.[0-9]{1,3}'); do
    echo ${IP} >&2
done