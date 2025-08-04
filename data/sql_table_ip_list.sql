SELECT * FROM 
(
SELECT 'dwh_pg' AS name,'10.19.88.101'AS IP , '5432' AS port, 'tech_load' AS login, 'dwh88' AS password FROM dual ip_list
UNION
SELECT 'dwh_minio' AS name,'10.19.88.102'AS IP , '9000' AS port, 'tech_load' AS login, 'minio123' AS password FROM dual ip_list
UNION
SELECT 'dwh_click' AS name,'10.19.88.103'AS IP , '8123' AS port, 'tech_load' AS login, 'dwh88' AS password FROM dual ip_list
UNION
SELECT 'airflow_webserver' AS name,'10.19.88.104'AS IP , '8080' AS port, 'airflow' AS login, 'airflow' AS password FROM dual ip_list
) 
ORDER BY ip;