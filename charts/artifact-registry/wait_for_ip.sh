SERVICE_NAME=$1
i=0
# Wait for loadbalancer IP
while ([ -z $(kubectl get svc $SERVICE_NAME -o=jsonpath='{.status.loadBalancer.ingress[0].ip}') ] && [ $i -le 120 ]); 
do
    echo "No ip found"
    sleep 1
    i=$((i+1))
done

#Wait for service to have endpoint
while ([ -z $(kubectl get svc $SERVICE_NAME -o=jsonpath='{.spec.clusterIP}') ] && [ $i -le 120 ]); 
do
    echo "No ip found"
    sleep 1
    i=$((i+1))
done

echo "found ip $(kubectl get svc $SERVICE_NAME -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')" 
