<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<footer class="bg-slate-900 text-slate-300 mt-16">
    <div class="max-w-7xl mx-auto px-6 py-12">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- About Section -->
            <div>
                <h3 class="text-white text-lg font-bold mb-4">CoinLab</h3>
                <p class="text-sm leading-relaxed">
                    실전 같은 모의 투자로 안전하게<br>
                    가상화폐 거래를 경험하고<br>
                    투자 실력을 키워보세요
                </p>
            </div>

            <!-- Quick Links -->
            <div>
                <h3 class="text-white text-lg font-bold mb-4">바로가기</h3>
                <ul class="space-y-2 text-sm">
                    <li><a href="<c:url value='/trade.jsp' />" class="hover:text-white transition-colors">거래소</a></li>
                    <li><a href="<c:url value='/ranking.do' />" class="hover:text-white transition-colors">랭킹</a></li>
                    <li><a href="<c:url value='/board.do' />" class="hover:text-white transition-colors">게시판</a></li>
                    <li><a href="<c:url value='/mypage.do' />" class="hover:text-white transition-colors">마이페이지</a></li>
                </ul>
            </div>

            <!-- Info -->
            <div>
                <h3 class="text-white text-lg font-bold mb-4">정보</h3>
                <ul class="space-y-2 text-sm">
                    <li class="text-slate-400">가상 투자 시뮬레이터</li>
                    <li class="text-slate-400">실제 거래가 아닙니다</li>
                    <li class="text-slate-400">교육 목적으로만 사용하세요</li>
                </ul>
            </div>
        </div>

        <!-- Bottom Bar -->
        <div class="border-t border-slate-800 mt-8 pt-8 text-center">
            <p class="text-sm text-slate-500">
                &copy; 2025 CoinLab. All rights reserved.
            </p>
        </div>
    </div>
</footer>
