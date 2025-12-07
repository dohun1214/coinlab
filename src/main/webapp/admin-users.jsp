<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>CoinLab - 관리자 회원관리</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 text-slate-900 font-['Noto_Sans_KR',system-ui,sans-serif]">
<jsp:include page="header.jsp" />

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="users" value="${requestScope.users}" />
<c:set var="totalUsers" value="${not empty requestScope.userCount ? requestScope.userCount : fn:length(users)}" />

<main class="max-w-7xl mx-auto px-4 py-8">
    <c:choose>
        <c:when test="${accessDenied}">
            <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg shadow-sm">
                관리자 권한이 없습니다.
            </div>
        </c:when>
        <c:otherwise>
            <div class="flex items-center justify-between mb-6">
                <div>
                    <h1 class="text-2xl font-bold text-gray-900">회원 관리</h1>
                    <p class="text-sm text-gray-600 mt-1">회원 목록 조회, 권한/닉네임 변경 및 삭제를 관리합니다.</p>
                </div>
                <div class="text-right text-sm text-gray-600">
                    <p>로그인한 관리자</p>
                    <p class="font-semibold text-gray-900">${sessionScope.loginUser.nickname} (${sessionScope.loginUser.username})</p>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                <div class="bg-white border border-gray-200 rounded-lg p-4 shadow-sm">
                    <p class="text-sm text-gray-500 mb-1">전체 회원 수</p>
                    <p class="text-2xl font-bold text-gray-900"><fmt:formatNumber value="${totalUsers}" pattern="#,###" /></p>
                </div>
                <div class="bg-white border border-gray-200 rounded-lg p-4 shadow-sm">
                    <p class="text-sm text-gray-500 mb-1">관리자 수</p>
                    <p class="text-xl font-semibold text-blue-600">
                        <c:set var="adminCount" value="0" />
                        <c:forEach var="user" items="${users}">
                            <c:if test="${user.role eq 'ADMIN'}">
                                <c:set var="adminCount" value="${adminCount + 1}" />
                            </c:if>
                        </c:forEach>
                        <fmt:formatNumber value="${adminCount}" pattern="#,###" />
                    </p>
                </div>
                <div class="bg-white border border-gray-200 rounded-lg p-4 shadow-sm">
                    <p class="text-sm text-gray-500 mb-1">일반 회원 수</p>
                    <p class="text-xl font-semibold text-emerald-600">
                        <fmt:formatNumber value="${totalUsers - adminCount}" pattern="#,###" />
                    </p>
                </div>
            </div>

            <!-- 수동 회원 추가 -->
            <div class="bg-white border border-gray-200 rounded-xl shadow-sm p-5 mb-6">
                <div class="flex items-center justify-between mb-4">
                    <div>
                        <h2 class="text-lg font-semibold text-gray-900">수동으로 회원 추가</h2>
                        <p class="text-sm text-gray-500">필수 정보 입력 후 등록합니다.</p>
                    </div>
                </div>
                <form action="${ctx}/admin/users.do" method="post" class="grid grid-cols-1 md:grid-cols-4 gap-3 items-end">
                    <input type="hidden" name="action" value="create" />
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">아이디</label>
                        <input type="text" name="newUsername" required
                               class="w-full border border-gray-300 rounded-md px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">비밀번호</label>
                        <input type="password" name="password" required
                               class="w-full border border-gray-300 rounded-md px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">이메일</label>
                        <input type="email" name="email" required
                               class="w-full border border-gray-300 rounded-md px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">닉네임</label>
                        <input type="text" name="nickname" required
                               class="w-full border border-gray-300 rounded-md px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    </div>
                    <div class="md:col-span-4 flex justify-end">
                        <button type="submit"
                                class="px-4 py-2.5 bg-blue-600 text-white rounded-md text-sm font-semibold hover:bg-blue-700 transition-colors">
                            회원 추가
                        </button>
                    </div>
                </form>
            </div>

            <div class="bg-white border border-gray-200 rounded-xl shadow-sm overflow-hidden">
                <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
                    <div>
                        <h2 class="text-lg font-semibold text-gray-900">회원 목록</h2>
                        <p class="text-sm text-gray-500">ID, 이메일, 권한, 최근 로그인 등을 확인하세요.</p>
                    </div>
                </div>

                <div class="w-full">
                    <table class="w-full divide-y divide-gray-200 text-sm">
                        <thead class="bg-gray-50">
                        <tr>
                            <th class="px-2 py-3 text-left font-semibold text-gray-600 w-12">#</th>
                            <th class="px-3 py-3 text-left font-semibold text-gray-600 whitespace-nowrap">아이디</th>
                            <th class="px-3 py-3 text-left font-semibold text-gray-600 whitespace-nowrap">닉네임</th>
                            <th class="px-3 py-3 text-left font-semibold text-gray-600 whitespace-nowrap">이메일</th>
                            <th class="px-3 py-3 text-left font-semibold text-gray-600 whitespace-nowrap">권한</th>
                            <th class="px-3 py-3 text-right font-semibold text-gray-600 whitespace-nowrap">원화 잔액 (KRW)</th>
                            <th class="px-3 py-3 text-left font-semibold text-gray-600 whitespace-nowrap">가입일</th>
                            <th class="px-3 py-3 text-left font-semibold text-gray-600 whitespace-nowrap">최근 로그인</th>
                            <th class="px-2 py-3 text-right font-semibold text-gray-600 whitespace-nowrap w-20">삭제</th>
                        </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100 bg-white">
                        <c:forEach var="user" items="${users}" varStatus="loop">
                            <tr class="hover:bg-gray-50">
                                <td class="px-2 py-3 text-gray-500 text-center">${loop.index + 1}</td>
                                <td class="px-3 py-3 font-semibold text-gray-900">${user.username}</td>
                                <td class="px-3 py-3 text-gray-700">
                                    <form action="${ctx}/admin/users.do" method="post" class="flex items-center gap-1">
                                        <input type="hidden" name="action" value="nickname" />
                                        <input type="hidden" name="username" value="${user.username}" />
                                        <input type="text" name="nickname" value="${user.nickname}"
                                               class="w-24 border border-gray-300 rounded px-2 py-1 text-xs focus:outline-none focus:ring-1 focus:ring-blue-500" />
                                        <button type="submit" class="px-2 py-1 rounded text-xs font-semibold border border-blue-200 bg-blue-50 text-blue-700 hover:bg-blue-100 transition-colors whitespace-nowrap">
                                            변경
                                        </button>
                                    </form>
                                </td>
                                <td class="px-3 py-3 text-gray-700 text-sm">${user.email}</td>
                                <td class="px-3 py-3">
                                    <form action="${ctx}/admin/users.do" method="post" class="flex items-center gap-1">
                                        <input type="hidden" name="action" value="role" />
                                        <input type="hidden" name="username" value="${user.username}" />
                                        <select name="role" class="border border-gray-300 rounded px-2 py-1 text-xs focus:outline-none focus:ring-1 focus:ring-blue-500">
                                            <option value="USER" ${user.role eq 'USER' ? 'selected' : ''}>일반</option>
                                            <option value="ADMIN" ${user.role eq 'ADMIN' ? 'selected' : ''}>관리자</option>
                                        </select>
                                        <button type="submit" class="px-2 py-1 rounded text-xs font-semibold border border-indigo-200 bg-indigo-50 text-indigo-700 hover:bg-indigo-100 transition-colors whitespace-nowrap">
                                            변경
                                        </button>
                                    </form>
                                </td>
                                <td class="px-3 py-3 text-right text-gray-800">
                                    <form action="${ctx}/admin/users.do" method="post" class="flex items-center justify-end gap-1">
                                        <input type="hidden" name="action" value="balance" />
                                        <input type="hidden" name="username" value="${user.username}" />
                                        <c:set var="userAssets" value="${assetsMap[user.userId]}" />
                                        <input type="text" name="krwBalance"
                                               value="<fmt:formatNumber value='${userAssets.krwBalance}' pattern='#,###'/>"
                                               class="w-28 text-right border border-gray-300 rounded px-2 py-1 text-xs focus:outline-none focus:ring-1 focus:ring-blue-500" />
                                        <button type="submit" class="px-2 py-1 rounded text-xs font-semibold border border-emerald-200 bg-emerald-50 text-emerald-700 hover:bg-emerald-100 transition-colors whitespace-nowrap">
                                            변경
                                        </button>
                                    </form>
                                </td>
                                <td class="px-3 py-3 text-gray-700">
                                    <span class="inline-block px-2 py-1 rounded bg-slate-50 text-slate-700 text-[11px] font-mono whitespace-nowrap">
                                        <fmt:formatDate value="${user.createdAt}" pattern="yy-MM-dd HH:mm" />
                                    </span>
                                </td>
                                <td class="px-3 py-3 text-gray-700">
                                    <c:choose>
                                        <c:when test="${not empty user.lastLogin}">
                                            <span class="inline-block px-2 py-1 rounded bg-slate-50 text-slate-700 text-[11px] font-mono whitespace-nowrap">
                                                <fmt:formatDate value="${user.lastLogin}" pattern="yy-MM-dd HH:mm" />
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-slate-400 text-xs">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-2 py-3 text-right">
                                    <form action="${ctx}/admin/users.do" method="post" class="inline-flex" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="username" value="${user.username}" />
                                        <button type="submit" class="px-2 py-1 rounded text-xs font-semibold border border-red-200 bg-red-50 text-red-700 hover:bg-red-100 transition-colors whitespace-nowrap">
                                            삭제
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty users}">
                            <tr>
                                <td colspan="9" class="px-4 py-8 text-center text-gray-500">
                                    등록된 회원이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</main>

</body>
</html>
