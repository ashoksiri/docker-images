FROM alpine as BASE

ENV WORKDIR=/app
WORKDIR ${WORKDIR}
COPY ./backend ${WORKDIR}/backend

RUN apk update && apk add openjdk8 maven

RUN cd ${WORKDIR}/backend && mvn clean package

FROM node:16.10.0-alpine as NODE
ENV WORKDIR=/app
WORKDIR ${WORKDIR}
# COPY --from=BASE ${WORKDIR}/backend/target/demo-0.0.1-SNAPSHOT.jar ${WORKDIR}/backend
COPY ./todo ${WORKDIR}/frontend
RUN cd ${WORKDIR}/frontend && npm install && npm run build

FROM tomcat:8.5-jre8-alpine as server
COPY --from=BASE  /app/backend/target/demo-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/api.war
COPY --from=NODE  /app/frontend/dist/todo/* /usr/local/tomcat/webapps/ROOT/
# FROM nginx:stable-alpine
# RUN apk update && apk add openjdk8
# RUN mkdir /app
# COPY --from=BASE  /app/backend/target/demo-0.0.1-SNAPSHOT.jar /app
# COPY --from=NODE  /app/frontend/dist/todo/* /usr/share/nginx/html/
# COPY ./default.conf /etx/nginx/conf.d/default.conf
# COPY server.sh /app/
# RUN chmod u+rwx /app/server.sh
# ENTRYPOINT [ "/app/server.sh"]

EXPOSE 8080
# EXPOSE 80



