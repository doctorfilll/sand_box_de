# Скрипт запуска песочницы
# создаем нужные папки для сервисов, 
# я хотел что бы они копировались с git но не смог заставить гит хранить пустые папки
mkdir -p ./services/volume/{airflow/{dags,logs,plugins,config},postgres,minio} 
mkdir -p ./services/configs/{airflow,hadoop,jupiterhub}

# создаем папку куда можно складывать датасеты и они будут видны во всех сервисах
mkdir -p ./services/datasets

# даем всем сервисам права на папку 
sudo chmod -R 777 ./services/

# для aurflow создаем пользователя
echo -e "AIRFLOW_UID=$(id -u)" > ./services/configs/airflow/env

#инициируем базы для airflow
sudo docker compose up airflow-init

#запускаем песочницу!
sudo docker compose up -d