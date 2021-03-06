<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title> Form </title>
<template>
	<p class="error-message">error</p>
</template>
<style>
* {
	margin: 0;
	padding: 0;
	font-family: 'Roboto', sans-serif;
}

html {
	height: 100%;
}

body {
	width: 100%;
	height: 100%;
	display: flex;
  	justify-content: center;
  	align-items: center;
	background: #1b1e24;
}

input:valid {
	border: 1px solid #47bf26;
}

input:invalid {
	border: 1px solid red;
}

#degree:valid {
	border: 1px dashed #47bf26;
}

#birthday:valid {
	border: 1px dashed #47bf26;
}


/* This is the style of our error messages */
.error {
  width  : 100%;
  padding: 0;

  font-size: 80%;
  color: white;
  background-color: #900;
  border-radius: 0 0 5px 5px;

  box-sizing: border-box;
}

.error.active {
  padding: 0.3em;
}

#form-wrapper{
	display: flex;
	flex-direction: column;
	border: 1px red;
	background: #2d323b;
	border-radius: 8px;
    width: max(250px, 35%);
    height: 90%;
    max-height: max-content;
    /* offset-x | offset-y | blur-radius | spread-radius | color */
	box-shadow: 0px 4px 2px 1px rgba(0, 0, 0, 0.2);
	overflow: scroll;
	
}

#form-wrapper > form {
	overflow: scroll;
	display: flex;
	flex-direction: column;
}

#form-wrapper > h1{
	color: white;
	margin-top: 18px;
	margin-left: 45px;
	margin-bottom: 12px;
}

form > * {
	margin-left: 40px;
}

form:first-child{
	margin-top: 10px;
}

form:last-child{
	margin-bottom: 10px;
}

form > label{
	margin-bottom: 2px;
	font-size: 16px;
	color: white;
}

form > input{
	border: 1px gray;
	border-radius: 6px;
	width: 70%;
	height: 26px;
	background: #373b40;
	padding-left: 10px;
	font-size: 13px;
	color: white;
	margin-bottom: 6px
}

form > input:focus{
	outline: 1px white;
}

form > input::placeholder{
	font-size: 13px;
	color: #c2c2c2;
}

form > select{
	width: 200px;
	font-size: 13px;
	background: transparent;
	background-color: #373b40;
	border-radius: 6px;
	color: white;
	margin-bottom: 6px
}

form > select:checked{
	color: #c2c2c2;
}

button{
	margin-left: 0px;
	margin-top: 6px;
	align-self: center;
	padding: 8px;
	font-size: 15px;
	border: 1px blue;
	border-radius: 6px;
	color: white;
	background: #5aa854;
	border: 1px solid #376933;
}

button:hover {
	cursor: pointer;
}

.error-message{
	color: #f7665c;
}

</style>
</head>
<body>

