# 멀티스테이지 빌드 (Docker 내부에서 빌드)
FROM gradle:7.6.4-jdk17 AS build
WORKDIR /app
COPY . .
RUN gradle clean bootJar -x test --no-daemon

# 실행 단계
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 80
ENTRYPOINT ["java", "-jar", "app.jar"]