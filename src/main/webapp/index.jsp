<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>코인 시뮬레이터</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 text-slate-900 font-['Noto_Sans_KR',system-ui,sans-serif]">

<%@ include file="header.jsp" %>

<!-- 메인 콘텐츠 -->
<main class="max-w-[1160px] mx-auto px-4 pt-6 pb-10">

    <!-- 첫 줄: 왼쪽 배너 / 오른쪽 전체 랭킹 -->
    <section class="flex gap-6">
        <!-- 왼쪽 배너 -->
        <div class="flex-1 basis-[58%] bg-slate-950 text-white rounded-xl p-7 flex flex-col justify-between">
            <div>
                <div class="text-[18px] font-bold mb-2">대한민국</div>
                <div class="text-[32px] font-extrabold leading-snug mb-7">
                    디지털 자산 거래소<br>
                    <span class="text-sky-400">Coinlab</span>
                </div>
            </div>

            <div class="flex gap-3">
                <button
                    class="px-5 py-2.5 rounded-md bg-blue-600 text-white text-[14px] font-semibold hover:bg-blue-700">
                    거래소 둘러보기
                </button>
                <button
                    class="px-5 py-2.5 rounded-md border border-white/30 bg-transparent text-white text-[14px] hover:bg-white/10">
                    로그인
                </button>
            </div>
        </div>

        <!-- 오른쪽 전체 랭킹 카드 -->
        <div class="flex-1 basis-[42%] bg-white rounded-xl border border-slate-200 p-6">
            <div class="flex items-center justify-between mb-4 text-[14px] font-semibold">
                <div class="flex items-center gap-2">
                  <img src="images/rising.jpg" class="w-4 h-4 rounded-full object-cover border-2 border-blue-600">
                    <span>전체 랭킹</span>
                </div>
            </div>

            <div class="flex items-center justify-between gap-4">
                <div class="flex items-center gap-3">
                    <div
                        class="w-10 h-10 rounded-full bg-indigo-50 flex items-center justify-center text-[22px]">
                        🏆
                    </div>
                    <div class="text-[14px]">
                        <div class="font-semibold mb-1">테스트유저</div>
                        <div class="text-[13px] text-slate-500">총 자산: 10,000,000원</div>
                    </div>
                </div>

                <div class="text-right text-[14px]">
                    <div class="font-bold text-red-500">+0.00%</div>
                    <div class="text-[12px] text-slate-500">+0원</div>
                </div>
            </div>
        </div>
    </section>

    <!-- 두 번째 줄: 시세 테이블 + 공지사항 -->
    <section class="flex gap-6 mt-6">
        <!-- 시세 영역 -->
        <div class="flex-[1.5]">
            <div class="flex gap-4 text-[13px] mb-3">
                <span class="cursor-pointer font-bold text-slate-900">거래량</span>
                <span class="cursor-pointer text-slate-500 hover:text-slate-900">시가총액</span>
                <span class="cursor-pointer text-slate-500 hover:text-slate-900">1h 급상승</span>
                <span class="cursor-pointer text-slate-500 hover:text-slate-900">1h 급하락</span>
            </div>

            <table
                class="w-full border-collapse text-[13px] bg-white rounded-lg overflow-hidden shadow-sm/0">
                <thead class="bg-slate-50">
                <tr>
                    <th class="px-3 py-2 text-left font-semibold text-slate-500 text-xs"> </th>
                    <th class="px-3 py-2 text-left font-semibold text-slate-500 text-xs">코인명/심볼</th>
                    <th class="px-3 py-2 text-right font-semibold text-slate-500 text-xs">현재가</th>
                    <th class="px-3 py-2 text-right font-semibold text-slate-500 text-xs">전일대비</th>
                    <th class="px-3 py-2 text-right font-semibold text-slate-500 text-xs">시가총액</th>
                </tr>
                </thead>
                <tbody>
                <tr class="hover:bg-slate-50">
                    <td class="px-3 py-2 text-blue-600">1</td>
                    <td class="px-3 py-2">비트코인 BTC/KRW</td>
                    <td class="px-3 py-2 text-right">147,000,000</td>
                    <td class="px-3 py-2 text-right text-red-500">-2.85%</td>
                    <td class="px-3 py-2 text-right">2,818조</td>
                </tr>
                <tr class="hover:bg-slate-50">s
                    <td class="px-3 py-2 text-blue-600">2</td>
                    <td class="px-3 py-2">이더리움 ETH/KRW</td>
                    <td class="px-3 py-2 text-right">4,802,000</td>
                    <td class="px-3 py-2 text-right text-red-500">-2.14%</td>
                    <td class="px-3 py-2 text-right">557조</td>
                </tr>
                <tr class="hover:bg-slate-50">
                    <td class="px-3 py-2 text-blue-600">3</td>
                    <td class="px-3 py-2">테더 USDT/KRW</td>
                    <td class="px-3 py-2 text-right">1,516</td>
                    <td class="px-3 py-2 text-right text-red-500">-0.13%</td>
                    <td class="px-3 py-2 text-right">268조</td>
                </tr>
                <tr class="hover:bg-slate-50">
                    <td class="px-3 py-2 text-blue-600">4</td>
                    <td class="px-3 py-2">엑스알피(리플) XRP/KRW</td>
                    <td class="px-3 py-2 text-right">3,476</td>
                    <td class="px-3 py-2 text-right text-red-500">-1.45%</td>
                    <td class="px-3 py-2 text-right">202조</td>
                </tr>
                <tr class="hover:bg-slate-50">
                    <td class="px-3 py-2 text-blue-600">5</td>
                    <td class="px-3 py-2">솔라나 SOL/KRW</td>
                    <td class="px-3 py-2 text-right">214,800</td>
                    <td class="px-3 py-2 text-right text-red-500">-2.27%</td>
                    <td class="px-3 py-2 text-right">115조</td>
                </tr>
                <tr class="hover:bg-slate-50">
                    <td class="px-3 py-2 text-blue-600">6</td>
                    <td class="px-3 py-2">유에스디코인 USDC/KRW</td>
                    <td class="px-3 py-2 text-right">1,517</td>
                    <td class="px-3 py-2 text-right">0.00%</td>
                    <td class="px-3 py-2 text-right">110조</td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- 공지사항 영역 -->
        <div class="flex-1">
            <div class="bg-white rounded-lg border border-slate-200 p-4 pb-2">
                <div class="text-[14px] font-bold mb-3">공지사항</div>

                <div class="flex justify-between items-center py-1.5 text-[12px] border-b border-slate-100">
                    <div class="flex items-center">
                        <span
                            class="inline-block px-1.5 py-0.5 rounded bg-blue-50 text-blue-600 text-[10px] mr-1.5">
                            중요
                        </span>
                        <span class="text-slate-700">CoinLab을 사칭한 거래지원 사기 주의 안내</span>
                    </div>
                    <span class="text-slate-400 whitespace-nowrap ml-2">2025.11.14</span>
                </div>

                <div class="flex justify-between items-center py-1.5 text-[12px] border-b border-slate-100">
                    <div>
                        <span class="text-slate-700">바빌론(BABY) 입출금 일시 중단 안내 (완료)</span>
                    </div>
                    <span class="text-slate-400 whitespace-nowrap ml-2">2025.11.14</span>
                </div>

                <div class="flex justify-between items-center py-1.5 text-[12px] border-b border-slate-100">
                    <div>
                        <span class="text-slate-700">스테이킹 서비스 점검 안내 (11/21 19:00~)</span>
                    </div>
                    <span class="text-slate-400 whitespace-nowrap ml-2">2025.11.14</span>
                </div>

                <div class="flex justify-between items-center py-1.5 text-[12px]">
                    <div>
                        <span class="text-slate-700">스택스(STX) 입출금 일시 중단 안내 (완료)</span>
                    </div>
                    <span class="text-slate-400 whitespace-nowrap ml-2">2025.11.13</span>
                </div>
            </div>
        </div>
    </section>
</main>

</body>
</html>
