# ID2221 Project

## Infrastructure
`infra/docker-compose.yml` contains the containers for a single-node Hadoop cluster and a jupyter-spark container.
Start with `docker compose up` or manage with whatever Docker UI you use.

> **HDFS Notes**
> - The namenode needs a minute or two to start up!
 
If you have jupyter and spark working locally, you don't need to use the jupyter-spark container and should be able to
connect to the hadoop cluster from your local jupyter notebook.

`infra/hdfs` contains the custom hadoop Dockerfile, configuration files, scripts, and a `data` directory for storing the hdfs data.

> **Notes**
> - Due to the different ways windows and unix handle line endings, the start hadoop scripts located in the HDFS folder might not run, to fix this you need to change the
> - line endings of these scripts using your ide for example. The line endings should be LF (Unix) and not CRLF (Windows). For reference, https://stackoverflow.com/questions/29045140/env-bash-r-no-such-file-or-directory

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
When editing a notebook in VS Code or PyCharm, you can choose to use the existing jupyter kernel/server of the pyspark container:
- URL: `http://localhost:8888/`
- Token: `ID2221` (can be changed in docker-compose.yml)