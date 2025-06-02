<%@page import="FAQ.FAQService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../jsp/external_file.jsp" />

<style>
</style>
<script>
<%
FAQService fs = new FAQService();
pageContext.setAttribute("faqList", fs.searchAllFAQ());
%>
</script>
<div>
	<div style="position: relative;">
		<h3 class="section-title">공지사항</h3>
		<hr class="line_gray">

		<div class="accordion" id="accordionExample" style="width: 960px;">
			<c:forEach var="fDTO" items="${ faqList }" varStatus="status">
			<div class="accordion-item" style="text-align: center;">
				<h2 class="accordion-header">
					<button class="accordion-button ${status.first ? '' : 'collapsed'}" 
					type="button"
						data-bs-toggle="collapse" data-bs-target="#collapse${ status.index }"
						aria-expanded="${status.first ? 'true' : 'false'}" aria-controls="collapse${status.index}">
						${fDTO.title}
					</button>
				</h2>
				<div id="collapse${status.index}" class="accordion-collapse collapse <c:if test='${status.first}'>show</c:if>"
					data-bs-parent="#accordionExample">
					<div class="accordion-body">
						${fDTO.content}
					</div>
				</div>
			</div>
			</c:forEach>
			
		</div>

	</div>
</div>