docker build -t wojtasowaty/multi-client:latest -t wojtasowaty/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wojtasowaty/multi-server:latest -t wojtasowaty/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wojtasowaty/multi-worker:latest -t wojtasowaty/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push wojtasowaty/multi-client:latest
dokcer push wojtasowaty/multi-server:latest
docker push wojtasowaty/multi-worker:latest
docker push wojtasowaty/multi-client:$SHA
dokcer push wojtasowaty/multi-server:$SHA
docker push wojtasowaty/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wojtasowaty/multi-server:$SHA
kubectl set image deployments/client-deployment client=wojtasowaty/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wojtasowaty/multi-worker:$SHA