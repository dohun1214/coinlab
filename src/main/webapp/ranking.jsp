<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>CoinLab - 랭킹</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 text-slate-900">

<%@ include file="header.jsp" %>

<main class="max-w-5xl mx-auto px-6 py-10 space-y-6">
    <div>
        <h1 class="text-3xl font-bold">랭킹</h1>
        <p class="text-sm text-slate-500 mt-1">수익률 기준 사용자 랭킹</p>
    </div>

    <section class="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
        <c:if test="${empty rankings}">
            <div class="p-8 text-center text-slate-500">
                아직 랭킹 데이터가 없습니다.
            </div>
        </c:if>

        <c:if test="${not empty rankings}">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-slate-50 border-b border-slate-200">
                        <tr>
                            <th class="text-left py-4 px-6 text-sm font-semibold text-slate-700">순위</th>
                            <th class="text-left py-4 px-6 text-sm font-semibold text-slate-700">닉네임</th>
                            <th class="text-right py-4 px-6 text-sm font-semibold text-slate-700">수익률</th>
                            <th class="text-right py-4 px-6 text-sm font-semibold text-slate-700">실현 손익</th>
                            <th class="text-right py-4 px-6 text-sm font-semibold text-slate-700">보유 자산</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ranking" items="${rankings}" varStatus="status">
                            <tr class="border-b border-slate-100 hover:bg-slate-50 transition-colors ${not empty sessionScope.loginUser and ranking.userId == sessionScope.loginUser.userId ? 'bg-blue-50' : ''}">
                                <td class="py-4 px-6">
                                    <div class="flex items-center gap-2">
                                        <c:choose>
                                            <c:when test="${status.index == 0}">
                                                <span class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-gradient-to-br from-yellow-400 to-yellow-600 text-white text-sm font-bold">1</span>
                                            </c:when>
                                            <c:when test="${status.index == 1}">
                                                <span class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-gradient-to-br from-gray-300 to-gray-500 text-white text-sm font-bold">2</span>
                                            </c:when>
                                            <c:when test="${status.index == 2}">
                                                <span class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-gradient-to-br from-orange-400 to-orange-600 text-white text-sm font-bold">3</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-sm font-semibold text-slate-600">${status.index + 1}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td class="py-4 px-6">
                                    <div class="flex items-center gap-2">
                                        <span class="font-semibold text-slate-900">
                                            <c:out value="${ranking.nickname}" />
                                        </span>
                                        <c:if test="${not empty sessionScope.loginUser and ranking.userId == sessionScope.loginUser.userId}">
                                            <span class="text-xs bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full font-semibold">나</span>
                                        </c:if>
                                    </div>
                                </td>
                                <td class="py-4 px-6 text-right">
                                    <c:choose>
                                        <c:when test="${ranking.profitRate >= 0}">
                                            <span class="font-bold text-emerald-600">
                                                +<fmt:formatNumber value="${ranking.profitRate}" pattern="#,##0.##" />%
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="font-bold text-red-600">
                                                <fmt:formatNumber value="${ranking.profitRate}" pattern="#,##0.##" />%
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="py-4 px-6 text-right">
                                    <c:choose>
                                        <c:when test="${ranking.realizedProfit >= 0}">
                                            <span class="text-emerald-600">
                                                +<fmt:formatNumber value="${ranking.realizedProfit}" pattern="#,###" /> 원
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-red-600">
                                                <fmt:formatNumber value="${ranking.realizedProfit}" pattern="#,###" /> 원
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="py-4 px-6 text-right text-slate-700">
                                    <fmt:formatNumber value="${ranking.krwBalance}" pattern="#,###" /> 원
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </section>
</main>
</body>
</html>
