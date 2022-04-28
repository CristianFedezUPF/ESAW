package utils;


// enum with HTML tags for easier reuse and legibility
public enum HTML {
	HTML_OPEN("<!DOCTYPE html>"),
	HTML_CLOSE("</html>"),
	TITLE_OPEN("<title>"),
	TITLE_CLOSE("</title>"),
	HEAD_OPEN("<head>"),
	HEAD_CLOSE("</head>"),
	BODY_OPEN("<body>"),
	BODY_CLOSE("</body>"),
	TABLE_OPEN("<table>"),
	TABLE_CLOSE("</table>"),
	TABLEDATA_OPEN("<td>"),
	TABLEHEADER_OPEN("<th>"),
	TABLEROW_OPEN("<tr>"),
	TABLEDATA_CLOSE("</td>"),
	TABLEHEADER_CLOSE("</th>"),
	TABLEROW_CLOSE("</tr>");
	
	
	private HTML(String tag) {
		this.tag = tag;
	}
	
	private String tag;
	
	public String tag() {
		return this.tag;
	}
}
