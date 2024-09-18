# ID2221 Project

## Infrastructure
`infra/docker-compose.yml` contains the containers for a single-node Hadoop cluster and a jupyter-spark container.
Start with `docker compose up` or manage with whatever Docker UI you use.

`infra/hadoop.env` contains the environment variables for the Hadoop container.
It's mostly the default configuration (see [here](https://hub.docker.com/r/apache/hadoop)) with some tweaks/hacks to
disable permissions for local development.

If you have jupyter and spark working locally, you don't need to use the jupyter-spark container and should be able to
connect to the hadoop cluster from your local jupyter notebook.

> **Important local ports (access with http://localhost:\<port\>)**
> - Hadoop: 9870 (namenode), **8020** (hdfs port → Important for reading/writing files)
> - Spark: 4040 (UI), 20002 (Driver - seemingly not working)
> - Jupyter: **8888** (UI)

> **Known Bug:**
> When starting the datanode for the second time/with pre-existing state, something goes wrong in the startup and it shuts down.
> For our purposes, this can be worked around by just deleting the container, starting it again and adding the data again.

> **Important caveat:**
> None of the containers have mounted volumes, so all data is lost when the containers are deleted!
> This could probably be fixed by mounting the right paths, but I don't know which paths to mount.