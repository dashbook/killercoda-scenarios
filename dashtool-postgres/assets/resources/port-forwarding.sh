kubectl -n argo port-forward service/argo-server 2746:2746 --address 0.0.0.0 &
kubectl port-forward service/postgres 5432:5432 --address 0.0.0.0 &
kubectl port-forward service/localstack 4566:4566 --address 0.0.0.0 &
kubectl port-forward service/superset 8088:8088 --address 0.0.0.0 &

echo "Press CTRL-C to stop port forwarding and exit the script"
wait
