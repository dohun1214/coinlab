package com.coinlab.dto;

import java.sql.Timestamp;

public class Holdings {
	private int holdingId;
	private int userId;
	private String coinSymbol;
	private double quantity;
	private double avgBuyPrice;
	private Timestamp updatedAt;

	public Holdings() {
	}

	public Holdings(int userId, String coinSymbol, double quantity, double avgBuyPrice) {
		this.userId = userId;
		this.coinSymbol = coinSymbol;
		this.quantity = quantity;
		this.avgBuyPrice = avgBuyPrice;
	}

	public Holdings(int holdingId, int userId, String coinSymbol, double quantity, double avgBuyPrice,
			Timestamp updatedAt) {
		this.holdingId = holdingId;
		this.userId = userId;
		this.coinSymbol = coinSymbol;
		this.quantity = quantity;
		this.avgBuyPrice = avgBuyPrice;
		this.updatedAt = updatedAt;
	}

	public int getHoldingId() {
		return holdingId;
	}

	public void setHoldingId(int holdingId) {
		this.holdingId = holdingId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getCoinSymbol() {
		return coinSymbol;
	}

	public void setCoinSymbol(String coinSymbol) {
		this.coinSymbol = coinSymbol;
	}

	public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	public double getAvgBuyPrice() {
		return avgBuyPrice;
	}

	public void setAvgBuyPrice(double avgBuyPrice) {
		this.avgBuyPrice = avgBuyPrice;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	@Override
	public String toString() {
		return "Holdings [holdingId=" + holdingId + ", userId=" + userId + ", coinSymbol=" + coinSymbol + ", quantity="
				+ quantity + ", avgBuyPrice=" + avgBuyPrice + ", updatedAt=" + updatedAt + "]";
	}

}
