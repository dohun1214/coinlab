package com.coinlab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.coinlab.dto.Board;
import com.coinlab.dto.Comments;
import com.coinlab.util.DBUtil;

public class BoardDAO {

	public List<Board> getPosts(Integer viewerUserId) {
		List<Board> posts = new ArrayList<>();
		String sql = "SELECT b.post_id, b.user_id, b.title, b.content, b.view_count, b.created_at, b.updated_at, "
				+ "u.nickname, u.profile_image, "
				+ "(SELECT COUNT(*) FROM comments c WHERE c.post_id = b.post_id) AS comment_count, "
				+ "(SELECT COUNT(*) FROM board_likes bl WHERE bl.post_id = b.post_id) AS like_count, "
				+ "(SELECT COUNT(*) FROM board_likes bl2 WHERE bl2.post_id = b.post_id AND bl2.user_id = ?) AS liked_by_me "
				+ "FROM board b "
				+ "JOIN users u ON u.user_id = b.user_id "
				+ "ORDER BY b.created_at DESC";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, viewerUserId == null ? 0 : viewerUserId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board post = new Board();
				post.setPostId(rs.getInt("post_id"));
				post.setUserId(rs.getInt("user_id"));
				post.setTitle(rs.getString("title"));
				post.setContent(rs.getString("content"));
				post.setViewCount(rs.getInt("view_count"));
				post.setCreatedAt(rs.getTimestamp("created_at"));
				post.setUpdatedAt(rs.getTimestamp("updated_at"));
				post.setNickname(rs.getString("nickname"));
				post.setProfileImage(rs.getString("profile_image"));
				post.setCommentCount(rs.getInt("comment_count"));
				post.setLikeCount(rs.getInt("like_count"));
				post.setLikedByMe(rs.getInt("liked_by_me") > 0);

				posts.add(post);
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
		return posts;
	}

	public List<Comments> getComments(int postId) {
		List<Comments> comments = new ArrayList<>();
		String sql = "SELECT c.comment_id, c.post_id, c.user_id, c.content, c.created_at, u.nickname, u.profile_image "
				+ "FROM comments c JOIN users u ON u.user_id = c.user_id "
				+ "WHERE c.post_id = ? ORDER BY c.created_at ASC";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Comments comment = new Comments();
				comment.setCommentId(rs.getInt("comment_id"));
				comment.setPostId(rs.getInt("post_id"));
				comment.setUserId(rs.getInt("user_id"));
				comment.setContent(rs.getString("content"));
				comment.setCreatedAt(rs.getTimestamp("created_at"));
				comment.setNickname(rs.getString("nickname"));
				comment.setProfileImage(rs.getString("profile_image"));
				comments.add(comment);
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
		return comments;
	}

	public void createPost(int userId, String title, String content) throws SQLException {
		String sql = "INSERT INTO board (user_id, title, content, created_at, updated_at) VALUES (?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			Timestamp now = new Timestamp(System.currentTimeMillis());
			pstmt.setTimestamp(4, now);
			pstmt.setTimestamp(5, now);
			pstmt.executeUpdate();
		} finally {
			DBUtil.close(conn, pstmt);
		}
	}

	public void createComment(int postId, int userId, String content) throws SQLException {
		String sql = "INSERT INTO comments (post_id, user_id, content, created_at) VALUES (?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postId);
			pstmt.setInt(2, userId);
			pstmt.setString(3, content);
			pstmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
			pstmt.executeUpdate();
		} finally {
			DBUtil.close(conn, pstmt);
		}
	}

	public boolean toggleLike(int postId, int userId) throws SQLException {
		String selectSql = "SELECT like_id FROM board_likes WHERE post_id = ? AND user_id = ?";
		String insertSql = "INSERT INTO board_likes (post_id, user_id, created_at) VALUES (?, ?, ?)";
		String deleteSql = "DELETE FROM board_likes WHERE post_id = ? AND user_id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(selectSql);
			pstmt.setInt(1, postId);
			pstmt.setInt(2, userId);
			rs = pstmt.executeQuery();

			boolean exists = rs.next();
			DBUtil.close(null, pstmt, rs);

			if (exists) {
				pstmt = conn.prepareStatement(deleteSql);
				pstmt.setInt(1, postId);
				pstmt.setInt(2, userId);
				pstmt.executeUpdate();
				return false;
			} else {
				pstmt = conn.prepareStatement(insertSql);
				pstmt.setInt(1, postId);
				pstmt.setInt(2, userId);
				pstmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
				pstmt.executeUpdate();
				return true;
			}
		} finally {
			DBUtil.close(conn, pstmt, rs);
		}
	}

	public boolean deletePost(int postId, int userId, boolean isAdmin) throws SQLException {
		String sql = isAdmin ? "DELETE FROM board WHERE post_id = ?" : "DELETE FROM board WHERE post_id = ? AND user_id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postId);
			if (!isAdmin) {
				pstmt.setInt(2, userId);
			}

			int affected = pstmt.executeUpdate();
			return affected > 0;
		} finally {
			DBUtil.close(conn, pstmt);
		}
	}

	public boolean deleteComment(int commentId, int userId, boolean isAdmin) throws SQLException {
		String sql = isAdmin ? "DELETE FROM comments WHERE comment_id = ?" : "DELETE FROM comments WHERE comment_id = ? AND user_id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentId);
			if (!isAdmin) {
				pstmt.setInt(2, userId);
			}

			int affected = pstmt.executeUpdate();
			return affected > 0;
		} finally {
			DBUtil.close(conn, pstmt);
		}
	}
}
