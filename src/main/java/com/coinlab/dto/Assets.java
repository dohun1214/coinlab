package com.coinlab.dto;

import java.sql.Timestamp;

public class Assets {
	private int assetId;
	private int userId;
	private double krwBalance;
	private double totalInvested;
	private double realizedProfit;
	private double profitRate;
	private double totalFee;
	private Timestamp updatedAt;

	public Assets() {
	}

	public Assets(int userId, double krwBalance) {
		this.userId = userId;
		this.krwBalance = krwBalance;
	}

	public Assets(int assetId, int userId, double krwBalance, double totalInvested, double realizedProfit,
			double profitRate, double totalFee, Timestamp updatedAt) {
		this.assetId = assetId;
		this.userId = userId;
		this.krwBalance = krwBalance;
		this.totalInvested = totalInvested;
		this.realizedProfit = realizedProfit;
		this.profitRate = profitRate;
		this.totalFee = totalFee;
		this.updatedAt = updatedAt;
	}

	public int getAssetId() {
		return assetId;
	}

	public void setAssetId(int assetId) {
		this.assetId = assetId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public double getKrwBalance() {
		return krwBalance;
	}

	public void setKrwBalance(double krwBalance) {
		this.krwBalance = krwBalance;
	}

	public double getTotalInvested() {
		return totalInvested;
	}

	public void setTotalInvested(double totalInvested) {
		this.totalInvested = totalInvested;
	}

	public double getRealizedProfit() {
		return realizedProfit;
	}

	public void setRealizedProfit(double realizedProfit) {
		this.realizedProfit = realizedProfit;
	}

	public double getProfitRate() {
		return profitRate;
	}

	public void setProfitRate(double profitRate) {
		this.profitRate = profitRate;
	}

	public double getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(double totalFee) {
		this.totalFee = totalFee;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	@Override
	public String toString() {
		return "Assets [assetId=" + assetId + ", userId=" + userId + ", krwBalance=" + krwBalance + ", totalInvested="
				+ totalInvested + ", realizedProfit=" + realizedProfit + ", profitRate=" + profitRate + ", totalFee="
				+ totalFee + ", updatedAt=" + updatedAt + "]";
	}

}
