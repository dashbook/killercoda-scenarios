## Analysis

Now that we have clean and properly modeled data in the lakehouse, we can start
answering questions about our data. This is what the "gold" layer is for.

Let's create a gold branch.

```shell
git branch gold
git checkout gold
```{{exec}}

### Transformation to calculate monthly weight

Let's perform an example analysis that is typically performed in the "gold"
layer. Imagine we are a retail company and we need to estimate the number of
trucks we need each month. To do so, we need to calculate the total weight of
all orders per month. We can calculate this with the query in `gold/inventory/monthly_ordered_weight.sql` by joining
the `fact_orders` table with the `dim_product` table. It is typical for queries
in the "gold" layer to compute some kind of aggregation. Run the following command to add the file to the "gold" branch:

```shell
git add gold/inventory/monthly_ordered_weight.sql
git commit -m "gold"
```{{exec}}

### Dashtool build

Again, we will create the corresponding Materialized Views by running the
Dashtool build command.

```shell
./dashtool build
```{{exec}}

### Dashtool workflow

And create the updated Argo Workflow by running the Dashtool workflow command.

```shell
./dashtool workflow
```{{exec}}
  
### Create argo workflow

As before, we have to apply the updated workflow to the Kubernetes cluster.

```shell
kubectl apply -f argo/workflow.yaml
```{{exec}}

Again, head to the [Argo console]({{TRAFFIC_HOST1_2746}}) to run the workflow.

### Merge changes into main

If the transformations ran successfully, you can merge the gold branch into the
main branch.

```shell
git checkout main
git merge gold
```{{exec}}

The last time we execute the dashtool `build` command we were still on the `gold` branch, which means that the newly created entities in the lakehouse are also on the gold branch.
In order to merge them to the `main` branch we have to execute dashtool `build` again on the main branch. So let's do that.

```shell
./dashtool build
```{{exec}}

Similarly, the current workflow will refresh the data on the gold branch. Let's execute dashtool `workflow` on the main branch so that the workflow will refresh the data on the main branch.

```shell
./dashtool workflow
```{{exec}}

And let's apply the newest version to the Kubernetes cluster.

```shell
kubectl apply -f argo/workflow.yaml
```{{exec}}

You can query the data in the [Superset console]({{TRAFFIC_HOST1_8088}}).
