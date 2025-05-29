<%@page import="DTO.NoticeDTO"%>
<%@page import="Notice.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num")); // 글 번호 파라미터 받기

NoticeService ns = new NoticeService();
NoticeDTO nDTO = ns.searchOneNotice(num);
//not_num, content, name, status_type
pageContext.setAttribute("nDTO", nDTO);
%>
<div style="position: relative;">
    <h3 class="section-title">공지사항 상세페이지</h3>
	<hr class="line_gray">
	
	<table class="user_table">
    <thead>
        <tr>
            <th style="width: 25%;">제목</th>
            <td colspan="3">${ nDTO.title }</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${ nDTO.name }</td>
            <th>작성일</th>
            <td>${ nDTO.input_date}</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="4" style="height: 300px; vertical-align: top; padding: 15px;">
                ${ nDTO.content }
            </td>
        </tr>
    </tbody>
</table>
	
</div>