<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
        <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">
                <a href="<c:url value='/board-write.jsp' />" class="px-5 py-2.5 rounded-lg bg-slate-900 text-white text-sm font-semibold hover:bg-slate-800 transition-colors">
                    글쓰기
                </a>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/login.jsp' />" class="px-5 py-2.5 rounded-lg bg-blue-600 text-white text-sm font-semibold hover:bg-blue-700 transition-colors">
                    로그인하고 글쓰기
                </a>
            </c:otherwise>
        </c:choose>
    </div>

    <c:if test="${empty posts}">
        <div class="bg-white border border-slate-200 rounded-2xl shadow-sm p-8 text-center">
            <div class="text-5xl mb-3">📝</div>
            <p class="text-slate-600 mb-2">아직 게시글이 없습니다.</p>
            <c:if test="${not empty sessionScope.loginUser}">
                <p class="text-sm text-slate-500">첫 글을 작성해 보세요!</p>
            </c:if>
        </div>
    </c:if>

    <section class="space-y-4">
        <c:forEach var="post" items="${posts}">
            <article id="post-${post.postId}" class="bg-white border border-slate-200 rounded-2xl shadow-sm px-6 py-5">
                <div class="flex items-start justify-between gap-3">
                    <div>
                        <p class="text-sm font-semibold"><c:out value="${post.nickname}" /></p>
                        <p class="text-xs text-slate-500"><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm" /></p>
                    </div>
                    <c:if test="${sessionScope.loginUser.userId == post.userId or sessionScope.loginUser.role eq 'ADMIN'}">
                        <div class="flex gap-2">
                            <a href="<c:url value='/board/write.do?postId=${post.postId}' />" class="text-xs font-semibold text-blue-600 hover:text-blue-700 px-3 py-1 rounded-full border border-blue-200 bg-blue-50">
                                수정
                            </a>
                            <form action="<c:url value='/board/delete.do' />" method="post" onsubmit="return confirm('게시글을 삭제하시겠습니까?');">
                                <input type="hidden" name="postId" value="${post.postId}">
                                <button type="submit" class="text-xs font-semibold text-red-600 hover:text-red-700 px-3 py-1 rounded-full border border-red-200 bg-red-50">
                                    삭제
                                </button>
                            </form>
                        </div>
                    </c:if>
                </div>

                <div class="mt-4 space-y-2">
                    <h2 class="text-lg font-bold text-slate-900"><c:out value="${post.title}" /></h2>
                    <p class="text-sm text-slate-600 leading-relaxed whitespace-pre-line">
                        <c:out value="${post.content}" />
                    </p>
                </div>

                <div class="mt-5 pt-4 border-t border-slate-100 flex items-center gap-6 text-sm text-slate-600">
                    <c:choose>
                        <c:when test="${not empty sessionScope.loginUser}">
                            <form action="<c:url value='/board/like.do' />" method="post" class="flex items-center gap-2">
                                <input type="hidden" name="postId" value="${post.postId}">
                                <button type="submit" class="flex items-center gap-2 hover:text-slate-900 transition-colors ${post.likedByMe ? 'text-blue-600' : ''}">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M14 9V5a3 3 0 00-3-3l-4 9v11h10a3 3 0 003-3v-1a3 3 0 00-3-3h-1"></path>
                                    </svg>
                                    좋아요 ${post.likeCount}
                                </button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <div class="flex items-center gap-2">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M14 9V5a3 3 0 00-3-3l-4 9v11h10a3 3 0 003-3v-1a3 3 0 00-3-3h-1"></path>
                                </svg>
                                좋아요 ${post.likeCount}
                            </div>
                        </c:otherwise>
                    </c:choose>
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
                            <div class="border border-slate-100 rounded-xl px-4 py-3" id="comment-${comment.commentId}">
                                <div class="flex items-center justify-between gap-2 text-sm">
                                    <div class="flex items-center gap-2">
                                        <span class="font-semibold"><c:out value="${comment.nickname}" /></span>
                                        <span class="text-xs text-slate-500"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                                    </div>
                                    <c:if test="${sessionScope.loginUser.userId == comment.userId or sessionScope.loginUser.role eq 'ADMIN'}">
                                        <div class="flex gap-2">
                                            <button onclick="editComment(${comment.commentId}, ${post.postId})" class="text-[11px] font-semibold text-blue-600 hover:text-blue-700 px-2 py-1 rounded-full border border-blue-200 bg-blue-50">
                                                수정
                                            </button>
                                            <form action="<c:url value='/board/comment/delete.do' />" method="post" onsubmit="return confirm('댓글을 삭제하시겠습니까?');">
                                                <input type="hidden" name="commentId" value="${comment.commentId}">
                                                <input type="hidden" name="postId" value="${post.postId}">
                                                <button type="submit" class="text-[11px] font-semibold text-red-600 hover:text-red-700 px-2 py-1 rounded-full border border-red-200 bg-red-50">
                                                    삭제
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                                <p class="mt-2 text-sm text-slate-700 whitespace-pre-line comment-content"><c:out value="${comment.content}" /></p>
                                <form action="<c:url value='/board/comment/update.do' />" method="post" class="mt-2 hidden comment-edit-form">
                                    <input type="hidden" name="commentId" value="${comment.commentId}">
                                    <input type="hidden" name="postId" value="${post.postId}">
                                    <div class="flex items-start gap-2">
                                        <textarea name="content" rows="2" required
                                                  class="flex-1 rounded-lg border border-slate-200 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                                                  placeholder="댓글을 입력하세요"><c:out value="${comment.content}" /></textarea>
                                        <div class="flex flex-col gap-2">
                                            <button type="submit" class="px-3 py-1.5 rounded-lg bg-blue-600 text-white text-xs font-semibold hover:bg-blue-700">
                                                저장
                                            </button>
                                            <button type="button" onclick="cancelEditComment(${comment.commentId})" class="px-3 py-1.5 rounded-lg border border-slate-200 text-xs font-semibold text-slate-700 hover:bg-slate-50">
                                                취소
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <form action="<c:url value='/board/comment.do' />" method="post" class="mt-4 flex items-start gap-3">
                            <input type="hidden" name="postId" value="${post.postId}">
                            <textarea name="content" rows="2" required
                                      class="flex-1 rounded-lg border border-slate-200 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                                      placeholder="댓글을 입력하세요"></textarea>
                            <button type="submit" class="px-4 py-2 rounded-lg bg-slate-900 text-white text-sm font-semibold hover:bg-slate-800">
                                등록
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="mt-4 flex items-center justify-center gap-2 p-4 bg-slate-100 rounded-lg border border-slate-200">
                            <svg class="w-5 h-5 text-slate-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                            </svg>
                            <span class="text-sm text-slate-600">댓글을 작성하려면 <a href="<c:url value='/login.jsp' />" class="text-blue-600 hover:text-blue-700 font-semibold">로그인</a>이 필요합니다</span>
                        </div>
                    </c:otherwise>
                </c:choose>
            </article>
        </c:forEach>
    </section>
</main>

<script>
function editComment(commentId, postId) {
    const commentDiv = document.getElementById('comment-' + commentId);
    const contentP = commentDiv.querySelector('.comment-content');
    const editForm = commentDiv.querySelector('.comment-edit-form');

    contentP.classList.add('hidden');
    editForm.classList.remove('hidden');
}

function cancelEditComment(commentId) {
    const commentDiv = document.getElementById('comment-' + commentId);
    const contentP = commentDiv.querySelector('.comment-content');
    const editForm = commentDiv.querySelector('.comment-edit-form');

    contentP.classList.remove('hidden');
    editForm.classList.add('hidden');
}
</script>
</body>
</html>
