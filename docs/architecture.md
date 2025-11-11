# Архитектура ParsDatGoETL

## Общая схема

1. **Collector (Go)** опрашивает публичный REST API (например, CoinGecko) по списку активов, нормализует ответ и складывает данные в raw-слой (Kafka или таблица landing в PostgreSQL).
2. **Airflow DAG** каждые 15 минут подтягивает свежие записи, запускает контейнер **Aggregator (Go/Python)**, агрегирует метрики (min/max/avg, объём, волатильность) и записывает результаты в витрину (`agg_prices`).
3. **Tableau / BI** подключается к витрине и визуализирует сводные дашборды.
4. *Опционально:* мониторинг Go-сервисов (Prometheus + Grafana), reverse proxy (nginx/traefik) и дополнительные аналитические расчёты.

## Хранилища и очереди

- `raw_prices` — таблица landing или топик Kafka, куда collector складывает события.
- `agg_prices` — таблица витрины с агрегированными метриками.
- `views` — материализованные представления для BI-инструментов.

## Сервисы

- `collector` — сервис сбора данных, конфигурируемый переменными окружения (`API_URL`, `ASSETS`, `TARGET_DSN`, `POLL_INTERVAL`, параметры Kafka).
- `aggregator` — batch-процесс, считывающий записи за окно и записывающий агрегаты.
- `migrator` — применяет миграции для схем `raw`, `agg`, `views`.
- `airflow` — оркестратор DAG, включающий `scheduler`, `webserver`, `triggerer`, `worker`.
- `postgres`, `kafka`, `nginx/traefik`, `prometheus/grafana`, `tableau bridge` — инфраструктурные сервисы.

## Поток данных

```text
REST API -> collector -> (Kafka | Postgres raw) -> Airflow DAG
  -> aggregator container -> Postgres/ClickHouse agg -> Tableau dashboards
```

## Развёртывание

- Локально — `docker compose up -d` в каталоге `deploy`.
- CI/CD — GitHub Actions собирает образы (`collector`, `aggregator`, `migrator`) и пушит в registry.
- Продакшен — можно адаптировать под Swarm или Kubernetes (см. `infra/`).

## TODO

- Реализовать бизнес-логику в Go-сервисах.
- Добавить тесты и интеграционные сценарии.
- Настроить мониторинг, алерты и секреты.


