package com.coinlab.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {
	private static String URL;
	private static String USER;
	private static String PASSWORD;

	static {
		try {
			Properties props = new Properties();
			InputStream input = DBUtil.class.getClassLoader().getResourceAsStream("db.properties");
			if (input == null) {
				throw new RuntimeException("db.properties 파일을 찾을 수 없습니다. src/main/resources 폴더를 확인하세요.");
			}
			props.load(input);

			URL = props.getProperty("db.url");
			USER = props.getProperty("db.username");
			PASSWORD = props.getProperty("db.password");

			Class.forName(props.getProperty("db.driver"));
			input.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("DB 설정 로드 실패", e);
		}
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USER, PASSWORD);
	}

	public static void close(Connection conn, PreparedStatement pstmt) throws SQLException {
		conn.close();
		pstmt.close();
	}

	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) throws SQLException {
		conn.close();
		pstmt.close();
		rs.close();
	}

}
