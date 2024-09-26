# ID2221 Project

## Infrastructure
`infra/docker-compose.yml` contains the containers for a single-node Hadoop cluster and a jupyter-spark container.
Start with `docker compose up` or manage with whatever Docker UI you use.

If you have jupyter and spark working locally, you don't need to use the jupyter-spark container and should be able to
connect to the hadoop cluster from your local jupyter notebook.

`infra/hdfs` contains the custom hadoop Dockerfile, configuration files, scripts, and a `data` directory for storing the hdfs data.

> **Important local ports (access with "http://localhost:" + port)**
> - Hadoop: 9975 (namenode), **8020** (hdfs port → Important for reading/writing files)
> - Spark: 4040 (UI), 20002 (Driver - seemingly not working)
> - Jupyter: **8888** (UI)

Example command for uploading file with a local hadoop client:
```bash
# May need to prefix with JAVA_HOME=$JAVA_HOME for some reason
./hadoop fs -fs hdfs://localhost:8020 -put /path/to/local/file.txt /file.txt
```