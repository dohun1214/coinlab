package com.coinlab.dto;

import java.sql.Timestamp;

public class Assets {
	private int assetId;
	private int userId;
	private double krwBalance;
	private double totalInvested;
	private double totalValue;
	private double profitRate;
	private Timestamp updatedAt;

	public Assets() {
	}

	public Assets(int userId, double krwBalance) {
		this.userId = userId;
		this.krwBalance = krwBalance;
	}

	public Assets(int assetId, int userId, double krwBalance, double totalInvested, double totalValue,
			double profitRate, Timestamp updatedAt) {
		this.assetId = assetId;
		this.userId = userId;
		this.krwBalance = krwBalance;
		this.totalInvested = totalInvested;
		this.totalValue = totalValue;
		this.profitRate = profitRate;
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

	public double getTotalValue() {
		return totalValue;
	}

	public void setTotalValue(double totalValue) {
		this.totalValue = totalValue;
	}

	public double getProfitRate() {
		return profitRate;
	}

	public void setProfitRate(double profitRate) {
		this.profitRate = profitRate;
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
				+ totalInvested + ", totalValue=" + totalValue + ", profitRate=" + profitRate + ", updatedAt="
				+ updatedAt + "]";
	}

}
