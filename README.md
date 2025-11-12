# CoinLab

JSP/Servlet 기반 가상 코인 거래 웹 프로젝트

## 기술 스택
- Java
- JSP/Servlet
- MySQL
- Eclipse

## 프로젝트 구조
```
src/main/java/com/coinlab/
├── controller/
├── service/
├── dao/
├── dto/
├── filter/
└── util/
```

## 데이터베이스 설정

1. MySQL 접속
2. `src/main/resources/sql/schema.sql` 파일 실행
3. `src/main/resources/db.properties.example`을 복사하여 `db.properties` 파일 생성
4. `db.properties`에 본인의 MySQL 접속 정보 입력
