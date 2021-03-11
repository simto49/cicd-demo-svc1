FROM alpine:3.11 AS builder
MAINTAINER junyoung.oh@nhn.com
RUN apk add --update \
    openjdk11 \
    && rm -rf /var/cache/apk
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk
ENV GRADLE_USER_HOME /workspace/.gradle
COPY . /demo-svc1
WORKDIR /demo-svc1
RUN ./gradlew build -x test

FROM alpine:3.11
MAINTAINER junyoung.oh@nhn.com
RUN apk --no-cache add --update bash openjdk11-jre
COPY --from=builder /demo-svc1/build/libs/svc1-*.jar /demo-svc1/svc1.jar
WORKDIR /demo-svc1
CMD ["java", "-jar", "svc1.jar"]
