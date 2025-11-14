# CoinLab

JSP/Servlet 기반 가상 코인 거래 웹 프로젝트

## 기술 스택
- Java 21
- JSP/Servlet (Jakarta EE)
- MySQL
- Apache Tomcat 10.1
- Eclipse IDE for Enterprise Java and Web Developers

## 개발 환경 설정 및 실행 방법

### 1. 사전 준비
- JDK 21 설치
- Eclipse IDE for Enterprise Java and Web Developers 설치
- Apache Tomcat 10.1 다운로드
- MySQL 설치 및 실행

### 2. 프로젝트 Clone
```bash
git clone https://github.com/dohun1214/coinlab.git
```

### 3. Eclipse에서 프로젝트 Import

1. Eclipse 실행
2. `File` → `Import...` 선택
3. `General` → `Existing Projects into Workspace` 선택 후 `Next`
4. `Select root directory` 클릭 후 clone한 `CoinLab` 폴더 선택
5. Projects 목록에 `CoinLab` 프로젝트가 체크되어 있는지 확인
6. `Finish` 클릭

### 4. 데이터베이스 설정

1. MySQL 접속
2. `src/main/resources/sql/schema.sql` 파일 실행하여 데이터베이스 생성
3. `src/main/resources/db.properties.example` 파일을 복사하여 `db.properties` 생성
4. `db.properties`에 본인의 MySQL 접속 정보 입력
   ```properties
   db.url=jdbc:mysql://localhost:3306/coinlab
   db.username=your_username
   db.password=your_password
   ```

### 5. Tomcat 서버 설정

1. Eclipse 하단의 `Servers` 탭 클릭 (없으면 `Window` → `Show View` → `Servers`)
2. `No servers are available. Click this link to create a new server...` 클릭
3. `Apache` → `Tomcat v10.1 Server` 선택 후 `Next`
4. `Browse...` 클릭하여 다운로드한 Tomcat 10.1 폴더 선택
5. `Next` 클릭
6. `Available` 목록에서 `CoinLab` 프로젝트 선택 후 `Add` 클릭
7. `Finish` 클릭

### 6. 프로젝트 실행

1. `Servers` 탭에서 `Tomcat v10.1 Server` 우클릭
2. `Start` 선택
3. 브라우저에서 `http://localhost:8080/CoinLab` 접속

### 7. 문제 해결

**프로젝트가 인식되지 않는 경우:**
- 프로젝트 우클릭 → `Properties` → `Project Facets`에서 `Dynamic Web Module` 체크 확인

**서버 실행 오류:**
- 프로젝트 우클릭 → `Properties` → `Targeted Runtimes`에서 Tomcat 10.1 체크 확인
- `Project` → `Clean...` 실행 후 재시작

**라이브러리 오류:**
- 프로젝트 우클릭 → `Build Path` → `Configure Build Path`
- `Libraries` 탭에서 JRE System Library가 JavaSE-21인지 확인

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
