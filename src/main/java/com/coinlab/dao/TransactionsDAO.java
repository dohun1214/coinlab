package com.coinlab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
