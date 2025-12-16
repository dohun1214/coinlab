package com.coinlab.dto;

import java.sql.Timestamp;

public class Transactions {
	private int transactionId;
	private int userId;
	private String coinSymbol;
	private String transactionType; // "BUY" or "SELL"
	private double quantity;
	private double price;
	private double totalAmount;
	private double fee;
	private Timestamp createdAt;

	public Transactions() {
	}

	public Transactions(int userId, String coinSymbol, String transactionType, double quantity, double price,
			double totalAmount, double fee) {
		this.userId = userId;
		this.coinSymbol = coinSymbol;
		this.transactionType = transactionType;
		this.quantity = quantity;
		this.price = price;
		this.totalAmount = totalAmount;
		this.fee = fee;
	}

	public Transactions(int transactionId, int userId, String coinSymbol, String transactionType, double quantity,
			double price, double totalAmount, double fee, Timestamp createdAt) {
		this.transactionId = transactionId;
		this.userId = userId;
		this.coinSymbol = coinSymbol;
		this.transactionType = transactionType;
		this.quantity = quantity;
		this.price = price;
		this.totalAmount = totalAmount;
		this.fee = fee;
		this.createdAt = createdAt;
	}

	public int getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(int transactionId) {
		this.transactionId = transactionId;
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

	public String getTransactionType() {
		return transactionType;
	}

	public void setTransactionType(String transactionType) {
		this.transactionType = transactionType;
	}

	public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public double getFee() {
		return fee;
	}

	public void setFee(double fee) {
		this.fee = fee;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "Transaction [transactionId=" + transactionId + ", userId=" + userId + ", coinSymbol=" + coinSymbol
				+ ", transactionType=" + transactionType + ", quantity=" + quantity + ", price=" + price
				+ ", totalAmount=" + totalAmount + ", fee=" + fee + ", createdAt=" + createdAt + "]";
	}

}
