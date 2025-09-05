# 빌드 단계
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]

# 실행 단계만 사용
FROM eclipse-temurin:17-jre
WORKDIR /app

# 로컬에서 빌드한 jar 파일을 복사
COPY build/libs/*.jar app.jar

# 컨테이너에서 열 포트
EXPOSE 80

# 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