<div id="form-wrapper">
	<h1>Welcome!</h1>
	<form novalidate action="RegisterController">
	  	<label for="name">Name:</label>
	  	<input type="text" id="name" name="name" placeholder="e.g: Jane Smith" value="${model.name}" required>
	  	<label for="username">Username (4 to 15 characters):</label>
	  	<input type="text" id="username" name="username" placeholder="@" value="${model.username}" required>
	  	<label for="email">Email:</label>
	  	<input type="email" id="email" name="email" placeholder="e.g: jane.smith@gmail.com" value="${model.email}" required>
	  	<label for="password">Password (Minimum 6 characters): </label>
	  	<input type="password" id="password" name="password" placeholder="password" required>
	  	<label for="passwordCheck"> Confirm Password: </label>
  		<input type="password" id="passwordCheck" name="passwordCheck" placeholder="password" required>  	
	  	<label for="gender">Gender:</label>
	  	<select name="gender" id="gender">
	    	<option value="NS">Prefer not to say</option>
	    	<option value="F">Female</option>
	    	<option value="M">Male</option>
	    	<option value="NB">Non-binary</option>
	  	</select>
	  	<label for="university">University:</label>
	  	<select name="university" id="university"> <!-- for now just from Catalunya! -->
	    	<option value="UB">Universitat de Barcelona</option>
	    	<option value="UPF">Universitat Pompeu Fabra</option>
	    	<option value="UAB">Universitat Aut??noma de Barcelona</option>
	    	<option value="UdL">Universitat de Lleida</option>
	    	<option value="UdG">Universitat de Girona</option>
	    	<option value="URV">Universitat Rovira i Virgili</option>
	    	<option value="UOC">Universitat Oberta de Catalunya</option>
	    	<option value="URL">Universitat Ramon Llull</option>
	    	<option value="Uvic">Universitat de Vic</option>
	    	<option value="UIC">Universitat Internacional de Catalunya</option>
	    	<option value="UAO-CEU">Universitat Abat Oliba</option>
	  	</select>
	  	<label for="degree">Degree:</label>
	  	<input type="text" id="degree" name="degree" placeholder="e.g: Computer Science" value="${model.degree}">
	  	<label for="country">Country:</label>
	  	<select name="country" id="country">
	        <option value="0" label="Select a country ... " selected="selected">Select a country ... </option>
	        <optgroup id="country-optgroup-Africa" label="Africa">
	            <option value="DZ" label="Algeria">Algeria</option>
	            <option value="AO" label="Angola">Angola</option>
	            <option value="BJ" label="Benin">Benin</option>
	            <option value="BW" label="Botswana">Botswana</option>
	            <option value="BF" label="Burkina Faso">Burkina Faso</option>
	            <option value="BI" label="Burundi">Burundi</option>
	            <option value="CM" label="Cameroon">Cameroon</option>
	            <option value="CV" label="Cape Verde">Cape Verde</option>
	            <option value="CF" label="Central African Republic">Central African Republic</option>
	            <option value="TD" label="Chad">Chad</option>
	            <option value="KM" label="Comoros">Comoros</option>
	            <option value="CG" label="Congo - Brazzaville">Congo - Brazzaville</option>
	            <option value="CD" label="Congo - Kinshasa">Congo - Kinshasa</option>
	            <option value="CI" label="C??te d???Ivoire">C??te d???Ivoire</option>
	            <option value="DJ" label="Djibouti">Djibouti</option>
	            <option value="EG" label="Egypt">Egypt</option>
	            <option value="GQ" label="Equatorial Guinea">Equatorial Guinea</option>
	            <option value="ER" label="Eritrea">Eritrea</option>
	            <option value="ET" label="Ethiopia">Ethiopia</option>
	            <option value="GA" label="Gabon">Gabon</option>
	            <option value="GM" label="Gambia">Gambia</option>
	            <option value="GH" label="Ghana">Ghana</option>
	            <option value="GN" label="Guinea">Guinea</option>
	            <option value="GW" label="Guinea-Bissau">Guinea-Bissau</option>
	            <option value="KE" label="Kenya">Kenya</option>
	            <option value="LS" label="Lesotho">Lesotho</option>
	            <option value="LR" label="Liberia">Liberia</option>
	            <option value="LY" label="Libya">Libya</option>
	            <option value="MG" label="Madagascar">Madagascar</option>
	            <option value="MW" label="Malawi">Malawi</option>
	            <option value="ML" label="Mali">Mali</option>
	            <option value="MR" label="Mauritania">Mauritania</option>
	            <option value="MU" label="Mauritius">Mauritius</option>
	            <option value="YT" label="Mayotte">Mayotte</option>
	            <option value="MA" label="Morocco">Morocco</option>
	            <option value="MZ" label="Mozambique">Mozambique</option>
	            <option value="NA" label="Namibia">Namibia</option>
	            <option value="NE" label="Niger">Niger</option>
	            <option value="NG" label="Nigeria">Nigeria</option>
	            <option value="RW" label="Rwanda">Rwanda</option>
	            <option value="RE" label="R??union">R??union</option>
	            <option value="SH" label="Saint Helena">Saint Helena</option>
	            <option value="SN" label="Senegal">Senegal</option>
	            <option value="SC" label="Seychelles">Seychelles</option>
	            <option value="SL" label="Sierra Leone">Sierra Leone</option>
	            <option value="SO" label="Somalia">Somalia</option>
	            <option value="ZA" label="South Africa">South Africa</option>
	            <option value="SD" label="Sudan">Sudan</option>
	            <option value="SZ" label="Swaziland">Swaziland</option>
	            <option value="ST" label="S??o Tom?? and Pr??ncipe">S??o Tom?? and Pr??ncipe</option>
	            <option value="TZ" label="Tanzania">Tanzania</option>
	            <option value="TG" label="Togo">Togo</option>
	            <option value="TN" label="Tunisia">Tunisia</option>
	            <option value="UG" label="Uganda">Uganda</option>
	            <option value="EH" label="Western Sahara">Western Sahara</option>
	            <option value="ZM" label="Zambia">Zambia</option>
	            <option value="ZW" label="Zimbabwe">Zimbabwe</option>
	        </optgroup>
	        <optgroup id="country-optgroup-Americas" label="Americas">
	            <option value="AI" label="Anguilla">Anguilla</option>
	            <option value="AG" label="Antigua and Barbuda">Antigua and Barbuda</option>
	            <option value="AR" label="Argentina">Argentina</option>
	            <option value="AW" label="Aruba">Aruba</option>
	            <option value="BS" label="Bahamas">Bahamas</option>
	            <option value="BB" label="Barbados">Barbados</option>
	            <option value="BZ" label="Belize">Belize</option>
	            <option value="BM" label="Bermuda">Bermuda</option>
	            <option value="BO" label="Bolivia">Bolivia</option>
	            <option value="BR" label="Brazil">Brazil</option>
	            <option value="VG" label="British Virgin Islands">British Virgin Islands</option>
	            <option value="CA" label="Canada">Canada</option>
	            <option value="KY" label="Cayman Islands">Cayman Islands</option>
	            <option value="CL" label="Chile">Chile</option>
	            <option value="CO" label="Colombia">Colombia</option>
	            <option value="CR" label="Costa Rica">Costa Rica</option>
	            <option value="CU" label="Cuba">Cuba</option>
	            <option value="DM" label="Dominica">Dominica</option>
	            <option value="DO" label="Dominican Republic">Dominican Republic</option>
	            <option value="EC" label="Ecuador">Ecuador</option>
	            <option value="SV" label="El Salvador">El Salvador</option>
	            <option value="FK" label="Falkland Islands">Falkland Islands</option>
	            <option value="GF" label="French Guiana">French Guiana</option>
	            <option value="GL" label="Greenland">Greenland</option>
	            <option value="GD" label="Grenada">Grenada</option>
	            <option value="GP" label="Guadeloupe">Guadeloupe</option>
	            <option value="GT" label="Guatemala">Guatemala</option>
	            <option value="GY" label="Guyana">Guyana</option>
	            <option value="HT" label="Haiti">Haiti</option>
	            <option value="HN" label="Honduras">Honduras</option>
	            <option value="JM" label="Jamaica">Jamaica</option>
	            <option value="MQ" label="Martinique">Martinique</option>
	            <option value="MX" label="Mexico">Mexico</option>
	            <option value="MS" label="Montserrat">Montserrat</option>
	            <option value="AN" label="Netherlands Antilles">Netherlands Antilles</option>
	            <option value="NI" label="Nicaragua">Nicaragua</option>
	            <option value="PA" label="Panama">Panama</option>
	            <option value="PY" label="Paraguay">Paraguay</option>
	            <option value="PE" label="Peru">Peru</option>
	            <option value="PR" label="Puerto Rico">Puerto Rico</option>
	            <option value="BL" label="Saint Barth??lemy">Saint Barth??lemy</option>
	            <option value="KN" label="Saint Kitts and Nevis">Saint Kitts and Nevis</option>
	            <option value="LC" label="Saint Lucia">Saint Lucia</option>
	            <option value="MF" label="Saint Martin">Saint Martin</option>
	            <option value="PM" label="Saint Pierre and Miquelon">Saint Pierre and Miquelon</option>
	            <option value="VC" label="Saint Vincent and the Grenadines">Saint Vincent and the Grenadines</option>
	            <option value="SR" label="Suriname">Suriname</option>
	            <option value="TT" label="Trinidad and Tobago">Trinidad and Tobago</option>
	            <option value="TC" label="Turks and Caicos Islands">Turks and Caicos Islands</option>
	            <option value="VI" label="U.S. Virgin Islands">U.S. Virgin Islands</option>
	            <option value="US" label="United States">United States</option>
	            <option value="UY" label="Uruguay">Uruguay</option>
	            <option value="VE" label="Venezuela">Venezuela</option>
	        </optgroup>
	        <optgroup id="country-optgroup-Asia" label="Asia">
	            <option value="AF" label="Afghanistan">Afghanistan</option>
	            <option value="AM" label="Armenia">Armenia</option>
	            <option value="AZ" label="Azerbaijan">Azerbaijan</option>
	            <option value="BH" label="Bahrain">Bahrain</option>
	            <option value="BD" label="Bangladesh">Bangladesh</option>
	            <option value="BT" label="Bhutan">Bhutan</option>
	            <option value="BN" label="Brunei">Brunei</option>
	            <option value="KH" label="Cambodia">Cambodia</option>
	            <option value="CN" label="China">China</option>
	            <option value="GE" label="Georgia">Georgia</option>
	            <option value="HK" label="Hong Kong SAR China">Hong Kong SAR China</option>
	            <option value="IN" label="India">India</option>
	            <option value="ID" label="Indonesia">Indonesia</option>
	            <option value="IR" label="Iran">Iran</option>
	            <option value="IQ" label="Iraq">Iraq</option>
	            <option value="IL" label="Israel">Israel</option>
	            <option value="JP" label="Japan">Japan</option>
	            <option value="JO" label="Jordan">Jordan</option>
	            <option value="KZ" label="Kazakhstan">Kazakhstan</option>
	            <option value="KW" label="Kuwait">Kuwait</option>
	            <option value="KG" label="Kyrgyzstan">Kyrgyzstan</option>
	            <option value="LA" label="Laos">Laos</option>
	            <option value="LB" label="Lebanon">Lebanon</option>
	            <option value="MO" label="Macau SAR China">Macau SAR China</option>
	            <option value="MY" label="Malaysia">Malaysia</option>
	            <option value="MV" label="Maldives">Maldives</option>
	            <option value="MN" label="Mongolia">Mongolia</option>
	            <option value="MM" label="Myanmar [Burma]">Myanmar [Burma]</option>
	            <option value="NP" label="Nepal">Nepal</option>
	            <option value="NT" label="Neutral Zone">Neutral Zone</option>
	            <option value="KP" label="North Korea">North Korea</option>
	            <option value="OM" label="Oman">Oman</option>
	            <option value="PK" label="Pakistan">Pakistan</option>
	            <option value="PS" label="Palestinian Territories">Palestinian Territories</option>
	            <option value="YD" label="People's Democratic Republic of Yemen">People's Democratic Republic of Yemen</option>
	            <option value="PH" label="Philippines">Philippines</option>
	            <option value="QA" label="Qatar">Qatar</option>
	            <option value="SA" label="Saudi Arabia">Saudi Arabia</option>
	            <option value="SG" label="Singapore">Singapore</option>
	            <option value="KR" label="South Korea">South Korea</option>
	            <option value="LK" label="Sri Lanka">Sri Lanka</option>
	            <option value="SY" label="Syria">Syria</option>
	            <option value="TW" label="Taiwan">Taiwan</option>
	            <option value="TJ" label="Tajikistan">Tajikistan</option>
	            <option value="TH" label="Thailand">Thailand</option>
	            <option value="TL" label="Timor-Leste">Timor-Leste</option>
	            <option value="TR" label="Turkey">Turkey</option>
	            <option value="TM" label="Turkmenistan">Turkmenistan</option>
	            <option value="AE" label="United Arab Emirates">United Arab Emirates</option>
	            <option value="UZ" label="Uzbekistan">Uzbekistan</option>
	            <option value="VN" label="Vietnam">Vietnam</option>
	            <option value="YE" label="Yemen">Yemen</option>
	        </optgroup>
	        <optgroup id="country-optgroup-Europe" label="Europe">
	            <option value="AL" label="Albania">Albania</option>
	            <option value="AD" label="Andorra">Andorra</option>
	            <option value="AT" label="Austria">Austria</option>
	            <option value="BY" label="Belarus">Belarus</option>
	            <option value="BE" label="Belgium">Belgium</option>
	            <option value="BA" label="Bosnia and Herzegovina">Bosnia and Herzegovina</option>
	            <option value="BG" label="Bulgaria">Bulgaria</option>
	            <option value="HR" label="Croatia">Croatia</option>
	            <option value="CY" label="Cyprus">Cyprus</option>
	            <option value="CZ" label="Czech Republic">Czech Republic</option>
	            <option value="DK" label="Denmark">Denmark</option>
	            <option value="DD" label="East Germany">East Germany</option>
	            <option value="EE" label="Estonia">Estonia</option>
	            <option value="FO" label="Faroe Islands">Faroe Islands</option>
	            <option value="FI" label="Finland">Finland</option>
	            <option value="FR" label="France">France</option>
	            <option value="DE" label="Germany">Germany</option>
	            <option value="GI" label="Gibraltar">Gibraltar</option>
	            <option value="GR" label="Greece">Greece</option>
	            <option value="GG" label="Guernsey">Guernsey</option>
	            <option value="HU" label="Hungary">Hungary</option>
	            <option value="IS" label="Iceland">Iceland</option>
	            <option value="IE" label="Ireland">Ireland</option>
	            <option value="IM" label="Isle of Man">Isle of Man</option>
	            <option value="IT" label="Italy">Italy</option>
	            <option value="JE" label="Jersey">Jersey</option>
	            <option value="LV" label="Latvia">Latvia</option>
	            <option value="LI" label="Liechtenstein">Liechtenstein</option>
	            <option value="LT" label="Lithuania">Lithuania</option>
	            <option value="LU" label="Luxembourg">Luxembourg</option>
	            <option value="MK" label="Macedonia">Macedonia</option>
	            <option value="MT" label="Malta">Malta</option>
	            <option value="FX" label="Metropolitan France">Metropolitan France</option>
	            <option value="MD" label="Moldova">Moldova</option>
	            <option value="MC" label="Monaco">Monaco</option>
	            <option value="ME" label="Montenegro">Montenegro</option>
	            <option value="NL" label="Netherlands">Netherlands</option>
	            <option value="NO" label="Norway">Norway</option>
	            <option value="PL" label="Poland">Poland</option>
	            <option value="PT" label="Portugal">Portugal</option>
	            <option value="RO" label="Romania">Romania</option>
	            <option value="RU" label="Russia">Russia</option>
	            <option value="SM" label="San Marino">San Marino</option>
	            <option value="RS" label="Serbia">Serbia</option>
	            <option value="CS" label="Serbia and Montenegro">Serbia and Montenegro</option>
	            <option value="SK" label="Slovakia">Slovakia</option>
	            <option value="SI" label="Slovenia">Slovenia</option>
	            <option value="ES" label="Spain">Spain</option>
	            <option value="SJ" label="Svalbard and Jan Mayen">Svalbard and Jan Mayen</option>
	            <option value="SE" label="Sweden">Sweden</option>
	            <option value="CH" label="Switzerland">Switzerland</option>
	            <option value="UA" label="Ukraine">Ukraine</option>
	            <option value="SU" label="Union of Soviet Socialist Republics">Union of Soviet Socialist Republics</option>
	            <option value="GB" label="United Kingdom">United Kingdom</option>
	            <option value="VA" label="Vatican City">Vatican City</option>
	            <option value="AX" label="??land Islands">??land Islands</option>
	        </optgroup>
	        <optgroup id="country-optgroup-Oceania" label="Oceania">
	            <option value="AS" label="American Samoa">American Samoa</option>
	            <option value="AQ" label="Antarctica">Antarctica</option>
	            <option value="AU" label="Australia">Australia</option>
	            <option value="BV" label="Bouvet Island">Bouvet Island</option>
	            <option value="IO" label="British Indian Ocean Territory">British Indian Ocean Territory</option>
	            <option value="CX" label="Christmas Island">Christmas Island</option>
	            <option value="CC" label="Cocos [Keeling] Islands">Cocos [Keeling] Islands</option>
	            <option value="CK" label="Cook Islands">Cook Islands</option>
	            <option value="FJ" label="Fiji">Fiji</option>
	            <option value="PF" label="French Polynesia">French Polynesia</option>
	            <option value="TF" label="French Southern Territories">French Southern Territories</option>
	            <option value="GU" label="Guam">Guam</option>
	            <option value="HM" label="Heard Island and McDonald Islands">Heard Island and McDonald Islands</option>
	            <option value="KI" label="Kiribati">Kiribati</option>
	            <option value="MH" label="Marshall Islands">Marshall Islands</option>
	            <option value="FM" label="Micronesia">Micronesia</option>
	            <option value="NR" label="Nauru">Nauru</option>
	            <option value="NC" label="New Caledonia">New Caledonia</option>
	            <option value="NZ" label="New Zealand">New Zealand</option>
	            <option value="NU" label="Niue">Niue</option>
	            <option value="NF" label="Norfolk Island">Norfolk Island</option>
	            <option value="MP" label="Northern Mariana Islands">Northern Mariana Islands</option>
	            <option value="PW" label="Palau">Palau</option>
	            <option value="PG" label="Papua New Guinea">Papua New Guinea</option>
	            <option value="PN" label="Pitcairn Islands">Pitcairn Islands</option>
	            <option value="WS" label="Samoa">Samoa</option>
	            <option value="SB" label="Solomon Islands">Solomon Islands</option>
	            <option value="GS" label="South Georgia and the South Sandwich Islands">South Georgia and the South Sandwich Islands</option>
	            <option value="TK" label="Tokelau">Tokelau</option>
	            <option value="TO" label="Tonga">Tonga</option>
	            <option value="TV" label="Tuvalu">Tuvalu</option>
	            <option value="UM" label="U.S. Minor Outlying Islands">U.S. Minor Outlying Islands</option>
	            <option value="VU" label="Vanuatu">Vanuatu</option>
	            <option value="WF" label="Wallis and Futuna">Wallis and Futuna</option>
	        </optgroup>
	    </select>
	    <label for="birthday">Birthday:</label>
	  	<input type="date" id="birthday" name="birthday" max="2008-01-01" value="${model.birthday}">
	  	<label for="position">Position:</label>
	  	<select name="position" id="position">
	    	<option value="S">Student</option>
	    	<option value="T">Teacher</option>
	  	</select>	  	
	  	
	  	<button>Submit</button>
	</form>
