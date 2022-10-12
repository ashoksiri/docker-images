FROM alpine as BASE

ENV WORKDIR=/app
WORKDIR ${WORKDIR}
COPY ./backend ${WORKDIR}/backend
RUN apk update && apk add openjdk8 maven
RUN cd ${WORKDIR}/backend && mvn clean package

FROM node:16.10.0-alpine as NODE
ENV WORKDIR=/app
WORKDIR ${WORKDIR}
COPY ./todo ${WORKDIR}/frontend
RUN cd ${WORKDIR}/frontend && npm install && npm run build

FROM tomcat:8.5-jre8-alpine as SERVER
COPY --from=BASE  /app/backend/target/demo-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/console.war
COPY --from=NODE  /app/frontend/dist/todo/* /usr/local/tomcat/webapps/ROOT/
EXPOSE 8080



