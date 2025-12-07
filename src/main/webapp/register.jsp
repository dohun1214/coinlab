<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CoinLab - 회원가입</title>
<script src="https://cdn.tailwindcss.com"></script>
<script>
  function checkDuplicate() {
      const username = document.getElementById("username").value;

      if(username == "") {
          alert("아이디를 입력하세요");
          return;
      }

      // AJAX 요청
      fetch("checkDuplicate.do?username=" + username)
          .then(response => response.json())
          .then(data => {
              const resultDiv = document.getElementById("checkResult");
              if(data.isDuplicate) {
                  resultDiv.className = "block text-red-700 bg-red-50 border border-red-200 text-xs mt-2 px-3 py-2 rounded-md";
                  resultDiv.innerHTML = "이미 사용중인 아이디입니다.";
              } else {
                  resultDiv.className = "block text-green-700 bg-green-50 border border-green-200 text-xs mt-2 px-3 py-2 rounded-md";
                  resultDiv.innerHTML = "사용 가능한 아이디입니다.";
              }
          })
          .catch(error => {
              console.error("Error:", error);
              alert("중복 체크 중 오류가 발생했습니다.");
          });
  }

  function checkEmailDuplicate() {
      const email = document.getElementById("email").value;

      if(email == "") {
          alert("이메일을 입력하세요");
          return;
      }

      // AJAX 요청
      fetch("checkEmailDuplicate.do?email=" + encodeURIComponent(email))
          .then(response => response.json())
          .then(data => {
              const resultDiv = document.getElementById("emailCheckResult");
              if(data.isDuplicate) {
                  resultDiv.className = "block text-red-700 bg-red-50 border border-red-200 text-xs mt-2 px-3 py-2 rounded-md";
                  resultDiv.innerHTML = "이미 사용중인 이메일입니다.";
              } else {
                  resultDiv.className = "block text-green-700 bg-green-50 border border-green-200 text-xs mt-2 px-3 py-2 rounded-md";
                  resultDiv.innerHTML = "사용 가능한 이메일입니다.";
              }
          })
          .catch(error => {
              console.error("Error:", error);
              alert("중복 체크 중 오류가 발생했습니다.");
          });
  }

  function checkPassword() {
      const password = document.getElementById("password").value;
      const passwordConfirm = document.getElementById("passwordConfirm").value;
      const resultDiv = document.getElementById("passwordResult");

      if(password == "" && passwordConfirm == "") {
          resultDiv.className = "hidden text-xs mt-2 px-3 py-2 rounded-md";
          resultDiv.innerHTML = "";
          return false;
      }

      if(password != passwordConfirm) {
          resultDiv.className = "block text-red-700 bg-red-50 border border-red-200 text-xs mt-2 px-3 py-2 rounded-md";
          resultDiv.innerHTML = "비밀번호가 일치하지 않습니다.";
          return false;
      } else {
          resultDiv.className = "block text-green-700 bg-green-50 border border-green-200 text-xs mt-2 px-3 py-2 rounded-md";
          resultDiv.innerHTML = "비밀번호가 일치합니다.";
          return true;
      }
  }

  function validateForm() {
      const username = document.getElementById("username").value;
      const email = document.getElementById("email").value;
      const password = document.getElementById("password").value;
      const passwordConfirm = document.getElementById("passwordConfirm").value;
      const checkResult = document.getElementById("checkResult").innerHTML;
      const emailCheckResult = document.getElementById("emailCheckResult").innerHTML;

      // 아이디 입력 확인
      if(username == "") {
          alert("아이디를 입력해주세요.");
          return false;
      }

      // 중복 체크 확인
      if(!checkResult.includes("사용 가능")) {
          alert("아이디 중복 확인을 해주세요.");
          return false;
      }

      // 중복된 아이디인지 확인
      if(checkResult.includes("이미 사용중")) {
          alert("이미 사용중인 아이디입니다. 다른 아이디를 사용해주세요.");
          return false;
      }

      // 이메일 입력 확인
      if(email == "") {
          alert("이메일을 입력해주세요.");
          return false;
      }

      // 이메일 중복 체크 확인
      if(!emailCheckResult.includes("사용 가능")) {
          alert("이메일 중복 확인을 해주세요.");
          return false;
      }

      // 중복된 이메일인지 확인
      if(emailCheckResult.includes("이미 사용중")) {
          alert("이미 사용중인 이메일입니다. 다른 이메일을 사용해주세요.");
          return false;
      }

      // 비밀번호 입력 확인
      if(password == "" || passwordConfirm == "") {
          alert("비밀번호를 입력해주세요.");
          return false;
      }

      // 비밀번호 일치 확인
      if(!checkPassword()) {
          alert("비밀번호가 일치하지 않습니다.");
          return false;
      }

      return true;
  }