</div>
<script>

//There are many ways to pick a DOM node; here we get the form itself and the email
//input box, as well as the span element into which we will place the error message.
const form  = document.getElementsByTagName('form')[0];
const email = document.getElementById('mail');

form.addEventListener('submit', function (event) {
	if(!checkInputs()){
		event.preventDefault();
	}
});

function checkInputs(){
	const inputs = form.getElementsByTagName("input");
	for(const input of inputs){
		if(!isInputValid(input)){
			return false;
		}
	}
	if(!passwordsMatch()){
		showError("Passwords don't match.");
		return false;
	}
	return true;
}

function isInputValid(input){
	let value;
	try{
		value = input.value.trim();
		input.value = value;
	} catch(e){
		console.log(e);
	}
	switch(input.id){
		case "name":
			if(value === ""){
				showError("Please enter a name"); return false;
			}
			break;
		case "username":
			if(value === ""){
				showError("Please enter a username"); return false;
			}
			else if(value.length < 4){
				showError("Username length should be longer than 4 characters"); return false;
			}
			else if(value.length > 15){
				showError("Username length should be shorter than 15 characters"); return false;
			}
			// TODO if user exists
			else if(!validateUsername(value)){
				showError("Username is not valid"); return false;
			}
			break;
		case "email":
			if(!validateEmail(value)){
				showError("Email is not valid"); return false;
			}
			break;
		case "password":
			if(value === ""){
				showError("Please enter a password"); return false;
			}
			else if(value.length < 6){
				showError("Password length should be longer than 6 characters"); return false;
			}
			else if(!validatePassword(value)){
				showError("Password must contain only alphanumeric characters"); return false;
			}
			break;
		case "password-check":
			if(!validatePassword(value)){
				showError("Password must contain only alphanumeric characters"); return false;
			}
			break;
		case "degree":
			if(value === ""){
				input.value = null;
			}
			else if(!validateDegree(value)){
				showError("Degree must contain only text characters"); return false;
			}
			break;
		case "birthday":
			if(value === ""){
				input.value = null;
			}
			else if(!validateDate(value)){
				showError("Date is not valid"); return false;
			}
			break;
	}
	return true;
}

