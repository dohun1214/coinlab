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
    <title>CoinLab - 게시판</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 text-slate-900">

<%@ include file="header.jsp" %>

<main class="max-w-5xl mx-auto px-6 py-10 space-y-6">
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-3xl font-bold">게시판</h1>
            <p class="text-sm text-slate-500 mt-1">투자 정보와 의견을 공유하세요</p>
        </div>
        <a href="<c:url value='/board-write.jsp' />" class="px-5 py-2.5 rounded-lg bg-slate-900 text-white text-sm font-semibold hover:bg-slate-800 transition-colors">
            글쓰기
        </a>
    </div>

    <c:if test="${empty posts}">
        <div class="bg-white border border-slate-200 rounded-2xl shadow-sm p-8 text-center text-slate-500">
            아직 게시글이 없습니다. 첫 글을 작성해 보세요.
        </div>
    </c:if>

    <section class="space-y-4">
        <c:forEach var="post" items="${posts}">
            <article id="post-${post.postId}" class="bg-white border border-slate-200 rounded-2xl shadow-sm px-6 py-5">
                <div class="flex items-start justify-between gap-3">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full overflow-hidden bg-slate-200">
                            <img src="<c:url value='${empty post.profileImage ? "/images/default-profile.png" : post.profileImage}' />" alt="프로필" class="w-full h-full object-cover">
                        </div>
                        <div>
                            <p class="text-sm font-semibold"><c:out value="${post.nickname}" /></p>
                            <p class="text-xs text-slate-500"><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm" /></p>
                        </div>
                    </div>
                    <c:if test="${sessionScope.loginUser.userId == post.userId or sessionScope.loginUser.role eq 'ADMIN'}">
                        <form action="<c:url value='/board/delete.do' />" method="post" onsubmit="return confirm('게시글을 삭제하시겠습니까?');">
                            <input type="hidden" name="postId" value="${post.postId}">
                            <button type="submit" class="text-xs font-semibold text-red-600 hover:text-red-700 px-3 py-1 rounded-full border border-red-200 bg-red-50">
                                삭제
                            </button>
                        </form>
                    </c:if>
                </div>

                <div class="mt-4 space-y-2">
                    <h2 class="text-lg font-bold text-slate-900"><c:out value="${post.title}" /></h2>
                    <p class="text-sm text-slate-600 leading-relaxed whitespace-pre-line">
                        <c:out value="${post.content}" />
                    </p>
                </div>

                <div class="mt-5 pt-4 border-t border-slate-100 flex items-center gap-6 text-sm text-slate-600">
                    <form action="<c:url value='/board/like.do' />" method="post" class="flex items-center gap-2">
                        <input type="hidden" name="postId" value="${post.postId}">
                        <button type="submit" class="flex items-center gap-2 hover:text-slate-900 transition-colors ${post.likedByMe ? 'text-blue-600' : ''}">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M14 9V5a3 3 0 00-3-3l-4 9v11h10a3 3 0 003-3v-1a3 3 0 00-3-3h-1"></path>
                            </svg>
                            좋아요 ${post.likeCount}
                        </button>
                    </form>
                    <div class="flex items-center gap-2">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M7 8h10M7 12h10m-6 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"></path>
                        </svg>
                        댓글 ${post.commentCount}
                    </div>
                </div>

                <c:if test="${not empty post.comments}">
                    <div class="mt-4 space-y-3">
                        <c:forEach var="comment" items="${post.comments}">
                            <div class="border border-slate-100 rounded-xl px-4 py-3">
                                <div class="flex items-center justify-between gap-2 text-sm">
                                    <div class="flex items-center gap-2">
                                        <div class="w-6 h-6 rounded-full overflow-hidden bg-slate-200">
                                            <img src="<c:url value='${empty comment.profileImage ? "/images/default-profile.png" : comment.profileImage}' />" alt="프로필" class="w-full h-full object-cover">
                                        </div>
                                        <span class="font-semibold"><c:out value="${comment.nickname}" /></span>
                                        <span class="text-xs text-slate-500"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                                    </div>
                                    <c:if test="${sessionScope.loginUser.userId == comment.userId or sessionScope.loginUser.role eq 'ADMIN'}">
                                        <form action="<c:url value='/board/comment/delete.do' />" method="post" onsubmit="return confirm('댓글을 삭제하시겠습니까?');">
                                            <input type="hidden" name="commentId" value="${comment.commentId}">
                                            <input type="hidden" name="postId" value="${post.postId}">
                                            <button type="submit" class="text-[11px] font-semibold text-red-600 hover:text-red-700 px-2 py-1 rounded-full border border-red-200 bg-red-50">
                                                삭제
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                                <p class="mt-2 text-sm text-slate-700 whitespace-pre-line"><c:out value="${comment.content}" /></p>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <form action="<c:url value='/board/comment.do' />" method="post" class="mt-4 flex items-start gap-3">
                    <input type="hidden" name="postId" value="${post.postId}">
                    <textarea name="content" rows="2" required
                              class="flex-1 rounded-lg border border-slate-200 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                              placeholder="댓글을 입력하세요"></textarea>
                    <button type="submit" class="px-4 py-2 rounded-lg bg-slate-900 text-white text-sm font-semibold hover:bg-slate-800">
                        등록
                    </button>
                </form>
            </article>
        </c:forEach>
    </section>
</main>
</body>
</html>
