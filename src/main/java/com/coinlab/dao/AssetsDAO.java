package com.coinlab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.coinlab.dto.Assets;
import com.coinlab.util.DBUtil;

public class AssetsDAO {

	// 회원가입 했을 때 입력될 값
	public void insertInitialAssets(int userId) {
		String sql = "insert into assets(user_id) values(?)";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
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

	public Assets getAssetsByUserId(int userId) {
		String sql = "SELECT * FROM assets WHERE user_id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Assets assets = new Assets();
				assets.setAssetId(rs.getInt("asset_id"));
				assets.setUserId(rs.getInt("user_id"));
				assets.setKrwBalance(rs.getDouble("krw_balance"));
				assets.setTotalInvested(rs.getDouble("total_invested"));
				assets.setTotalValue(rs.getDouble("total_value"));
				assets.setProfitRate(rs.getDouble("profit_rate"));
				assets.setUpdatedAt(rs.getTimestamp("updated_at"));
				return assets;
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
		return null;
	}
	
	
	
	
	public boolean decreaseKrwBalance (int userId,double amount) {
		String sql = "update assets set krw_balance = krw_balance - ? where user_id = ? and krw_balance>=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DBUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setDouble(1, amount);
			pstmt.setInt(2, userId);
			pstmt.setDouble(3, amount);
			int affected = pstmt.executeUpdate();
			return affected>0;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				DBUtil.close(conn, pstmt);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
		
	}

	public boolean increaseKrwBalance(int userId, double amount) {
		String sql = "update assets set krw_balance = krw_balance + ? where user_id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, amount);
			pstmt.setInt(2, userId);
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


}
