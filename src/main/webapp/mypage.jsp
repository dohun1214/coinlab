<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    if (session.getAttribute("loginUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>CoinLab - 마이페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 text-slate-900">

<%@ include file="header.jsp" %>

<main class="max-w-6xl mx-auto px-6 py-8 space-y-6">
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-2xl font-bold">마이페이지</h1>
            <p class="text-sm text-slate-500">포트폴리오와 계정 정보를 확인하고 수정하세요.</p>
        </div>
        <a href="profile-edit.jsp"
           class="px-4 py-2.5 rounded-lg bg-blue-600 text-white text-sm font-semibold hover:bg-blue-700">
            내 정보 수정
        </a>
    </div>

    <!-- 요약 카드 -->
    <section class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div class="bg-white border border-slate-200 rounded-xl p-5">
            <div class="text-sm text-slate-500 mb-1">초기 예산</div>
            <div class="text-2xl font-bold text-slate-900">
                <fmt:formatNumber value="${sessionScope.loginUser.initialBalance}" pattern="#,###"/> 원
            </div>
            <p class="text-xs text-slate-400 mt-2">입금/출금 기록 기준 (샘플 값)</p>
        </div>
        <div class="bg-white border border-slate-200 rounded-xl p-5">
            <div class="text-sm text-slate-500 mb-1">총 손익</div>
            <div class="text-2xl font-bold text-emerald-600">+0 원</div>
            <p class="text-xs text-slate-400 mt-2">추가 연동 시 자동 계산됩니다.</p>
        </div>
        <div class="bg-white border border-slate-200 rounded-xl p-5">
            <div class="text-sm text-slate-500 mb-1">수익률</div>
            <div class="text-2xl font-bold text-emerald-600">+0.00%</div>
            <p class="text-xs text-slate-400 mt-2">보유 자산 기준</p>
        </div>
    </section>

    <!-- 내 정보 -->
    <section class="bg-white border border-slate-200 rounded-xl p-6">
        <h2 class="text-lg font-semibold mb-4">내 정보</h2>
        <dl class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
            <div>
                <dt class="text-slate-500">아이디</dt>
                <dd class="font-semibold">${sessionScope.loginUser.username}</dd>
            </div>
            <div>
                <dt class="text-slate-500">닉네임</dt>
                <dd class="font-semibold">${sessionScope.loginUser.nickname}</dd>
            </div>
            <div>
                <dt class="text-slate-500">이메일</dt>
                <dd class="font-semibold">${sessionScope.loginUser.email}</dd>
            </div>
            <div>
                <dt class="text-slate-500">최근 로그인</dt>
                <dd class="font-semibold">
                    <fmt:formatDate value="${sessionScope.loginUser.lastLogin}" pattern="yyyy-MM-dd HH:mm" />
                </dd>
            </div>
        </dl>
        <c:if test="${not empty requestScope.errorMsg}">
            <p class="mt-4 text-sm text-red-600">${requestScope.errorMsg}</p>
        </c:if>
        <c:if test="${not empty requestScope.successMsg}">
            <p class="mt-4 text-sm text-emerald-600">${requestScope.successMsg}</p>
        </c:if>
    </section>
</main>
</body>
</html>
