docker build -t tordanf/multi-client:latest -t tordanf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tordanf/multi-server:latest -t tordanf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tordanf/multi-worker:latest -t tordanf/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tordanf/multi-client:latest
docker push tordanf/multi-worker:latest
docker push tordanf/multi-server:latest

docker push tordanf/multi-client:$SHA
docker push tordanf/multi-server:$SHA
docker push tordanf/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployements/server-deployment server=tordanf/multi-server:$SHA
kubectl set image deployements/client-deployment client=tordanf/multi-client:$SHA
kubectl set image deployements/worker-deployment worker=tordanf/multi-worker:$SHA
