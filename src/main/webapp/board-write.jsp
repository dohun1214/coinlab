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
    <title>CoinLab - <c:choose><c:when test="${isEditMode}">글수정</c:when><c:otherwise>글쓰기</c:otherwise></c:choose></title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 text-slate-900">

<%@ include file="header.jsp" %>

<main class="max-w-3xl mx-auto px-6 py-10 space-y-6">
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-3xl font-bold">
                <c:choose>
                    <c:when test="${isEditMode}">글수정</c:when>
                    <c:otherwise>글쓰기</c:otherwise>
                </c:choose>
            </h1>
            <p class="text-sm text-slate-500 mt-1">투자 정보와 의견을 공유하세요.</p>
        </div>
        <a href="<c:url value='/board.do' />" class="text-sm text-slate-600 hover:text-slate-900 font-semibold">목록으로</a>
    </div>

    <c:if test="${not empty errorMsg}">
        <div class="rounded-lg border border-red-200 bg-red-50 text-red-700 px-4 py-3 text-sm">
            ${errorMsg}
        </div>
    </c:if>

    <form action="<c:url value='/board/write.do' />" method="post" class="space-y-4 bg-white border border-slate-200 rounded-2xl shadow-sm p-6">
        <c:if test="${isEditMode}">
            <input type="hidden" name="postId" value="${post.postId}">
        </c:if>

        <div class="space-y-2">
            <label for="title" class="text-sm font-semibold text-slate-700">제목</label>
            <input id="title" name="title" type="text" required
                   value="<c:out value='${post.title}' />"
                   class="w-full rounded-lg border border-slate-200 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                   placeholder="제목을 입력하세요">
        </div>

        <div class="space-y-2">
            <label for="content" class="text-sm font-semibold text-slate-700">내용</label>
            <textarea id="content" name="content" rows="10" required
                      class="w-full rounded-lg border border-slate-200 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                      placeholder="내용을 입력하세요"><c:out value="${post.content}" /></textarea>
        </div>

        <div class="flex items-center justify-end gap-3">
            <a href="<c:url value='/board.do' />" class="px-4 py-2 rounded-lg border border-slate-200 text-sm font-semibold text-slate-700 hover:bg-slate-50">
                취소
            </a>
            <button type="submit" class="px-5 py-2.5 rounded-lg bg-slate-900 text-white text-sm font-semibold hover:bg-slate-800">
                <c:choose>
                    <c:when test="${isEditMode}">수정</c:when>
                    <c:otherwise>등록</c:otherwise>
                </c:choose>
            </button>
        </div>
    </form>
</main>

<%@ include file="footer.jsp" %>

</body>
</html>
