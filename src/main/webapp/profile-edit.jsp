<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <title>CoinLab - 내 정보 수정</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 text-slate-900">

<%@ include file="header.jsp" %>

<main class="max-w-4xl mx-auto px-6 py-8 space-y-6">
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-2xl font-bold">내 정보 수정</h1>
            <p class="text-sm text-slate-500">현재 비밀번호를 입력하고 변경사항을 저장하세요.</p>
        </div>
        <a href="mypage.jsp" class="px-4 py-2 rounded-lg border border-slate-300 bg-white text-sm font-semibold hover:bg-slate-50">
            마이페이지로 돌아가기
        </a>
    </div>

    <section class="bg-white border border-slate-200 rounded-xl p-6">
        <form action="<c:url value='/profile/update.do' />" method="post" class="space-y-4">
            <input type="hidden" name="username" value="${sessionScope.loginUser.username}"/>

            <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">현재 비밀번호</label>
                <input type="password" name="currentPassword" required
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                <p class="text-xs text-slate-500 mt-1">변경하려면 반드시 입력하세요.</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1">닉네임</label>
                    <input type="text" name="nickname" value="${sessionScope.loginUser.nickname}"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1">이메일</label>
                    <input type="email" name="email" value="${sessionScope.loginUser.email}"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1">새 비밀번호</label>
                    <input type="password" name="newPassword" placeholder="변경 시에만 입력"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1">새 비밀번호 확인</label>
                    <input type="password" name="newPasswordConfirm"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
            </div>

            <div class="flex justify-end gap-2 pt-2">
                <a href="mypage.jsp" class="px-4 py-2 rounded-lg border border-slate-300 text-sm bg-white">취소</a>
                <button type="submit" class="px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-semibold hover:bg-blue-700">
                    저장
                </button>
            </div>

            <c:if test="${not empty requestScope.errorMsg}">
                <p class="mt-4 text-sm text-red-600">${requestScope.errorMsg}</p>
            </c:if>
            <c:if test="${not empty requestScope.successMsg}">
                <p class="mt-4 text-sm text-emerald-600">${requestScope.successMsg}</p>
            </c:if>
        </form>
    </section>
</main>
</body>
</html>
