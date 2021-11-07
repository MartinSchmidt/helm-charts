# helm-charts
This is our mono repository that contains all of our proxy charts. 

### Building docker images
To include a docker container and have it build and push to the local image registry on github, do the following: 
1. In the folder of your service, create a `container/` folder
2. Place your Dockerfile in the `container/` folder so it will be placed at `helm-charts/charts/<your-service>/container/Dockerfile`
3. Your docker image version will be the same version as your Helm chart, so remember to bump the Helm chart version when you want to update your Dockerfile

Note: Since development is dependent on this feature being implemented, in the first implementation, any push to main will trigger all Dockerfiles to be built. This will be changed in a later version so only the changed Dockerfiles are rebuilt. 