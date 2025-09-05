# JAR 실행용 이미지 (빌드 없음)
FROM eclipse-temurin:17-jre
WORKDIR /app

# 로컬에서 빌드한 JAR 파일 복사
COPY build/libs/*.jar app.jar

# 포트 노출
EXPOSE 80

# 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
