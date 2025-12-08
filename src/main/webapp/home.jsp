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

<main class="max-w-6xl mx-auto px-6 py-10 space-y-8">
    <!-- 히어로 섹션 -->
    <section class="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
        <div class="bg-gradient-to-r from-blue-600 to-blue-700 text-white px-8 py-10">
            <h1 class="text-4xl font-bold mb-3">CoinLab에 오신 것을 환영합니다</h1>
            <p class="text-lg text-blue-100 mb-6">가상 화폐로 안전하게 투자를 연습하고 실력을 키우세요</p>
            <div class="flex gap-3">
                <c:choose>
                    <c:when test="${sessionScope.loginUser != null}">
                        <a href="trade.jsp" class="px-6 py-3 rounded-lg bg-white text-blue-600 text-sm font-bold hover:bg-blue-50 transition-colors">
                            거래소 바로가기
                        </a>
                        <a href="mypage.do" class="px-6 py-3 rounded-lg border-2 border-white bg-transparent text-white text-sm font-semibold hover:bg-white/10 transition-colors">
                            마이페이지
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="trade.jsp" class="px-6 py-3 rounded-lg bg-white text-blue-600 text-sm font-bold hover:bg-blue-50 transition-colors">
                            거래소 둘러보기
                        </a>
                        <a href="login.jsp" class="px-6 py-3 rounded-lg border-2 border-white bg-transparent text-white text-sm font-semibold hover:bg-white/10 transition-colors">
                            로그인
                        </a>
                        <a href="register.jsp" class="px-6 py-3 rounded-lg border-2 border-white bg-transparent text-white text-sm font-semibold hover:bg-white/10 transition-colors">
                            회원가입
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- 랭킹 & 공지사항 섹션 -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <!-- 랭킹 섹션 -->
        <section class="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
            <div class="px-6 py-4 border-b border-slate-200">
                <div class="flex items-center justify-between">
                    <h2 class="text-xl font-bold text-slate-900">실시간 랭킹</h2>
                    <a href="ranking.do" class="text-sm text-blue-600 hover:text-blue-700 font-semibold">
                        전체보기
                    </a>
                </div>
                <p class="text-sm text-slate-500 mt-1">수익률 기준 상위 3명</p>
            </div>

            <div class="p-6">
                <c:choose>
                    <c:when test="${not empty topRankings}">
                        <div class="space-y-4">
                            <c:forEach var="ranking" items="${topRankings}" varStatus="status">
                                <div class="flex items-center gap-4 p-4 rounded-xl border border-slate-200 hover:border-blue-300 hover:bg-blue-50/50 transition-all">
                                    <div class="flex-shrink-0 w-12 h-12 rounded-full ${status.index == 0 ? 'bg-gradient-to-br from-yellow-400 to-yellow-600' : status.index == 1 ? 'bg-gradient-to-br from-gray-300 to-gray-500' : 'bg-gradient-to-br from-orange-400 to-orange-600'} flex items-center justify-center text-white text-xl font-bold shadow-md">
                                        ${status.index + 1}
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <div class="flex items-center gap-2">
                                            <div class="font-bold text-slate-900 truncate">${ranking.nickname}</div>
                                            <c:if test="${status.index == 0}">
                                                <span class="px-2 py-0.5 bg-yellow-100 text-yellow-700 text-xs font-bold rounded">1위</span>
                                            </c:if>
                                        </div>
                                        <div class="text-sm text-slate-600">
                                            보유 자산 <fmt:formatNumber value="${ranking.krwBalance}" pattern="#,###"/>원
                                        </div>
                                    </div>
                                    <div class="text-right">
                                        <div class="text-lg font-bold ${ranking.profitRate >= 0 ? 'text-red-600' : 'text-blue-600'}">
                                            ${ranking.profitRate >= 0 ? '+' : ''}<fmt:formatNumber value="${ranking.profitRate}" pattern="#,##0.00"/>%
                                        </div>
                                        <div class="text-xs text-slate-500">
                                            ${ranking.realizedProfit >= 0 ? '+' : ''}<fmt:formatNumber value="${ranking.realizedProfit}" pattern="#,###"/>원
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-8 text-slate-500">
                            <svg class="w-16 h-16 mx-auto mb-3 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                            </svg>
                            <p class="text-sm">아직 등록된 사용자가 없습니다</p>
                            <a href="register.jsp" class="inline-block mt-3 text-blue-600 hover:text-blue-700 font-semibold text-sm">
                                첫 번째 사용자가 되어보세요 →
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- 공지사항 섹션 -->
        <section class="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
            <div class="px-6 py-4 border-b border-slate-200">
                <div class="flex items-center justify-between">
                    <h2 class="text-xl font-bold text-slate-900">게시판</h2>
                    <a href="board.do" class="text-sm text-blue-600 hover:text-blue-700 font-semibold">
                        전체보기
                    </a>
                </div>
                <p class="text-sm text-slate-500 mt-1">최신 게시글</p>
            </div>

            <div class="p-6">
                <c:choose>
                    <c:when test="${not empty recentPosts}">
                        <div class="space-y-3">
                            <c:forEach var="post" items="${recentPosts}" varStatus="status">
                                <div class="py-3 px-4 rounded-lg border border-slate-200 hover:border-blue-300 hover:bg-blue-50/50 transition-all cursor-pointer">
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
                            <svg class="w-12 h-12 mx-auto mb-2 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                            <p class="text-sm">등록된 글이 없습니다</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </div>

    <!-- 시세 테이블 -->
    <section class="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
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
                        <th class="px-6 py-3 text-right font-semibold text-slate-600 text-xs">시가총액</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <tr class="hover:bg-slate-50 transition-colors">
                        <td class="px-6 py-4 text-blue-600 font-semibold">1</td>
                        <td class="px-6 py-4">
                            <div class="font-semibold text-slate-900">비트코인</div>
                            <div class="text-xs text-slate-500">BTC/KRW</div>
                        </td>
                        <td class="px-6 py-4 text-right font-semibold text-slate-900">147,000,000</td>
                        <td class="px-6 py-4 text-right font-bold text-blue-600">-2.85%</td>
                        <td class="px-6 py-4 text-right text-slate-600">2,818조</td>
                    </tr>
                    <tr class="hover:bg-slate-50 transition-colors">
                        <td class="px-6 py-4 text-blue-600 font-semibold">2</td>
                        <td class="px-6 py-4">
                            <div class="font-semibold text-slate-900">이더리움</div>
                            <div class="text-xs text-slate-500">ETH/KRW</div>
                        </td>
                        <td class="px-6 py-4 text-right font-semibold text-slate-900">4,802,000</td>
                        <td class="px-6 py-4 text-right font-bold text-blue-600">-2.14%</td>
                        <td class="px-6 py-4 text-right text-slate-600">557조</td>
                    </tr>
                    <tr class="hover:bg-slate-50 transition-colors">
                        <td class="px-6 py-4 text-blue-600 font-semibold">3</td>
                        <td class="px-6 py-4">
                            <div class="font-semibold text-slate-900">테더</div>
                            <div class="text-xs text-slate-500">USDT/KRW</div>
                        </td>
                        <td class="px-6 py-4 text-right font-semibold text-slate-900">1,516</td>
                        <td class="px-6 py-4 text-right font-bold text-blue-600">-0.13%</td>
                        <td class="px-6 py-4 text-right text-slate-600">268조</td>
                    </tr>
                    <tr class="hover:bg-slate-50 transition-colors">
                        <td class="px-6 py-4 text-blue-600 font-semibold">4</td>
                        <td class="px-6 py-4">
                            <div class="font-semibold text-slate-900">리플</div>
                            <div class="text-xs text-slate-500">XRP/KRW</div>
                        </td>
                        <td class="px-6 py-4 text-right font-semibold text-slate-900">3,476</td>
                        <td class="px-6 py-4 text-right font-bold text-blue-600">-1.45%</td>
                        <td class="px-6 py-4 text-right text-slate-600">202조</td>
                    </tr>
                    <tr class="hover:bg-slate-50 transition-colors">
                        <td class="px-6 py-4 text-blue-600 font-semibold">5</td>
                        <td class="px-6 py-4">
                            <div class="font-semibold text-slate-900">솔라나</div>
                            <div class="text-xs text-slate-500">SOL/KRW</div>
                        </td>
                        <td class="px-6 py-4 text-right font-semibold text-slate-900">214,800</td>
                        <td class="px-6 py-4 text-right font-bold text-blue-600">-2.27%</td>
                        <td class="px-6 py-4 text-right text-slate-600">115조</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="px-6 py-4 bg-slate-50 border-t border-slate-200 text-center">
            <a href="trade.jsp" class="text-sm text-blue-600 hover:text-blue-700 font-semibold">
                거래소에서 더 많은 코인 보기 →
            </a>
        </div>
    </section>

</main>

</body>
</html>
