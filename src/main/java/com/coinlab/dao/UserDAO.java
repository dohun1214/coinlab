package com.coinlab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.coinlab.dto.User;
import com.coinlab.util.DBUtil;

public class UserDAO {

	// 유저명으로 찾기
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
				user.setProfileImage(rs.getString("profile_image"));
				user.setRole(rs.getString("role"));
				user.setInitialBalance(rs.getDouble("initial_balance"));
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
						rs.getString("email"), rs.getString("nickname"), rs.getString("profile_image"),
						rs.getString("role"), rs.getDouble("initial_balance"), rs.getTimestamp("created_at"),
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

	// 전체 사용자수
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

	// username 중복체크
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

	// username 으로 유저 삭제
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

	// 마지막 로그인 시간 업데이트
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

	// nickname 업데이트 (username, nickname 받아서)
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

	// 회원 가입
	public int insertUser(User user) {
		String sql = "insert into users(username,password,email,nickname,profile_image,role,last_login) values(?,?,?,?,?,?,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getNickname());
			pstmt.setString(5, user.getProfileImage());
			pstmt.setString(6, "USER");
			pstmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));

			return pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				DBUtil.close(conn, pstmt);
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
						rs.getString(6), rs.getString(7), rs.getDouble(8), rs.getTimestamp(9), rs.getTimestamp(10));
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

}
