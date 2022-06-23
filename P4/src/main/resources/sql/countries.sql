USE unitter; 
DROP TABLE IF EXISTS country;

CREATE TABLE country(
	continent VARCHAR(12),
    code VARCHAR(3) ,
    name VARCHAR(60), 
    PRIMARY KEY(code)
);

INSERT INTO country(continent, code, name) VALUES ('Africa',            "DZ" , 'Algeria');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "AO" , 'Angola');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "BJ" , 'Benin');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "BW" , 'Botswana');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "BF" , 'Burkina Faso');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "BI" , 'Burundi');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CM" , 'Cameroon');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CV" , 'Cape Verde');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CF" , 'Central African Republic');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "TD" , 'Chad');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "KM" , 'Comoros');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CG" , 'Congo - Brazzaville');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CD" , 'Congo - Kinshasa');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "CI" , 'Côte d’Ivoire');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "DJ" , 'Djibouti');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "EG" , 'Egypt');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GQ" , 'Equatorial Guinea');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ER" , 'Eritrea');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ET" , 'Ethiopia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GA" , 'Gabon');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GM" , 'Gambia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GH" , 'Ghana');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GN" , 'Guinea');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "GW" , 'Guinea-Bissau');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "KE" , 'Kenya');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "LS" , 'Lesotho');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "LR" , 'Liberia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "LY" , 'Libya');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MG" , 'Madagascar');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MW" , 'Malawi');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ML" , 'Mali');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MR" , 'Mauritania');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MU" , 'Mauritius');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "YT" , 'Mayotte');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MA" , 'Morocco');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "MZ" , 'Mozambique');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "NA" , 'Namibia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "NE" , 'Niger');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "NG" , 'Nigeria');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "RW" , 'Rwanda');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "RE" , 'Réunion');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SH" , 'Saint Helena');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SN" , 'Senegal');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SC" , 'Seychelles');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SL" , 'Sierra Leone');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SO" , 'Somalia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ZA" , 'South Africa');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SD" , 'Sudan');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "SZ" , 'Swaziland');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ST" , 'São Tomé and Príncipe');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "TZ" , 'Tanzania');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "TG" , 'Togo');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "TN" , 'Tunisia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "UG" , 'Uganda');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "EH" , 'Western Sahara');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ZM" , 'Zambia');
INSERT INTO country(continent, code, name) VALUES ('Africa',            "ZW" , 'Zimbabwe');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "AI" , 'Anguilla');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "AG" , 'Antigua and Barbuda');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "AR" , 'Argentina');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "AW" , 'Aruba');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BS" , 'Bahamas');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BB" , 'Barbados');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BZ" , 'Belize');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BM" , 'Bermuda');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BO" , 'Bolivia');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BR" , 'Brazil');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "VG" , 'British Virgin Islands');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "CA" , 'Canada');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "KY" , 'Cayman Islands');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "CL" , 'Chile');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "CO" , 'Colombia');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "CR" , 'Costa Rica');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "CU" , 'Cuba');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "DM" , 'Dominica');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "DO" , 'Dominican Republic');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "EC" , 'Ecuador');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "SV" , 'El Salvador');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "FK" , 'Falkland Islands');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GF" , 'French Guiana');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GL" , 'Greenland');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GD" , 'Grenada');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GP" , 'Guadeloupe');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GT" , 'Guatemala');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "GY" , 'Guyana');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "HT" , 'Haiti');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "HN" , 'Honduras');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "JM" , 'Jamaica');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "MQ" , 'Martinique');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "MX" , 'Mexico');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "MS" , 'Montserrat');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "AN" , 'Netherlands Antilles');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "NI" , 'Nicaragua');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "PA" , 'Panama');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "PY" , 'Paraguay');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "PE" , 'Peru');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "PR" , 'Puerto Rico');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "BL" , 'Saint Barthélemy');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "KN" , 'Saint Kitts and Nevis');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "LC" , 'Saint Lucia');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "MF" , 'Saint Martin');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "PM" , 'Saint Pierre and Miquelon');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "VC" , 'Saint Vincent and the Grenadines');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "SR" , 'Suriname');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "TT" , 'Trinidad and Tobago');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "TC" , 'Turks and Caicos Islands');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "VI" , 'U.S. Virgin Islands');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "US" , 'United States');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "UY" , 'Uruguay');
INSERT INTO country(continent, code, name) VALUES ('Americas',            "VE" , 'Venezuela');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "AF" , 'Afghanistan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "AM" , 'Armenia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "AZ" , 'Azerbaijan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "BH" , 'Bahrain');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "BD" , 'Bangladesh');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "BT" , 'Bhutan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "BN" , 'Brunei');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KH" , 'Cambodia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "CN" , 'China');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "GE" , 'Georgia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "HK" , 'Hong Kong SAR China');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "IN" , 'India');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "ID" , 'Indonesia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "IR" , 'Iran');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "IQ" , 'Iraq');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "IL" , 'Israel');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "JP" , 'Japan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "JO" , 'Jordan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KZ" , 'Kazakhstan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KW" , 'Kuwait');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KG" , 'Kyrgyzstan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "LA" , 'Laos');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "LB" , 'Lebanon');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "MO" , 'Macau SAR China');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "MY" , 'Malaysia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "MV" , 'Maldives');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "MN" , 'Mongolia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "MM" , 'Myanmar [Burma]');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "NP" , 'Nepal');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "NT" , 'Neutral Zone');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KP" , 'North Korea');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "OM" , 'Oman');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "PK" , 'Pakistan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "PS" , 'Palestinian Territories');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "YD" , 'People\'s Democratic Republic of Yemen');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "PH" , 'Philippines');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "QA" , 'Qatar');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "SA" , 'Saudi Arabia');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "SG" , 'Singapore');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "KR" , 'South Korea');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "LK" , 'Sri Lanka');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "SY" , 'Syria');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TW" , 'Taiwan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TJ" , 'Tajikistan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TH" , 'Thailand');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TL" , 'Timor-Leste');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TR" , 'Turkey');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "TM" , 'Turkmenistan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "AE" , 'United Arab Emirates');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "UZ" , 'Uzbekistan');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "VN" , 'Vietnam');
INSERT INTO country(continent, code, name) VALUES ('Asia',            "YE" , 'Yemen');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "AL" , 'Albania');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "AD" , 'Andorra');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "AT" , 'Austria');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "BY" , 'Belarus');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "BE" , 'Belgium');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "BA" , 'Bosnia and Herzegovina');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "BG" , 'Bulgaria');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "HR" , 'Croatia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "CY" , 'Cyprus');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "CZ" , 'Czech Republic');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "DK" , 'Denmark');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "DD" , 'East Germany');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "EE" , 'Estonia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "FO" , 'Faroe Islands');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "FI" , 'Finland');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "FR" , 'France');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "DE" , 'Germany');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "GI" , 'Gibraltar');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "GR" , 'Greece');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "GG" , 'Guernsey');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "HU" , 'Hungary');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "IS" , 'Iceland');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "IE" , 'Ireland');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "IM" , 'Isle of Man');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "IT" , 'Italy');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "JE" , 'Jersey');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "LV" , 'Latvia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "LI" , 'Liechtenstein');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "LT" , 'Lithuania');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "LU" , 'Luxembourg');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "MK" , 'Macedonia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "MT" , 'Malta');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "FX" , 'Metropolitan France');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "MD" , 'Moldova');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "MC" , 'Monaco');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "ME" , 'Montenegro');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "NL" , 'Netherlands');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "NO" , 'Norway');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "PL" , 'Poland');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "PT" , 'Portugal');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "RO" , 'Romania');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "RU" , 'Russia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SM" , 'San Marino');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "RS" , 'Serbia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "CS" , 'Serbia and Montenegro');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SK" , 'Slovakia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SI" , 'Slovenia');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "ES" , 'Spain');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SJ" , 'Svalbard and Jan Mayen');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SE" , 'Sweden');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "CH" , 'Switzerland');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "UA" , 'Ukraine');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "SU" , 'Union of Soviet Socialist Republics');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "GB" , 'United Kingdom');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "VA" , 'Vatican City');
INSERT INTO country(continent, code, name) VALUES ('Europe',            "AX" , 'Åland Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "AS" , 'American Samoa');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "AQ" , 'Antarctica');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "AU" , 'Australia');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "BV" , 'Bouvet Island');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "IO" , 'British Indian Ocean Territory');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "CX" , 'Christmas Island');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "CC" , 'Cocos [Keeling] Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "CK" , 'Cook Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "FJ" , 'Fiji');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "PF" , 'French Polynesia');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "TF" , 'French Southern Territories');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "GU" , 'Guam');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "HM" , 'Heard Island and McDonald Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "KI" , 'Kiribati');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "MH" , 'Marshall Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "FM" , 'Micronesia');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "NR" , 'Nauru');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "NC" , 'New Caledonia');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "NZ" , 'New Zealand');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "NU" , 'Niue');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "NF" , 'Norfolk Island');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "MP" , 'Northern Mariana Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "PW" , 'Palau');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "PG" , 'Papua New Guinea');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "PN" , 'Pitcairn Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "WS" , 'Samoa');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "SB" , 'Solomon Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "GS" , 'South Georgia and the South Sandwich Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "TK" , 'Tokelau');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "TO" , 'Tonga');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "TV" , 'Tuvalu');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "UM" , 'U.S. Minor Outlying Islands');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "VU" , 'Vanuatu');
INSERT INTO country(continent, code, name) VALUES ('Oceania',            "WF" , 'Wallis and Futuna');

SELECT * FROM country;

DROP TABLE IF EXISTS university;

CREATE TABLE university(
	code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(60)
);

INSERT INTO university( code, name) VALUES ('UB', 'Universitat de Barcelona');
INSERT INTO university( code, name) VALUES ('UPF', 'Universitat Pompeu Fabra');
INSERT INTO university( code, name) VALUES ('UAB', 'Universitat Autònoma de Barcelona');
INSERT INTO university( code, name) VALUES ('UdL', 'Universitat de Lleida');
INSERT INTO university( code, name) VALUES ('UdG', 'Universitat de Girona');
INSERT INTO university( code, name) VALUES ('URV', 'Universitat Rovira i Virgili');
INSERT INTO university( code, name) VALUES ('UOC', 'Universitat Oberta de Catalunya');
INSERT INTO university( code, name) VALUES ('URL', 'Universitat Ramon Llull');
INSERT INTO university( code, name) VALUES ('Uvic', 'Universitat de Vic');
INSERT INTO university( code, name) VALUES ('UIC', 'Universitat Internacional de Catalunya');
INSERT INTO university( code, name) VALUES ('UAO-CEU', 'Universitat Abat Oliba');


