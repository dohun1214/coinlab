<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>CoinLab - 모의 코인 투자 시뮬레이터</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 text-slate-900">

<%@ include file="header.jsp" %>

<main class="max-w-7xl mx-auto px-6 py-8 space-y-6">
    <!-- 환영 블록 -->
    <section class="relative bg-gradient-to-br from-slate-900 via-blue-900 to-slate-900 rounded-2xl shadow-xl overflow-hidden">
        <!-- 배경 패턴 -->
        <div class="absolute inset-0 opacity-10">
            <div class="absolute top-0 left-0 w-72 h-72 bg-blue-500 rounded-full filter blur-3xl"></div>
            <div class="absolute bottom-0 right-0 w-96 h-96 bg-purple-500 rounded-full filter blur-3xl"></div>
        </div>

        <!-- 컨텐츠 -->
        <div class="relative px-8 py-8">
            <div class="flex items-center gap-3 mb-3">
                <div class="flex items-center justify-center w-12 h-12 rounded-xl bg-gradient-to-br from-blue-500 to-purple-600 shadow-lg">
                    <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                    </svg>
                </div>
                <h1 class="text-3xl font-bold text-white">CoinLab에 오신 것을 환영합니다</h1>
            </div>
            <p class="text-base text-slate-300 mb-6 max-w-2xl">
                실전 같은 모의 투자로 안전하게 가상화폐 거래를 경험하고, 투자 실력을 키워보세요
            </p>
            <div class="flex flex-wrap gap-3">
                <c:choose>
                    <c:when test="${sessionScope.loginUser != null}">
                        <a href="trade.jsp" class="px-6 py-2.5 rounded-xl bg-gradient-to-r from-blue-500 to-blue-600 text-white text-sm font-bold hover:from-blue-600 hover:to-blue-700 shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-0.5">
                            <span class="flex items-center gap-2">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                                </svg>
                                거래소 바로가기
                            </span>
                        </a>
                        <a href="mypage.do" class="px-6 py-2.5 rounded-xl border-2 border-slate-600 bg-slate-800/50 backdrop-blur text-slate-200 text-sm font-semibold hover:bg-slate-700/50 hover:border-slate-500 transition-all">
                            마이페이지
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="trade.jsp" class="px-6 py-2.5 rounded-xl bg-gradient-to-r from-blue-500 to-blue-600 text-white text-sm font-bold hover:from-blue-600 hover:to-blue-700 shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-0.5">
                            <span class="flex items-center gap-2">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                </svg>
                                거래소 둘러보기
                            </span>
                        </a>
                        <a href="login.jsp" class="px-6 py-2.5 rounded-xl border-2 border-slate-600 bg-slate-800/50 backdrop-blur text-slate-200 text-sm font-semibold hover:bg-slate-700/50 hover:border-slate-500 transition-all">
                            로그인
                        </a>
                        <a href="register.jsp" class="px-6 py-2.5 rounded-xl border-2 border-blue-500/50 bg-blue-500/10 backdrop-blur text-blue-300 text-sm font-semibold hover:bg-blue-500/20 hover:border-blue-400/50 transition-all">
                            회원가입
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- 메인 컨텐츠: 코인 시세(왼쪽) + 랭킹/게시판(오른쪽) -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <!-- 코인 시세 (왼쪽 2칸) -->
        <section class="lg:col-span-2 bg-white border border-slate-200 rounded-xl shadow-sm overflow-hidden">
            <div class="px-6 py-4 border-b border-slate-200">
                <h2 class="text-xl font-bold text-slate-900">주요 코인 시세</h2>
                <p class="text-sm text-slate-500 mt-1">인기 코인 TOP 5</p>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead class="bg-slate-50 border-b border-slate-200">
                        <tr>
                            <th class="px-6 py-3 text-left font-semibold text-slate-600 text-xs">순위</th>
                            <th class="px-6 py-3 text-left font-semibold text-slate-600 text-xs">코인명</th>
                            <th class="px-6 py-3 text-right font-semibold text-slate-600 text-xs">현재가</th>
                            <th class="px-6 py-3 text-right font-semibold text-slate-600 text-xs">전일대비</th>
                            <th class="px-6 py-3 text-right font-semibold text-slate-600 text-xs">거래대금</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        <tr class="hover:bg-slate-50 transition-colors">
                            <td class="px-6 py-4 text-blue-600 font-semibold">1</td>
                            <td class="px-6 py-4">
                                <div class="font-semibold text-slate-900">비트코인</div>
                                <div class="text-xs text-slate-500">KRW-BTC</div>
                            </td>
                            <td id="current-price-1" class="px-6 py-4 text-right font-semibold text-slate-900">-</td>
                            <td id="change-rate-1" class="px-6 py-4 text-right font-bold text-slate-600">-</td>
                            <td id="volume-1" class="px-6 py-4 text-right text-slate-600">-</td>
                        </tr>
                        <tr class="hover:bg-slate-50 transition-colors">
                            <td class="px-6 py-4 text-blue-600 font-semibold">2</td>
                            <td class="px-6 py-4">
                                <div class="font-semibold text-slate-900">이더리움</div>
                                <div class="text-xs text-slate-500">KRW-ETH</div>
                            </td>
                            <td id="current-price-2" class="px-6 py-4 text-right font-semibold text-slate-900">-</td>
                            <td id="change-rate-2" class="px-6 py-4 text-right font-bold text-slate-600">-</td>
                            <td id="volume-2" class="px-6 py-4 text-right text-slate-600">-</td>
                        </tr>
                        <tr class="hover:bg-slate-50 transition-colors">
                            <td class="px-6 py-4 text-blue-600 font-semibold">3</td>
                            <td class="px-6 py-4">
                                <div class="font-semibold text-slate-900">테더</div>
                                <div class="text-xs text-slate-500">KRW-USDT</div>
                            </td>
                            <td id="current-price-3" class="px-6 py-4 text-right font-semibold text-slate-900">-</td>
                            <td id="change-rate-3" class="px-6 py-4 text-right font-bold text-slate-600">-</td>
                            <td id="volume-3" class="px-6 py-4 text-right text-slate-600">-</td>
                        </tr>
                        <tr class="hover:bg-slate-50 transition-colors">
                            <td class="px-6 py-4 text-blue-600 font-semibold">4</td>
                            <td class="px-6 py-4">
                                <div class="font-semibold text-slate-900">리플</div>
                                <div class="text-xs text-slate-500">KRW-XRP</div>
                            </td>
                            <td id="current-price-4" class="px-6 py-4 text-right font-semibold text-slate-900">-</td>
                            <td id="change-rate-4" class="px-6 py-4 text-right font-bold text-slate-600">-</td>
                            <td id="volume-4" class="px-6 py-4 text-right text-slate-600">-</td>
                        </tr>
                        <tr class="hover:bg-slate-50 transition-colors">
                            <td class="px-6 py-4 text-blue-600 font-semibold">5</td>
                            <td class="px-6 py-4">
                                <div class="font-semibold text-slate-900">솔라나</div>
                                <div class="text-xs text-slate-500">KRW-SOL</div>
                            </td>
                            <td id="current-price-5" class="px-6 py-4 text-right font-semibold text-slate-900">-</td>
                            <td id="change-rate-5" class="px-6 py-4 text-right font-bold text-slate-600">-</td>
                            <td id="volume-5" class="px-6 py-4 text-right text-slate-600">-</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="px-6 py-3 bg-slate-50 border-t border-slate-200 text-center">
                <a href="trade.jsp" class="text-sm text-blue-600 hover:text-blue-700 font-semibold">
                    거래소에서 더 많은 코인 보기 →
                </a>
            </div>
        </section>

        <!-- 오른쪽 사이드바: 랭킹 + 게시판 -->
        <div class="space-y-4">
            <!-- 랭킹 섹션 -->
            <section class="bg-white border border-slate-200 rounded-xl shadow-sm overflow-hidden">
            <div class="px-4 py-4 border-b border-slate-200">
                <div class="flex items-center justify-between">
                    <h2 class="text-lg font-bold text-slate-900">실시간 랭킹</h2>
                    <a href="ranking.do" class="text-xs text-blue-600 hover:text-blue-700 font-semibold">
                        전체보기
                    </a>
                </div>
            </div>

            <div class="p-4">
                <c:choose>
                    <c:when test="${not empty topRankings}">
                        <div class="space-y-3">
                            <c:forEach var="ranking" items="${topRankings}" varStatus="status">
                                <div class="flex items-center gap-3 p-3 rounded-lg border border-slate-200 hover:border-blue-300 hover:bg-blue-50/50 transition-all">
                                    <div class="flex-shrink-0 w-10 h-10 rounded-full ${status.index == 0 ? 'bg-gradient-to-br from-yellow-400 to-yellow-600' : status.index == 1 ? 'bg-gradient-to-br from-gray-300 to-gray-500' : 'bg-gradient-to-br from-orange-400 to-orange-600'} flex items-center justify-center text-white text-sm font-bold shadow-md">
                                        ${status.index + 1}
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <div class="font-bold text-sm text-slate-900 truncate">${ranking.nickname}</div>
                                        <div class="text-xs text-slate-600 mt-1">
                                            <fmt:formatNumber value="${ranking.krwBalance}" pattern="#,###"/>원
                                        </div>
                                    </div>
                                    <div class="text-right">
                                        <div class="text-sm font-bold ${ranking.profitRate >= 0 ? 'text-red-600' : 'text-blue-600'}">
                                            ${ranking.profitRate >= 0 ? '+' : ''}<fmt:formatNumber value="${ranking.profitRate}" pattern="#,##0.00"/>%
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-8 text-slate-500">
                            <svg class="w-12 h-12 mx-auto mb-3 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                            </svg>
                            <p class="text-xs">아직 등록된 사용자가 없습니다</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- 게시판 섹션 -->
        <section class="bg-white border border-slate-200 rounded-xl shadow-sm overflow-hidden">
            <div class="px-4 py-4 border-b border-slate-200">
                <div class="flex items-center justify-between">
                    <h2 class="text-lg font-bold text-slate-900">게시판</h2>
                    <a href="board.do" class="text-xs text-blue-600 hover:text-blue-700 font-semibold">
                        전체보기
                    </a>
                </div>
            </div>

            <div class="p-4">
                <c:choose>
                    <c:when test="${not empty recentPosts}">
                        <div class="space-y-3">
                            <c:forEach var="post" items="${recentPosts}" varStatus="status">
                                <div class="py-3 px-3 rounded-lg border border-slate-200 hover:border-blue-300 hover:bg-blue-50/50 transition-all cursor-pointer">
                                    <div class="flex items-start gap-2 mb-2">
                                        <c:if test="${status.index == 0}">
                                            <span class="inline-block px-2 py-0.5 rounded-md bg-blue-600 text-white text-xs font-semibold">
                                                NEW
                                            </span>
                                        </c:if>
                                        <span class="text-sm text-slate-900 font-semibold line-clamp-1 flex-1">
                                            ${post.title}
                                        </span>
                                    </div>
                                    <div class="flex items-center justify-between text-xs text-slate-500">
                                        <span>${post.nickname}</span>
                                        <span>
                                            <fmt:formatDate value="${post.createdAt}" pattern="MM.dd HH:mm"/>
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-8 text-slate-500">
                            <svg class="w-12 h-12 mx-auto mb-3 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                            <p class="text-xs">등록된 글이 없습니다</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
        </div>
    </div>

</main>
<script type="text/javascript" src="js/home.js"></script>
</body>
</html>
