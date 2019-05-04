docker build -t solareenlo/multi-client:latest -t solareenlo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t solareenlo/multi-server:latest -t solareenlo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t solareenlo/multi-worker:latest -t solareenlo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push solareenlo/multi-client:latest
docker push solareenlo/multi-server:latest
docker push solareenlo/multi-worker:latest

docker push solareenlo/multi-client:$SHA
docker push solareenlo/multi-server:$SHA
docker push solareenlo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image solareenlo/server-deployment server=solareenlo/multi-server:$SHA
kubectl set image solareenlo/client-deployment client=solareenlo/multi-client:$SHA
kubectl set image solareenlo/worker-deployment worker=solareenlo/multi-worker:$SHA
