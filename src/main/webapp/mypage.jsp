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
        <a href="<c:url value='/profile-edit.jsp' />"
           class="px-4 py-2.5 rounded-lg bg-blue-600 text-white text-sm font-semibold hover:bg-blue-700">
            내 정보 수정
        </a>
    </div>

    <!-- 요약 카드 -->
    <section class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div class="bg-white border border-slate-200 rounded-xl p-5">
            <div class="text-sm text-slate-500 mb-1">현재 자산</div>
            <div class="text-2xl font-bold text-slate-900">
                <fmt:formatNumber value="${sessionScope.userAssets.krwBalance}" pattern="#,###"/> 원
            </div>
            <p class="text-xs text-slate-400 mt-2">보유 중인 원화 잔액</p>
        </div>
        <div class="bg-white border border-slate-200 rounded-xl p-5">
            <div class="text-sm text-slate-500 mb-1">총 손익</div>
            <c:choose>
                <c:when test="${sessionScope.userAssets.realizedProfit >= 0}">
                    <div class="text-2xl font-bold text-emerald-600"><fmt:formatNumber value="${sessionScope.userAssets.realizedProfit}" pattern="#,###"/>원</div>
                </c:when>
                <c:otherwise>
                    <div class="text-2xl font-bold text-red-600"><fmt:formatNumber value="${sessionScope.userAssets.realizedProfit}" pattern="#,###"/>원</div>
                </c:otherwise>
            </c:choose>
            <p class="text-xs text-slate-400 mt-2">누적 실현 손익</p>
        </div>
        <div class="bg-white border border-slate-200 rounded-xl p-5">
            <div class="text-sm text-slate-500 mb-1">수익률</div>
            <c:choose>
                <c:when test="${sessionScope.userAssets.profitRate >= 0}">
                    <div class="text-2xl font-bold text-emerald-600"><fmt:formatNumber value="${sessionScope.userAssets.profitRate}" pattern="#,###.##"/> %</div>
                </c:when>
                <c:otherwise>
                    <div class="text-2xl font-bold text-red-600"><fmt:formatNumber value="${sessionScope.userAssets.profitRate}" pattern="#,###.##"/> %</div>
                </c:otherwise>
            </c:choose>
            <p class="text-xs text-slate-400 mt-2">총 투자 대비 수익률</p>
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

    <!-- 보유 코인 -->
    <section class="bg-white border border-slate-200 rounded-xl p-6">
        <h2 class="text-lg font-semibold mb-4">보유 코인</h2>
        <c:if test="${empty holdings}">
            <div class="text-center py-8 text-slate-500 text-sm">
                현재 보유 중인 코인이 없습니다.
            </div>
        </c:if>
        <c:if test="${not empty holdings}">
            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead>
                        <tr class="border-b border-slate-200 text-slate-600">
                            <th class="text-left py-3 px-2">코인</th>
                            <th class="text-right py-3 px-2">보유 수량</th>
                            <th class="text-right py-3 px-2">평균 매수가</th>
                            <th class="text-right py-3 px-2">매수 금액</th>
                            <th class="text-left py-3 px-2">최근 업데이트</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="holding" items="${holdings}">
                            <tr class="border-b border-slate-100 hover:bg-slate-50">
                                <td class="py-3 px-2 font-semibold text-blue-600">${holding.coinSymbol}</td>
                                <td class="py-3 px-2 text-right">
                                    <fmt:formatNumber value="${holding.quantity}" pattern="#,##0.########" />
                                </td>
                                <td class="py-3 px-2 text-right">
                                    <fmt:formatNumber value="${holding.avgBuyPrice}" pattern="#,###" /> 원
                                </td>
                                <td class="py-3 px-2 text-right font-semibold">
                                    <fmt:formatNumber value="${holding.quantity * holding.avgBuyPrice}" pattern="#,###" /> 원
                                </td>
                                <td class="py-3 px-2 text-slate-600">
                                    <fmt:formatDate value="${holding.updatedAt}" pattern="yyyy-MM-dd HH:mm" />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </section>

    <!-- 거래 내역 -->
    <section class="bg-white border border-slate-200 rounded-xl p-6">
        <h2 class="text-lg font-semibold mb-4">거래 내역</h2>
        <c:if test="${empty transactions}">
            <div class="text-center py-8 text-slate-500 text-sm">
                아직 거래 내역이 없습니다.
            </div>
        </c:if>
        <c:if test="${not empty transactions}">
            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead>
                        <tr class="border-b border-slate-200 text-slate-600">
                            <th class="text-left py-3 px-2">거래일시</th>
                            <th class="text-left py-3 px-2">코인</th>
                            <th class="text-center py-3 px-2">구분</th>
                            <th class="text-right py-3 px-2">수량</th>
                            <th class="text-right py-3 px-2">가격</th>
                            <th class="text-right py-3 px-2">거래금액</th>
                            <th class="text-right py-3 px-2">수수료</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tx" items="${transactions}">
                            <tr class="border-b border-slate-100 hover:bg-slate-50">
                                <td class="py-3 px-2 text-slate-600">
                                    <fmt:formatDate value="${tx.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                </td>
                                <td class="py-3 px-2 font-semibold">${tx.coinSymbol}</td>
                                <td class="py-3 px-2 text-center">
                                    <c:choose>
                                        <c:when test="${tx.transactionType == 'BUY'}">
                                            <span class="inline-block px-2 py-1 text-xs font-semibold rounded bg-red-100 text-red-700">매수</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-block px-2 py-1 text-xs font-semibold rounded bg-blue-100 text-blue-700">매도</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="py-3 px-2 text-right">
                                    <fmt:formatNumber value="${tx.quantity}" pattern="#,##0.########" />
                                </td>
                                <td class="py-3 px-2 text-right">
                                    <fmt:formatNumber value="${tx.price}" pattern="#,###" /> 원
                                </td>
                                <td class="py-3 px-2 text-right font-semibold">
                                    <fmt:formatNumber value="${tx.totalAmount}" pattern="#,###" /> 원
                                </td>
                                <td class="py-3 px-2 text-right text-slate-500">
                                    <fmt:formatNumber value="${tx.fee}" pattern="#,###" /> 원
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </section>

    <!-- 회원 탈퇴 -->
    <section class="bg-white border border-red-200 rounded-xl p-6">
        <h2 class="text-lg font-semibold text-red-600 mb-2">회원 탈퇴</h2>
        <p class="text-sm text-slate-600 mb-4">
            계정을 삭제하면 모든 데이터가 영구적으로 삭제되며 복구할 수 없습니다.
        </p>
        <ul class="text-sm text-slate-600 mb-4 space-y-1 list-disc list-inside">
            <li>보유 중인 코인 및 원화 잔액 정보</li>
            <li>거래 내역 및 투자 기록</li>
            <li>게시글, 댓글 및 좋아요</li>
        </ul>
        <form action="<c:url value='/deleteAccount.do' />" method="post"
              onsubmit="return confirm('정말로 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.');">
            <button type="submit"
                    class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white text-sm font-semibold rounded-lg transition-colors">
                회원 탈퇴
            </button>
        </form>
    </section>
</main>

<%@ include file="footer.jsp" %>

</body>
</html>
