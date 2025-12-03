package com.coinlab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.coinlab.util.DBUtil;

public class HoldingsDAO {

	public void addCoinHolding(int userId, String coinSymbol, double quantity, double price) {
		String sql = "INSERT INTO holdings(user_id, coin_symbol, quantity, avg_buy_price) " + "VALUES(?, ?, ?, ?) "
				+ "ON DUPLICATE KEY UPDATE " + "quantity = quantity + VALUES(quantity), "
				+ "avg_buy_price = ((quantity * avg_buy_price) + (VALUES(quantity) * VALUES(avg_buy_price))) / (quantity + VALUES(quantity))";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			pstmt.setString(2, coinSymbol);
			pstmt.setDouble(3, quantity);
			pstmt.setDouble(4, price);
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
