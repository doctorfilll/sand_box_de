

**Sandbox DB** — это песочница для изучения современных технологий обработки данных, аналитики и визуализации.  
Я собрал все сервисы в одном месте, настроил и отладил их работу.  
Вам остаётся только запустить их и приступить к обучению.
Эта конфигурация настроена как и для Windows так и для Linux.

## Что внутри?

### Основные сервисы:
- **Postgres** — реляционная база данных.
- **ClickHouse** — колоночная СУБД для аналитики в реальном времени.
- **MinIO** — объектное хранилище.
- **Apache Iceberg** — формат таблиц для больших данных.
- **Trino** (ранее PrestoSQL) — распределенный SQL-движок для выполнения запросов к различным источникам данных.
- **JupyterHub + Spark** — среда для интерактивной работы с данными и выполнения распределенных вычислений с помощью Apache Spark.
- **Apache Airflow** — платформа для оркестрации рабочих процессов и задач.
- **Apache Superset** — инструмент для визуализации и исследования данных.
- **Hadoop** — экосистема для распределенной обработки больших данных.
- **Grafana** — платформа для визуализации и мониторинга нагрузки сервисов.

### Вспомогательные сервисы:
- **Zookeeper** — сервис для координации распределенных систем.
- **Kafka** — распределенная потоковая платформа для обработки событий в реальном времени.
- **Redis** — in-memory хранилище данных, используемое как кэш или брокер сообщений.
- **Hive Metastore** — сервис для управления метаданными в экосистеме Hadoop.
- **MariaDB** — реляционная база данных, альтернатива MySQL.
***

## Требования

- **Операционная система:** Linux/MacOS. Если у вас Windows, то вам придётся самостоятельно внести ряд изменений, чтобы всё заработало.
- **ОЗУ:** от 16 ГБ — сервисов очень много, и когда они все запущены, у меня уходит 10–11 ГБ ОЗУ.
- **ПЗУ:** от 20 ГБ
- **Пользователь:** должен уметь копировать код из репозитория Git, пользоваться Docker и Docker Compose.
***

## Запуск и Удаление

Все начинается с запуска файла: **sandbox_db_run.sh**

В терминале linux перейдите в папку проекта и выполните этот код для запуска песочницы:
```bash
sudo sh sandbox_db_run.sh
```
*Для тех, у кого Windows, 
# Создание нужных директорий
New-Item -ItemType Directory -Force -Path .\services\volume\airflow\dags
New-Item -ItemType Directory -Force -Path .\services\volume\airflow\logs
New-Item -ItemType Directory -Force -Path .\services\volume\airflow\plugins
New-Item -ItemType Directory -Force -Path .\services\volume\airflow\config
New-Item -ItemType Directory -Force -Path .\services\volume\postgres
New-Item -ItemType Directory -Force -Path .\services\volume\minio
New-Item -ItemType Directory -Force -Path .\services\configs\airflow
New-Item -ItemType Directory -Force -Path .\services\configs\hadoop
New-Item -ItemType Directory -Force -Path .\services\configs\jupiterhub
New-Item -ItemType Directory -Force -Path .\services\datasets

# Установка разрешений на папки (Windows не требует chmod, но можно добавить FullControl вручную при необходимости)

# Создание переменной окружения для Airflow UID
$airflowUid = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value
"## Windows SID for reference (not used in containers)
AIRFLOW_UID=50000" | Out-File -Encoding ASCII -FilePath .\services\configs\airflow\env

# Запуск и инициализация базы данных airflow
docker compose up airflow-init

# Запуск всех сервисов
docker compose up -d
*

А если нужно полное удаление
```bash
sudo sh sandbox_db_remove.sh
```
***

## Таблица адресов

Каждому сервису я явно назначил IP-адрес, а также сделал одинаковыми логины и пароли для большинства сервисов.
IP-адреса от 101 до 114. Пока вы не выучили их наизусть, пользуйтесь данной таблицей. Она также продублирована в файле docker-compose. 
```bash
IP list:
|NAME              |IP          |PORT|LOGIN    |PASSWORD|
|------------------+------------+----+---------+--------+
|dwh_pg            |10.19.88.101|5432|tech_load|dwh88   |
|dwh_minio         |10.19.88.102|9000|tech_load|dwh12345|
|dwh_click         |10.19.88.103|8123|tech_load|dwh88   |
|airflow_webserver |10.19.88.104|8080|airflow  |airflow |
|zookeeper         |10.19.88.105|2181|         |        |
|kafka             |10.19.88.106|9092|tech_load|dwh88   |
|hadoop            |10.19.88.107|9870|         |        |
|hadoop            |10.19.88.107|9009|         |        |
|hadoop            |10.19.88.107|9864|         |        |
|jupiterhub_pyspark|10.19.88.108|8888|         |8f293bafa3f498e7d6a8a09baa58cc2290115e95|
|superset_app      |10.19.88.109|8088|tech_load|dwh88   |
|grafana           |10.19.88.110|3000|tech_load|dwh88   |
|trino             |10.19.88.114|8081|admin    |        |
|mariadb           |10.19.88.112|3306|admin    |admin   |
|hive-metastore    |10.19.88.113|9083|         |        |
```
***

## Заключение
1. Для этого сервиса будет вестись документация. Вы сможете найти её во вкладке Wiki в этом Git-репозитории.
2. Проект будет обновляться. Хотелось бы добавить DBT и Greenplum.
