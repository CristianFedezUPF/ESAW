package models;

public class Country implements java.io.Serializable {

	 private static final long serialVersionUID = 1L;

	 private String continent;
	 private String code;
	 private String name;

	 public Country() {
	 
	 }

	 public String getContinent() {
		 return continent;
	 }

	 public void setContinent(String continent) {
		 this.continent = continent;
	 }

	 public String getCode() {
		 return code;
	 }

	 public void setCode(String code) {
		 this.code = code;
	 }

	 public String getName() {
		 return name;
	 }

	 public void setName(String name) {
		 this.name = name;
	 }

}