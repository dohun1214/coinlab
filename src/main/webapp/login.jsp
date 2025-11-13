<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CoinLab - 로그인</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-50 to-blue-50 p-5">
	<div class="bg-white rounded-3xl shadow-2xl p-12 w-full max-w-md">
		<!-- Logo -->
		<div class="w-24 h-24 mx-auto mb-5 bg-white border-4 border-blue-600 rounded-full flex items-center justify-center shadow-lg">
			<img src="images/coinlab-logo.png" alt="CoinLab Logo" class="w-16 h-16 object-contain">
		</div>

		<!-- Title -->
		<h1 class="text-3xl font-bold text-center text-gray-900 mb-2">CoinLab</h1>
		<p class="text-center text-gray-600 text-sm mb-8">모의 투자로 안전하게 연습하세요</p>

		<!-- Error Message -->
		<c:if test="${not empty errorMsg}">
			<div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6 text-sm">
				${errorMsg}
			</div>
		</c:if>

		<!-- Login Form -->
		<form action="login.do" method="post" class="flex flex-col space-y-5">
			<!-- Username -->
			<div>
				<label class="block text-sm font-semibold text-gray-700 mb-2">유저이름</label>
				<input type="text" name="username" placeholder="username" required
					class="w-full px-4 py-3.5 bg-gray-50 border border-gray-300 rounded-lg text-base focus:outline-none focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-500/10 transition-all">
			</div>

			<!-- Password -->
			<div>
				<label class="block text-sm font-semibold text-gray-700 mb-2">비밀번호</label>
				<input type="password" name="password" placeholder="*******" required
					class="w-full px-4 py-3.5 bg-gray-50 border border-gray-300 rounded-lg text-base focus:outline-none focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-500/10 transition-all">
			</div>

			<!-- Login Button -->
			<button type="submit" class="w-full py-3.5 bg-gray-900 text-white rounded-lg text-base font-semibold hover:bg-gray-800 hover:-translate-y-0.5 hover:shadow-lg transition-all mt-2">
				로그인
			</button>
		</form>

		<!-- Register Link -->
		<div class="text-center mt-6 text-sm text-gray-500">
			계정이 없으신가요?
			<a href="register.jsp" class="text-blue-600 font-semibold hover:text-blue-800 hover:underline transition-colors">회원가입</a>
		</div>
	</div>
</body>
</html>