package com.coinlab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.coinlab.dto.Holdings;
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

	public boolean reduceCoinHolding(int userId, String coinSymbol, double quantity) {
		String sql = "UPDATE holdings SET quantity = quantity - ? WHERE user_id = ? AND coin_symbol = ? AND quantity >= ?";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, quantity);
			pstmt.setInt(2, userId);
			pstmt.setString(3, coinSymbol);
			pstmt.setDouble(4, quantity);
			int affected = pstmt.executeUpdate();
			return affected > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				DBUtil.close(conn, pstmt);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	public List<Holdings> getHoldingsByUserId(int userId) {
		String sql = "SELECT * FROM holdings WHERE user_id = ? AND quantity > 0 ORDER BY updated_at DESC";
		List<Holdings> holdingsList = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Holdings holding = new Holdings();
				holding.setHoldingId(rs.getInt("holding_id"));
				holding.setUserId(rs.getInt("user_id"));
				holding.setCoinSymbol(rs.getString("coin_symbol"));
				holding.setQuantity(rs.getDouble("quantity"));
				holding.setAvgBuyPrice(rs.getDouble("avg_buy_price"));
				holding.setUpdatedAt(rs.getTimestamp("updated_at"));
				holdingsList.add(holding);
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
		return holdingsList;
	}

	public double getCoinHolding(int userId, String coinSymbol) {
		String sql = "SELECT quantity FROM holdings WHERE user_id = ? AND coin_symbol = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			pstmt.setString(2, coinSymbol);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getDouble("quantity");
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
		return 0.0;
	}

}
