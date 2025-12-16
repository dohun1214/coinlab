package com.coinlab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.coinlab.dto.Ranking;
import com.coinlab.dto.User;
import com.coinlab.util.DBUtil;

public class UserDAO {

	// username으로 조회
	public User getUserByUsername(String username) throws SQLException {
		String sql = "select * from users where username = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setNickname(rs.getString("nickname"));
				user.setRole(rs.getString("role"));
				user.setCreatedAt(rs.getTimestamp("created_at"));
				user.setLastLogin(rs.getTimestamp("last_login"));

				return user;
			}

		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			DBUtil.close(conn, pstmt, rs);
		}
		return null;

	}

	// 전체 사용자 조회
	public ArrayList<User> getAllUsers() {
		String sql = "select * from users";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<User> userList = new ArrayList<User>();

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				userList.add(new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"),
						rs.getString("email"), rs.getString("nickname"),
						rs.getString("role"), rs.getTimestamp("created_at"),
						rs.getTimestamp("last_login")));
			}
			return userList;
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

	// 전체 사용자 수
	public int getUserCount() {
		String sql = "select count(*) from users";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
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
		return 0;

	}

	// username 중복 체크
	public boolean checkIdDuplicate(String username) {
		String sql = "select * from users where username = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return true;
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
		return false;
	}

	// email 중복체크
	public boolean checkEmailDuplicate(String email) {
		String sql = "select * from users where email = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return true;
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
		return false;
	}


	// username 으로 삭제

	public void deleteUser(String username) {
		String sql = "delete from users where username = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
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

	// 마지막 로그인 업데이트
	public void updateLastLogin(String username) {
		String sql = "update users set last_login = ? where username = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
			pstmt.setString(2, username);
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

	// nickname 업데이트
	public void updateNickname(String username, String nickname) {
		String sql = "update users set nickname = ? where username = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			pstmt.setString(2, username);
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

	// email 업데이트
	public void updateEmail(String username, String email) {
		String sql = "update users set email = ? where username = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, username);
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

	// password 변경
	public void updatePassword(String username, String password) {
		String sql = "update users set password = ? where username = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, username);
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

	// role 변경(USER <-> ADMIN)
	public void updateUserRole(String username, String role) {
		String sql = "update users set role = ? where username = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, role);
			pstmt.setString(2, username);
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

	// 회원 가입
	public int insertUser(User user) {
		String sql = "insert into users(username,password,email,nickname,role,last_login) values(?,?,?,?,?,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBUtil.getConnection();

			pstmt=conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getNickname());
			pstmt.setString(5, "USER");
			pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));

			pstmt.executeUpdate();

			rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				return rs.getInt(1);
			}
			return 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				DBUtil.close(conn, pstmt, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	// 로그인
	public User login(String username, String password) {
		String sql = "select * from users where username = ? and password = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				User user = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getString(6), rs.getTimestamp(7), rs.getTimestamp(8));
				return user;
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

	// 수익률 기준 랭킹 조회
	public ArrayList<Ranking> getRankingByProfitRate(int limit) {
		String sql = "SELECT u.user_id, u.username, u.nickname, a.profit_rate, a.realized_profit, a.krw_balance "
				+ "FROM users u "
				+ "JOIN assets a ON u.user_id = a.user_id "
				+ "ORDER BY a.profit_rate DESC "
				+ "LIMIT ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Ranking> rankingList = new ArrayList<>();

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, limit);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Ranking ranking = new Ranking();
				ranking.setUserId(rs.getInt("user_id"));
				ranking.setUsername(rs.getString("username"));
				ranking.setNickname(rs.getString("nickname"));
				ranking.setProfitRate(rs.getDouble("profit_rate"));
				ranking.setRealizedProfit(rs.getDouble("realized_profit"));
				ranking.setKrwBalance(rs.getDouble("krw_balance"));
				rankingList.add(ranking);
			}
			return rankingList;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				DBUtil.close(conn, pstmt, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rankingList;
	}

}
