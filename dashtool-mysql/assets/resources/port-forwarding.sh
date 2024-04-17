kubectl port-forward service/mysql 3306:3306 --address 0.0.0.0 &
kubectl port-forward service/localstack 4566:4566 --address 0.0.0.0 &

echo "Press CTRL-C to stop port forwarding and exit the script"
wait
