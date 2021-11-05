#!/bin/sh -l

mkdir /repo && cd /repo
git clone https://github.com/distributed-technologies/helm-charts.git
cd helm-charts/charts

for chart in */chart ; do
    #grep "dependencies:" $chart/Chart.yaml -A 25 
    
    DEPENDENCIES=$(helm dependency list $chart/)

    echo "$DEPENDENCIES" | while IFS= read -r line ; do 
    
    STRING=$line
    
    if [[ "$STRING" != *"STATUS"* ]] && [[ "$STRING" != *"WARNING:"* ]]; then
        NAME=$(echo $STRING | cut -d " " -f 1)
        VERSION=$(echo $STRING | cut -d " " -f 2)
        URL=$(echo $STRING | cut -d " " -f 3)
        if [ "${URL: -1}" = "/" ]; then
            INDEXURL="${URL}index.yaml"
        else
            INDEXURL="$URL/index.yaml"
        fi
        echo $NAME
        echo $VERSION
        echo $INDEXURL
    fi
    done
done



echo "::set-output name=time::$time"
