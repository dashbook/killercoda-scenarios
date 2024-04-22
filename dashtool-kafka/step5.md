## Transform (T)

Now that we loaded the data from the data source into the lakehouse, it's time
to transform the data according to our needs. In this tutorial we will create a
"Medallion" architecture with a "bronze", a "silver" and a "gold" layer. The
"bronze" layer contains replicated data from the source system. The "silver"
layer contains cleansed, merged, conformed, and anonymised data from the
"bronze" layer. It provides a solid basis for further analysis. The "gold" layer
provides consumption ready data sets for Business intelligence, reporting and
Machine learning.

Let's create a silver branch to work on tranforming the data.

```shell
git branch silver
git checkout silver
```{{exec}}

### Transformation for the Fact table

Dashtool will create a Materialized view for every `.sql` file in the directory
tree. We can see one example in `silver/inventory/fact_order.sql`, which will
create the Materialized View `silver.inventory.fact_order`. As you can see, we
are renaming the columns to fit to our organizational standards.

The "silver" layer is a good place to apply
[Dimensional Modeling](https://en.wikipedia.org/wiki/Dimensional_modeling).
Dimensional Modeling distinguishes between qualitative and quantitative data and
separates them into dimension and fact tables, respectively. The Orders table
contains the `quantity` column as a quantitative measure and is therefore a fact
table. It is related to the dimension tables `dim_customer` and `dim_product`
through the colums `customerId` and `productId`.

The following command will add the silver files to the silver branch.

```shell
git add silver/inventory/fact_order.sql silver/inventory/dim_customer.sql silver/inventory/dim_product.sql
git commit -m "silver"
```{{exec}}

### Dashtool build

By running the dashtool build command, we will create the corresponding
Materialized Views in the lakehouse. Keep in mind that we are currently on the
"silver" branch and therefore the materialized views are created with a "silver"
branch.

```shell
./dashtool build
```{{exec}}

### Dashtool workflow

By running the dashtool workflow command, we will create an Argo Workflow that
creates jobs to refresh the previously created Materialized Views. Refreshing
the Materialized View means checking if the data in the source tables has
changed and if so, updating the data in the Materialized View.

```shell
./dashtool workflow
```{{exec}}

### Create argo workflow

To apply the updated workflow, execute the following command. Similar to before,
you can go to the [Argo console]({{TRAFFIC_HOST1_32746}}) to start the workflow, otherwise it will
start according to its schedule.

```shell
kubectl apply -f argo/workflow.yaml
```{{exec}}

### Merge changes into main

If your workflows ran successfully, you can merge the changes into the main
branch.

```shell
git checkout main
git merge silver
```{{exec}}

Run "dashtool build" again to merge the silver tables onto the main branch so that they can be accessed from other processes.

```
./dashtool build
```{{exec}}
