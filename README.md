#Using for bitbucket pipelines

###image: pictalingo/docker-node-jdk-chrome:latest

###

``` js
pipelines:

    default:

        - step:

            caches:
                - node

            script:
                - npm install typescript@4.3.5 --save
                - npm install -g @angular/cli@12.1.1
                - npm install --no-optional --no-shrinkwrap --no-package-lock
                - ng --version
                - ng build --prod
```
