kubectl port-forward service/postgres 5432:5432 --address 0.0.0.0 &
kubectl port-forward service/localstack 4566:4566 --address 0.0.0.0 &

echo "Press CTRL-C to stop port forwarding and exit the script"
wait