</script>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-50 to-blue-50 py-10 px-5">
	<div class="bg-white rounded-3xl shadow-2xl p-12 w-full max-w-lg">
		<!-- Logo -->
		<div class="w-24 h-24 mx-auto mb-5 bg-white border-4 border-blue-600 rounded-full flex items-center justify-center shadow-lg">
			<img src="images/coinlab-logo.png" alt="CoinLab Logo" class="w-16 h-16 object-contain">
		</div>

		<!-- Title -->
		<h1 class="text-3xl font-bold text-center text-gray-900 mb-2">CoinLab</h1>
		<p class="text-center text-gray-600 text-sm mb-8">가입하고 투자 연습을 시작하세요</p>

		<!-- Register Form -->
		<form action="register.do" method="post" onsubmit="return validateForm()" class="flex flex-col space-y-4">
			<!-- Username -->
			<div>
				<label class="block text-sm font-semibold text-gray-700 mb-2">아이디</label>
				<div class="flex gap-2">
					<input type="text" id="username" name="username" placeholder="아이디를 입력하세요" required
						class="flex-1 px-4 py-3 bg-gray-50 border border-gray-300 rounded-lg text-base focus:outline-none focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-500/10 transition-all">
					<button type="button" class="px-5 py-3 bg-white text-blue-600 border-2 border-blue-600 rounded-lg text-sm font-semibold hover:bg-blue-600 hover:text-white transition-all whitespace-nowrap" onclick="checkDuplicate()">중복확인</button>
				</div>
				<div id="checkResult" class="hidden text-xs mt-2 px-3 py-2 rounded-md"></div>
			</div>

			<!-- Password -->
			<div>
				<label class="block text-sm font-semibold text-gray-700 mb-2">비밀번호</label>
				<input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required
					class="w-full px-4 py-3 bg-gray-50 border border-gray-300 rounded-lg text-base focus:outline-none focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-500/10 transition-all">
			</div>

			<!-- Password Confirm -->
			<div>
				<label class="block text-sm font-semibold text-gray-700 mb-2">비밀번호 확인</label>
				<input type="password" id="passwordConfirm" placeholder="비밀번호를 다시 입력하세요" oninput="checkPassword()" required
					class="w-full px-4 py-3 bg-gray-50 border border-gray-300 rounded-lg text-base focus:outline-none focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-500/10 transition-all">
				<div id="passwordResult" class="hidden text-xs mt-2 px-3 py-2 rounded-md"></div>
			</div>

			<!-- Nickname -->
			<div>
				<label class="block text-sm font-semibold text-gray-700 mb-2">닉네임</label>
				<input type="text" name="nickname" placeholder="닉네임을 입력하세요" required
					class="w-full px-4 py-3 bg-gray-50 border border-gray-300 rounded-lg text-base focus:outline-none focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-500/10 transition-all">
			</div>

			<!-- Email -->
			<div>
				<label class="block text-sm font-semibold text-gray-700 mb-2">이메일</label>
				<div class="flex gap-2">
					<input type="email" id="email" name="email" placeholder="example@email.com" required
						class="flex-1 px-4 py-3 bg-gray-50 border border-gray-300 rounded-lg text-base focus:outline-none focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-500/10 transition-all">
					<button type="button" class="px-5 py-3 bg-white text-blue-600 border-2 border-blue-600 rounded-lg text-sm font-semibold hover:bg-blue-600 hover:text-white transition-all whitespace-nowrap" onclick="checkEmailDuplicate()">중복확인</button>
				</div>
				<div id="emailCheckResult" class="hidden text-xs mt-2 px-3 py-2 rounded-md"></div>
			</div>

			<!-- Register Button -->
			<button type="submit" class="w-full py-3.5 bg-gray-900 text-white rounded-lg text-base font-semibold hover:bg-gray-800 hover:-translate-y-0.5 hover:shadow-lg transition-all mt-2">
				가입하기
			</button>
		</form>

		<!-- Login Link -->
		<div class="text-center mt-6 text-sm text-gray-500">
			이미 계정이 있으신가요?
			<a href="login.jsp" class="text-blue-600 font-semibold hover:text-blue-800 hover:underline transition-colors">로그인</a>
		</div>
	</div>
</body>
</html>
