package services;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.University;
import utils.DB;

public class UniversityService {
	
	private DB db = null ;
	
	public UniversityService() {
		try {
			db = new DB();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void finalize() {
		try {
			db.disconnectBD();
		} catch (Throwable e) {
			e.printStackTrace();
		}
	}
	
	public List<University> getUniversities() {
		String query = "SELECT * FROM university";
		PreparedStatement statement = null;
		ResultSet rs = null;
		List<University> universities = new ArrayList<>();
		try {
			statement = db.prepareStatement(query);
			rs = statement.executeQuery();
			while (rs.next()) {
				University university = new University();
				university.setName(rs.getString("name"));
				university.setCode(rs.getString("code"));
				universities.add(university);
			}
			rs.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return universities;
	}
	
	
	

}