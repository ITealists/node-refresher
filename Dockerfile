FROM alpine:latest

#Copies node:alpine  plus npm
RUN apk add --update \
    bash \
    nodejs \
    nodejs-npm \
    && npm install npm@latest -g

ADD git-setup git-setup
ADD git-refresh git-refresh
#ADD http://saptech-springernature:b3377366d8805f4db2bb24cfc8d0839efe37f648@raw.githubusercontent.com/springernature/repo-refresher/master/git-setup git-setup
#ADD http://saptech-springernature:b3377366d8805f4db2bb24cfc8d0839efe37f648@raw.githubusercontent.com/springernature/repo-refresher/master/git-refresh git-refresh
RUN chmod +x git-*
RUN /bin/bash -c './git-setup'      #this schedules a cron to pick up once repo is specified

ADD node-runner node-runner
RUN chmod +x node-runner
RUN /bin/bash -c './node-runner'    #this schedules a cron to look for repo and start app once it's there

ENV UI_DIR=/html
ENV NODE_DIR=/services
ENV PORT=80

EXPOSE 8080 433 $PORT

ENTRYPOINT ["crond","-l2", "-f"]
