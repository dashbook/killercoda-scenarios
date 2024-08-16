# Dashtool example with Kafka

Welcome to our tutorial on creating a data lakehouse using
[dashtool](http://www.github.com/dashbook/dashtool). In this project, you'll
learn how to collect data from an event streaming platform, transform it and make it
available for analytics. Our focus will be on demonstrating the capabilities of
a lakehouse, which combines the benefits of data warehouses and data lakes to
enable business intelligence (BI) and machine learning (ML) directly on cloud
object storage.

To get started, let's walk through what you can expect in this tutorial:

1. **Data ingestion**: We'll utilize a Kafka server and a PostgreSQL database as our operational
   system and demonstrate how to extract data using one of the 200+ available
   [Airbyte connectors](https://airbyte.com).
   These connectors allow you to easily ingest data from various sources.
2. **Declarative data pipeline**: You'll discover how to set up declarative data
   pipelines that will transform the ingested data using declarative SQL
   statements.
3. **Automated Data Refresh**: Leveraging Argo Workflows, you'll orchestrate
   Kubernetes Jobs that use the
   [Datafusion](https://github.com/apache/arrow-datafusion) query engine to
   automatically update the target tables.
4. **Open Table Format**: Utilizing
   [Apache Iceberg](https://iceberg.apache.org/), you'll store your transformed
   data in a highly performant table format that can be accessed by query
   engines such as Spark and Trino.
5. **Data Analysis with BI Tool**: To visualize and interactively explore the
   processed data, we introduce [Apache Superset](https://superset.apache.org)—a
   popular open-source BI platform. We will use an Apache Arrow Flight server to
   enable Superset to read the Iceberg tables.

By completing this tutorial, you'll have learned to create **declarative data
pipelines** that enables analytics directly on a data lakehouse.
