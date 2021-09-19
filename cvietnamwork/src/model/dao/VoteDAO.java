package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import util.DBConnectionUtil;

public class VoteDAO {
	private PreparedStatement pst;
	private Connection conn;
	private ResultSet rs;
	private Statement st;

	public int numberOfLikes(int news_id) {
		int number = 0;
		conn = DBConnectionUtil.getConnection();
		String query = "SELECT COUNT(*) AS count FROM votes WHERE news_id = ?";
		try {
			pst = conn.prepareStatement(query);
			pst.setInt(1, news_id);
			rs = pst.executeQuery();
			if (rs.next()) {
				number = rs.getInt("count");
				return number;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			if (pst != null && st != null && rs != null) {
				try {
					pst.close();
					st.close();
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return number;
	}

	public void addItem(int user_id, int news_id) {
		conn = DBConnectionUtil.getConnection();
		String query = "INSERT INTO votes(user_id, news_id) VALUES(?,?) ";
		try {
			pst = conn.prepareStatement(query);
			pst.setInt(1, user_id);
			pst.setInt(2, news_id);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pst != null && st != null && rs != null) {
				try {
					pst.close();
					st.close();
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

	}

	public void dellItem(int user_id, int news_id) {
		conn = DBConnectionUtil.getConnection();
		String query = "DELETE FROM votes WHERE user_id = ? AND news_id = ? ";
		try {
			pst = conn.prepareStatement(query);
			pst.setInt(1, user_id);
			pst.setInt(2, news_id);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			if(pst != null && st != null && rs != null) {
				try {
					pst.close();
					st.close();
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public int numberOfItems(int user_id) {
		int number = 0;
		conn = DBConnectionUtil.getConnection();
		String query = "SELECT COUNT(*) AS count FROM votes WHERE user_id = ?";
		try {
			pst = conn.prepareStatement(query);
			pst.setInt(1, user_id);
			rs = pst.executeQuery();
			if(rs.next()) {
				number = rs.getInt("count");
				return number;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return number;
	}

	public int CheckVoted(int userlogin_id, int news_id) {
		int number = 0;
		conn = DBConnectionUtil.getConnection();
		String query = "SELECT COUNT(*) AS count FROM votes WHERE user_id = ? AND news_id = ?";
		try {
			pst = conn.prepareStatement(query);
			pst.setInt(1, userlogin_id);
			pst.setInt(2, news_id);
			rs = pst.executeQuery();
			if (rs.next()) {
				number = rs.getInt("count");
				return number;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			if (pst != null && st != null && rs != null) {
				try {
					pst.close();
					st.close();
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return number;

	}
}
