package com.coinlab.dto;

import java.sql.Timestamp;

public class User {
	private int userId;
	private String username;
	private String password;
	private String email;
	private String nickname;
	private String profileImage;
	private String role;
	private Timestamp createdAt;
	private Timestamp lastLogin;

	public User() {
	}

	public User(String username, String password, String email, String nickname, String profileImage) {
		this.username = username;
		this.password = password;
		this.email = email;
		this.nickname = nickname;
		this.profileImage = profileImage;
	}

	public User(int userId, String username, String password, String email, String nickname, String profileImage,
			String role, Timestamp createdAt, Timestamp lastLogin) {
		this.userId = userId;
		this.username = username;
		this.password = password;
		this.email = email;
		this.nickname = nickname;
		this.profileImage = profileImage;
		this.role = role;
		this.createdAt = createdAt;
		this.lastLogin = lastLogin;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(Timestamp lastLogin) {
		this.lastLogin = lastLogin;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", username=" + username + ", password=" + password + ", email=" + email
				+ ", nickname=" + nickname + ", profileImage=" + profileImage + ", role=" + role + ", createdAt="
				+ createdAt + ", lastLogin=" + lastLogin + "]";
	}

}
