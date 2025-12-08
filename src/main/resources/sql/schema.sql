-- ============================================
-- CoinLab 데이터베이스 생성
-- ============================================
DROP DATABASE IF EXISTS coinlab;
CREATE DATABASE coinlab DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE coinlab;

-- ============================================
-- 1. 회원 테이블 (users)
-- ============================================
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '회원 고유 번호',
    username VARCHAR(50) UNIQUE NOT NULL COMMENT '로그인 ID',
    password VARCHAR(100) NOT NULL COMMENT '비밀번호 (평문 저장)',
    email VARCHAR(100) UNIQUE NOT NULL COMMENT '이메일',
    nickname VARCHAR(50) COMMENT '닉네임',
    role ENUM('USER', 'ADMIN') DEFAULT 'USER' COMMENT '권한 (일반회원/관리자)',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '가입일',
    last_login TIMESTAMP NULL COMMENT '마지막 로그인',
    INDEX idx_username (username),
    INDEX idx_email (email)
) COMMENT '회원 정보';

-- ============================================
-- 2. 자산 테이블 (assets)
-- ============================================
CREATE TABLE assets (
    asset_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '자산 고유 번호',
    user_id INT NOT NULL COMMENT '회원 번호',
    krw_balance DECIMAL(15,2) DEFAULT 100000000.00 COMMENT '보유 원화',
    total_invested DECIMAL(15,2) DEFAULT 0 COMMENT '총 투자금액',
    realized_profit DECIMAL(15,2) DEFAULT 0 COMMENT '누적 실현 손익',
    profit_rate DECIMAL(10,4) DEFAULT 0 COMMENT '수익률 (%)',
    total_fee DECIMAL(15,2) DEFAULT 0 COMMENT '총 거래 수수료',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '업데이트 시간',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user (user_id)
) COMMENT '사용자 자산 정보';

-- ============================================
-- 3. 보유 코인 테이블 (holdings)
-- ============================================
CREATE TABLE holdings (
    holding_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '보유 내역 고유 번호',
    user_id INT NOT NULL COMMENT '회원 번호',
    coin_symbol VARCHAR(20) NOT NULL COMMENT '코인 심볼 (BTC, ETH 등)',
    quantity DECIMAL(20,8) NOT NULL COMMENT '보유 수량',
    avg_buy_price DECIMAL(15,2) NOT NULL COMMENT '평균 매수가',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '업데이트 시간',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_coin (user_id, coin_symbol),
    INDEX idx_user (user_id),
    INDEX idx_coin (coin_symbol)
) COMMENT '사용자 보유 코인';

-- ============================================
-- 4. 거래 내역 테이블 (transactions)
-- ============================================
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '거래 고유 번호',
    user_id INT NOT NULL COMMENT '회원 번호',
    coin_symbol VARCHAR(20) NOT NULL COMMENT '거래 코인',
    transaction_type ENUM('BUY', 'SELL') NOT NULL COMMENT '거래 구분 (매수/매도)',
    quantity DECIMAL(20,8) NOT NULL COMMENT '거래 수량',
    price DECIMAL(15,2) NOT NULL COMMENT '거래 당시 가격',
    total_amount DECIMAL(15,2) NOT NULL COMMENT '총 거래 금액',
    fee DECIMAL(15,2) DEFAULT 0 COMMENT '거래 수수료',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '거래 시간',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_date (user_id, created_at),
    INDEX idx_coin (coin_symbol),
    INDEX idx_type (transaction_type)
) COMMENT '거래 내역';

-- ============================================
-- 5. 관심 코인 테이블 (watchlist)
-- ============================================
CREATE TABLE watchlist (
    watchlist_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '관심 목록 고유 번호',
    user_id INT NOT NULL COMMENT '회원 번호',
    coin_symbol VARCHAR(20) NOT NULL COMMENT '코인 심볼',
    coin_name VARCHAR(50) COMMENT '코인 이름',
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '추가 시간',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_watchlist (user_id, coin_symbol),
    INDEX idx_user (user_id)
) COMMENT '관심 코인';

-- ============================================
-- 6. 게시판 테이블 (board)
-- ============================================
CREATE TABLE board (
    post_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '게시글 고유 번호',
    user_id INT NOT NULL COMMENT '작성자 번호',
    title VARCHAR(200) NOT NULL COMMENT '제목',
    content TEXT NOT NULL COMMENT '내용',
    view_count INT DEFAULT 0 COMMENT '조회수',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_created (created_at),
    INDEX idx_user (user_id)
) COMMENT '게시판';

-- ============================================
-- 7. 댓글 테이블 (comments)
-- ============================================
CREATE TABLE comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '댓글 고유 번호',
    post_id INT NOT NULL COMMENT '게시글 번호',
    user_id INT NOT NULL COMMENT '작성자 번호',
    content TEXT NOT NULL COMMENT '댓글 내용',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
    FOREIGN KEY (post_id) REFERENCES board(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_post (post_id),
    INDEX idx_user (user_id)
) COMMENT '댓글';



-- ============================================
-- 8. 게시글 좋아요 (board_likes)
-- ============================================
CREATE TABLE board_likes (
    like_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '좋아요 고유 번호',
    post_id INT NOT NULL COMMENT '게시글 번호',
    user_id INT NOT NULL COMMENT '사용자 번호',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
    UNIQUE KEY uniq_like (post_id, user_id),
    FOREIGN KEY (post_id) REFERENCES board(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_post (post_id),
    INDEX idx_user (user_id)
) COMMENT '게시글 좋아요';

