docker build -t simobr/multi-client:latest -t simobr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t simobr/multi-server:latest -t simobr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t simobr/multi-worker:latest -t simobr/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push simobr/multi-client:latest
docker push simobr/multi-server:latest
docker push simobr/multi-worker:latest

docker push simobr/multi-client:$SHA
docker push simobr/multi-server:$SHA
docker push simobr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=simobr/multi-client:$SHA
kubectl set image deployments/server-deployment server=simobr/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=simobr/multi-worker:$SHA