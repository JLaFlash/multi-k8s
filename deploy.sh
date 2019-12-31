docker build -t laflash/k8s_client:latest -t laflash/k8s_client:$SHA -f ./client/Dockerfile ./client
docker build -t laflash/k8s_server:latest -t laflash/k8s_server:$SHA -f ./server/Dockerfile ./server
docker build -t laflash/k8s_worker:latest -t laflash/k8s_worker:$SHA -f ./worker/Dockerfile ./worker
docker push laflash/k8s_client:latest
docker push laflash/k8s_server:latest
docker push laflash/k8s_worker:latest
docker push laflash/k8s_client:$SHA
docker push laflash/k8s_server:$SHA
docker push laflash/k8s_worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=laflash/k8s_server:$SHA
kubectl set image deployments/client-deployment client=laflash/k8s_client:$SHA
kubectl set image deployments/worker-deployment worker=laflash/k8s_worker:$SHA

