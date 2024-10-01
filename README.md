# ID2221 Project

## Infrastructure
`infra/docker-compose.yml` contains the containers for a single-node Hadoop cluster and a jupyter-spark container.
Start with `docker compose up` or manage with whatever Docker UI you use.

> **HDFS Notes**
> - The namenode needs a minute or two to start up!
 
If you have jupyter and spark working locally, you don't need to use the jupyter-spark container and should be able to
connect to the hadoop cluster from your local jupyter notebook.

`infra/hdfs` contains the custom hadoop Dockerfile, configuration files, scripts, and a `data` directory for storing the hdfs data.

> **Important local ports (access with "http://localhost:" + port)**
> - Hadoop: 9975 (namenode), **8020** (hdfs port → Important for reading/writing files)
> - Spark: 4040 (UI), 20002 (Driver - seemingly not working)
> - Jupyter: **8888** (UI)

### Uploading to HDFS
This is currently a bit tricky, but the easiest is to do it through the jupyter-spark container.
The container is on the same network as the hadoop cluster, so there are no hostname issues.

For convenience, the `notebooks/` folder of this project is also mounted to the `work/` directory of the jupyter-spark container.

See the example in `notebooks/test.ipynb`.

### Using Pyspark container from an IDE
This was only tested in PyCharm professional 2024.2.2, but the principle should be the same for other IDEs.
When editing a notebook, you can choose the jupyter server to use the pyspark container at `http://localhost:8888/`.