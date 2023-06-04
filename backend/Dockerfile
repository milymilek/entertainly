FROM eclipse-temurin:11-jdk-focal

WORKDIR /app

COPY build.gradle settings.gradle ./
COPY gradlew ./
COPY gradle ./gradle
RUN ./gradlew --no-daemon dependencies

COPY src ./src

RUN ./gradlew clean
RUN ./gradlew bootJar

CMD ["java", "-jar", "build/libs/kosciuszkon-0.0.1-SNAPSHOT.jar"]

EXPOSE 8080