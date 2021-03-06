<%--
 * textbox.tag
 *
 * Copyright (C) 2019 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@ tag language="java" body-content="empty"%>

<%-- Taglibs --%>

<%@ taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<%-- Attributes --%>

<%@ attribute name="path" required="true"%>
<%@ attribute name="code" required="true"%>

<%@ attribute name="readonly" required="false"%>
<%@ attribute name="placeholder" required="false"%>

<%@ attribute name="id" required="false"%>

<jstl:if test="${readonly == null}">
	<jstl:set var="readonly" value="false" />
</jstl:if>

<%-- Definition --%>

<div>
	<form:label class="textboxLabel" path="${path}">
		<spring:message code="${code}" />
	</form:label>
	
	<jstl:if test="${placeholder != null}">
		<spring:message code="${placeholder }" var="hldr" />
		<jstl:if test="${id != null }">
			<form:input class="textbox" id="${id}" path="${path}"
				placeholder="${hldr }" readonly="${readonly}" />
		</jstl:if>
		<jstl:if test="${id == null }">
			<form:input class="textbox" path="${path}" placeholder="${hldr }"
				readonly="${readonly}" />
		</jstl:if>

	</jstl:if>
	<jstl:if test="${placeholder == null}">
		<jstl:if test="${id != null }">
			<form:input class="textbox" id="${id}" path="${path}"
				readonly="${readonly}" />
		</jstl:if>
		<jstl:if test="${id == null }">
			<form:input class="textbox" path="${path}" readonly="${readonly}" />
		</jstl:if>
	</jstl:if>
	<form:errors path="${path}" cssClass="error" />

</div>
