FROM alpine:3.11
MAINTAINER junyoung.oh@nhn.com
RUN apk --no-cache add --update bash openjdk11-jre
COPY /build/libs/svc1-*.jar /demo-svc1/svc1.jar
WORKDIR /demo-svc1
CMD ["java", "-jar", "svc1.jar"]
