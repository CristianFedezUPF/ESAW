<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<option value="0" label="Select a country ... " selected="selected">Select a country ... </option>
<c:forEach var="countriesEntry" items="${countries}" >
   <optgroup id="country-optgroup-${countriesEntry.key}" label="${countriesEntry.key}">
    <c:forEach items="${countriesEntry.value}" var="country">
      <option value="${country.name}" label="${country.name}">${country.name}</option>
    </c:forEach>
    </optgroup>
</c:forEach>