#!/bin/bash

ISOLATION_LEVEL=${1:-REPEATABLE READ}

if [[ "$ISOLATION_LEVEL" != "READ UNCOMMITTED" && "$ISOLATION_LEVEL" != "READ COMMITTED" && "$ISOLATION_LEVEL" != "REPEATABLE READ" && "$ISOLATION_LEVEL" != "SERIALIZABLE" ]]; then
  echo "Invalid ISOLATION_LEVEL: $ISOLATION_LEVEL"
  exit 1
fi

HOST="0.0.0.0"
USER="root"
PASS="root"
DB="mydb"

echo "Utilizando nível de isolamento: ${ISOLATION_LEVEL}"

echo "Abrindo transação longa que manterá a versão da linha com isolamento ${ISOLATION_LEVEL}..."
mysql -h ${HOST} -u ${USER} -p${PASS} ${DB} -e "SET SESSION TRANSACTION ISOLATION LEVEL ${ISOLATION_LEVEL}; START TRANSACTION; SELECT * FROM customers WHERE id = 1; DO SLEEP(30); COMMIT;" 2>/dev/null &

sleep 5

echo "Executando updates concorrentes na tabela 'customers'..."
for i in {1..100}; do
  mysql -h ${HOST} -u ${USER} -p${PASS} ${DB} -e "UPDATE customers SET name = CONCAT('Nome Alterado ', ${i}) WHERE id = 1;" 2>/dev/null &
  sleep 0.1
done

wait
echo "Carga finalizada."
