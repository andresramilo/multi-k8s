docker build -t andresramilo/multi-client:latest -t andresramilo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andresramilo/multi-server:latest -t andresramilo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andresramilo/multi-worker:latest -t andresramilo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push andresramilo/multi-client:latest
docker push andresramilo/multi-server:latest
docker push andresramilo/multi-worker:latest
docker push andresramilo/multi-client:$SHA
docker push andresramilo/multi-server:$SHA
docker push andresramilo/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andresramilo/multi-server:$SHA
kubectl set image deployments/client-deployment client=andresramilo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andresramilo/multi-worker:$SHA