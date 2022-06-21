package services;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.commons.lang3.tuple.Pair;

import models.Country;
import models.User;
import utils.DB;

public class CountryService {
	
	private DB db = null ;
	
	public CountryService() {
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
	
	
	public List<Country> getCountries() {
		String query = "SELECT * FROM country";
		PreparedStatement statement = null;
		ResultSet rs = null;
		List<Country> countries = new ArrayList<>();
		try {
			statement = db.prepareStatement(query);
			rs = statement.executeQuery();
			while (rs.next()) {
				Country country = new Country();
				country.setName(rs.getString("name"));
				country.setContinent(rs.getString("continent"));
				country.setCode(rs.getString("code"));
				countries.add(country);
			}
			rs.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return countries;
	}
	
	public Map<String, List<Country>> getCountriesByContinent(){
		List<Country> countries = getCountries(); 
		return countries.stream().collect(Collectors.groupingBy(Country::getContinent));
	}
	
	
	

}