package com.coinlab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.coinlab.dto.Transactions;
import com.coinlab.util.DBUtil;

public class TransactionsDAO {
	public void insertTransaction(int userId, String coinSymbol, String transactionType, double quantity, double price,
			double totalAmount) {
		String sql = "insert into transactions(user_id,coin_symbol,transaction_type,quantity,price,total_amount) values(?,?,?,?,?,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			pstmt.setString(2, coinSymbol);
			pstmt.setString(3, transactionType);
			pstmt.setDouble(4, quantity);
			pstmt.setDouble(5, price);
			pstmt.setDouble(6, totalAmount);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				DBUtil.close(conn, pstmt);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public List<Transactions> getTransactionsByUserId(int userId) {
		String sql = "SELECT * FROM transactions WHERE user_id = ? ORDER BY created_at DESC";
		List<Transactions> transactionsList = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Transactions transaction = new Transactions();
				transaction.setTransactionId(rs.getInt("transaction_id"));
				transaction.setUserId(rs.getInt("user_id"));
				transaction.setCoinSymbol(rs.getString("coin_symbol"));
				transaction.setTransactionType(rs.getString("transaction_type"));
				transaction.setQuantity(rs.getDouble("quantity"));
				transaction.setPrice(rs.getDouble("price"));
				transaction.setTotalAmount(rs.getDouble("total_amount"));
				transaction.setFee(rs.getDouble("fee"));
				transaction.setCreatedAt(rs.getTimestamp("created_at"));
				transactionsList.add(transaction);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				DBUtil.close(conn, pstmt, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return transactionsList;
	}
}
