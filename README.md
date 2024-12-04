# Fraud Detection in Bank Account Openings with HDFS, Spark, and Cassandra
[Check out our report for more detailed information.](https://github.com/user-attachments/files/17997292/ID2221_Group_report_project.pdf)

## Description
This project was developed as part of the ID2221 course at KTH to gain hands-on experience with big data tools/technologies. The primary objective was to understand and implement scalable infrastructure using HDFS, Apache Spark, and Apache Cassandra, while applying machine learning techniques to detect fraudulent bank account openings. By using the the Bank Account Fraud (BAF) dataset, we explore distributed data processing, storage solutions and model training in a big data ecosystem. The project also provides insights into EDA, handling imbalanced datasets and evaluating model performance using metrics like AUC, Precision, and Recall.

## Instructions
### Prerequisites:
- Docker (tested with v27.3.1 on Ubuntu and v27.2.0 on Docker for Windows)

### Steps:
1. Enter the project root directory (contains `infra/` and `notebooks/` subdirectories).
2. Download `Base.csv` from [Kaggle](https://www.kaggle.com/datasets/sgpjesus/bank-account-fraud-dataset-neurips-2022) and place it into `notebooks/data`.
3. Start the Docker Compose deployment with `docker compose -f infra/docker-compose.yml up`. After pulling and building all images (3-5 minutes), the services will start. The HDFS containers may need one or two minutes to start up fully.
4. Open the Jupyter Web-UI or connect to it from an editor of choice at `http://localhost:8888` using the token `ID2221`.
5. Navigate to the `work/hdfs` directory (mounted from the `notebooks/hdfs` directory), open and execute either the exploratory analysis (`eda.ipynb`) or gradient boosted tree model training and evaluation (`basic_gbt.ipynb`).
6. The visualizations will be visible in the notebook and model prediction results saved to the `results` keyspace of the local Cassandra instance.

## Dataset
Source: Sérgio Jesus, José Pombal, Duarte Alves, André Cruz, Pedro Saleiro, Rita P. Ribeiro, Joao Gama, and Pedro Bizarro. Turning the Tables: Biased, Imbalanced, Dynamic Tabular Datasets for ML Evaluation, November 2022.
URL http://arxiv.org/abs/2211.13358. arXiv:2211.13358

[Source on Kaggle](https://www.kaggle.com/datasets/sgpjesus/bank-account-fraud-dataset-neurips-2022)

Used data: `Base.csv` ("Sampled to best represent original dataset")

## Infrastructure
`infra/docker-compose.yml` contains the containers for a single-node Hadoop cluster and a jupyter-spark container.
Start with `docker compose up` or manage with whatever Docker UI you use.

> **HDFS Notes**
> - The namenode needs a minute or two to start up!
 
If you have jupyter and spark working locally, you don't need to use the jupyter-spark container and should be able to
connect to the hadoop cluster from your local jupyter notebook.

`infra/hdfs` contains the custom hadoop Dockerfile, configuration files, scripts, and a `data` directory for storing the hdfs data.

> **Important local ports (access with "http://localhost:" + port)**
> - Hadoop: 9975 (namenode UI), **8020** (hdfs port → Important for reading/writing files)
> - Spark: 4040 (UI)
> - Jupyter: **8888** (UI)

## Using Pyspark container from an IDE
When editing a notebook in VS Code or PyCharm, you can choose to use the existing jupyter kernel/server of the pyspark container:
- URL: `http://localhost:8888/`
- Token: `ID2221` (can be changed in docker-compose.yml)