function showError(errorMessage) {
	const template = document.getElementsByTagName("template")[0];
	let error = template.content.querySelector("p");
	if(error !== null){
		error.innerText = errorMessage;
		form.getElementsByTagName("button")[0].before(error);
	}
	else{
		error = document.getElementsByClassName("error-message")[0];
		error.innerText = errorMessage;
	}
}

function validateUsername(username){
	return /^[a-zA-Z0-9]+$/.test(username);
}

function validateEmail(email){
	return /[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email);
}

function validatePassword(password){
	return /^[a-zA-Z0-9]+$/.test(password);
}

function validateDegree(degree){
	return /^[a-zA-Z ]+$/.test(degree);
}
	
function validateDate(date){
	return date === "" || /^[0-9-]+$/.test(date);
}

function passwordsMatch(){
	let pwd1 = document.getElementById("password").value;
	let pwd2 = document.getElementById("passwordCheck").value;
	return pwd1 === pwd2;
}
	

</script>
<c:if test = "${model.error[0]}">
	<script> showError("Please enter a name.") </script>
</c:if>

<c:if test = "${model.error[1]}">
	<script> showError("Please enter a username.") </script>
</c:if>

<c:if test = "${model.error[2]}">
	<script> showError("Username length invalid.") </script>
</c:if>

<c:if test = "${model.error[3]}">
	<script> showError("Username is not valid.") </script>
</c:if>

<c:if test = "${model.error[4]}">
	<script> showError("Username is already in use.") </script>
</c:if>

<c:if test = "${model.error[5]}">
	<script> showError("Email is not valid.") </script>
</c:if>

<c:if test = "${model.error[6]}">
	<script> showError("Password length should be longer than 6 characters") </script>
</c:if>

<c:if test = "${model.error[7]}">
	<script>showError("Password must contain only alphanumeric characters") </script>
</c:if>

<c:if test = "${model.error[8]}">
	<script>showError("Degree must contain only text characters")</script>
</c:if>

<c:if test = "${model.error[9]}">
	<script>showError("Email is already in use.")</script>
</c:if>

</body>
</html>