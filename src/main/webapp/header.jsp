<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    }
</style>

<header class="bg-white border-b border-gray-200 sticky top-0 z-50 shadow-sm">
    <div class="max-w-7xl mx-auto px-6">
        <div class="flex items-center justify-between h-20">
            <!-- Left: Logo & Project Name -->
            <div class="flex items-center space-x-3">
                <a href="<c:url value='/index.jsp' />" class="flex items-center space-x-3 hover:opacity-80 transition-opacity">
                    <img src="<c:url value='/images/coinlab-logo.png' />" alt="CoinLab" class="w-14 h-14">
                    <span class="text-2xl font-bold text-blue-600">CoinLab</span>
                </a>
            </div>

            <!-- Center: Navigation Menu -->
            <nav class="hidden md:flex items-center space-x-10">
                <a href="<c:url value='/trade.jsp' />" class="text-gray-700 hover:text-blue-600 font-semibold text-base transition-colors">거래</a>
                <a href="<c:url value='/mypage.do' />" class="text-gray-700 hover:text-blue-600 font-semibold text-base transition-colors">마이페이지</a>
                <a href="<c:url value='/board.do' />" class="text-gray-700 hover:text-blue-600 font-semibold text-base transition-colors">게시판</a>
                <a href="<c:url value='/ranking.do' />" class="text-gray-700 hover:text-blue-600 font-semibold text-base transition-colors">랭킹</a>
                <c:if test="${sessionScope.loginUser.role eq 'ADMIN'}">
                    <a href="<c:url value='/admin/users.do' />" class="text-gray-700 hover:text-blue-600 font-semibold text-base transition-colors">
                        관리자
                    </a>
                </c:if>
            </nav>

            <!-- Right: User Info or Login/Register -->
            <div class="flex items-center space-x-4">
                <c:choose>
                    <%-- 로그인 상태 --%>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <div class="flex items-center space-x-4">
                            <div class="text-right">
                                <p class="text-base font-bold text-gray-900">${sessionScope.loginUser.nickname} 님</p>
                                <p class="text-sm font-semibold text-blue-600">
                                    잔액: <fmt:formatNumber value="${ sessionScope.userAssets.krwBalance}" pattern="#,###"/>원
                                </p>
                            </div>
                            <a href="<c:url value='/logout.do' />" class="flex items-center space-x-1 px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-lg font-medium transition-colors">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                                </svg>
                                <span>로그아웃</span>
                            </a>
                        </div>
                    </c:when>

                    <%-- 비로그인 상태 --%>
                    <c:otherwise>
                        <a href="<c:url value='/login.jsp' />" class="px-4 py-2 text-gray-700 hover:text-blue-600 font-medium transition-colors">
                            로그인
                        </a>
                        <a href="<c:url value='/register.jsp' />" class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-medium transition-colors">
                            회원가입
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>
