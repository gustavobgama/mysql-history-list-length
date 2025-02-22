# Descrição

O propósito desse pequeno projeto é demonstrar as diferenças no crescimento do undo logs no MySQL InnoDB com as mesmas transações executando em níveis de isolamento diferentes. Com interesse especial pelos nívels `REPEATABLE READ` (padrão do banco) e `READ COMMITTED`.

# Instalação

```bash
$ git clone git@github.com:gustavobgama/mysql-history-list-length.git ./MySQLHistoryListLength
$ cd ./MySQLHistoryListLength
$ docker-compose up -d
```

# Como usar

Após aguardar alguns segundos para que todos os containers estejam prontos, acesse o [dashboard do grafana](localhost:3000/d/ceduzufxq03k0f/history-list-length?orgId=1&from=now-1h&to=now&timezone=browser&refresh=5s) contendo o monitoramento da métrica `transaction_trx_rseg_history_len` que é o [history list length](https://blog.jcole.us/2014/04/16/the-basics-of-the-innodb-undo-logging-and-history-system/).

Depois basta executar o script de teste com os diferentes níveis de isolamento e conferir o comportamento da métrica no gráfico.

```bash
$ ./hhl-test.sh "READ COMMITTED"
$ ./hhl-test.sh "REPEATABLE READ"
```