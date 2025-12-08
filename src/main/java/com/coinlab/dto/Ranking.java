package com.coinlab.dto;

public class Ranking {
	private int userId;
	private String username;
	private String nickname;
	private double profitRate;
	private double realizedProfit;
	private double krwBalance;

	public Ranking() {
	}

	public Ranking(int userId, String username, String nickname, double profitRate, double realizedProfit,
			double krwBalance) {
		this.userId = userId;
		this.username = username;
		this.nickname = nickname;
		this.profitRate = profitRate;
		this.realizedProfit = realizedProfit;
		this.krwBalance = krwBalance;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public double getProfitRate() {
		return profitRate;
	}

	public void setProfitRate(double profitRate) {
		this.profitRate = profitRate;
	}

	public double getRealizedProfit() {
		return realizedProfit;
	}

	public void setRealizedProfit(double realizedProfit) {
		this.realizedProfit = realizedProfit;
	}

	public double getKrwBalance() {
		return krwBalance;
	}

	public void setKrwBalance(double krwBalance) {
		this.krwBalance = krwBalance;
	}

	@Override
	public String toString() {
		return "Ranking [userId=" + userId + ", username=" + username + ", nickname=" + nickname + ", profitRate="
				+ profitRate + ", realizedProfit=" + realizedProfit + ", krwBalance=" + krwBalance + "]";
	}
}
