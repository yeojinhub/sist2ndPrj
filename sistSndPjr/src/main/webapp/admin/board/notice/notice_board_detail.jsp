<%@page import="Notice.NoticeDTO"%>
<%@page import="Notice.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/jsp/login_chk.jsp" %>
<%
int notNum = Integer.parseInt(request.getParameter("not_num"));
NoticeService service = new NoticeService();
NoticeDTO notice = service.getNoticeOne(notNum);
request.setAttribute("notice", notice);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="../../common/css/styles.css">
<!-- Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Quill CSS -->
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
	rel="stylesheet">


<!-- Quill JS -->
<script src="/admin/script.js"></script>
<script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>

</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>공지사항 상세</h1>
            </div>
             <form action="notice_update_process.jsp" method="post" onsubmit="return beforeSubmit();">
                <input type="hidden" name="not_num" value="${notice.not_num}" />
                <input type="hidden" name="content" id="content" />

                <div class="content">
                    <div class="notice-div">
                        <table class="notice-table">
                            <tbody>
                                <tr>
                                    <td class="tdColumn">작성자</td>
                                    <td><input type="text" class="input-style" value="${notice.name}" readonly /></td>
                                    <td class="tdColumn">작성일</td>
                                    <td><input type="text" class="input-style" value="${notice.input_date}" readonly /></td>
                                </tr>
                                <tr>
                                    <td>제목</td>
                                    <td colspan="3">
                                        <input type="text" class="input-style title" name="title" value="${notice.title}" required />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div class="radio-container" style="border:2px solid #ccc; padding: 10px;" >
                                            <label><input type="radio" name="status_type" value="공지" <c:if test="${notice.status_type=='공지'}">checked</c:if> /> 공지</label>
                                            <label><input type="radio" name="status_type" value="미공지" <c:if test="${notice.status_type=='미공지'}">checked</c:if>/> 미공지</label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div id="quilleditor">${notice.content}</div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                

			<div class="button-detail">
<%-- 			    <form action="notice_update_process.jsp" method="post" onsubmit="return beforeSubmit();" >
			        <input type="hidden" name="not_num" value="${notice.not_num}" />
			        <input type="hidden" name="content" id="content" /> --%>
			        
			        <button class="btn btn-edit" type="submit">수정</button>
			        <button class="btn btn-back" type="button" onclick="location.href='notice_board.jsp'">취소</button>
		</form>
			
			    <form action="notice_delete_process.jsp" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
			        <input type="hidden" name="not_num" value="${notice.not_num}" />
			        <button type="submit" class="btn btn-delete">삭제</button>
			    </form>
			    </div>
			</div>
        </div>

    <script>
        var quill = new Quill('#quilleditor', {
            theme: 'snow',
            placeholder: '내용을 입력하세요.',
            modules: {
                toolbar: [
                    [{'header': '1'}, {'header': '2'}, {'font': []}],
                    [{'list': 'ordered'}, {'list': 'bullet'}],
                    ['bold', 'italic', 'underline'],
                    ['link', 'image'],
                    [{'align': []}],
                    ['clean']
                ]
            }
        });
        function beforeSubmit() {
            document.getElementById("content").value = quill.root.innerHTML;
            return confirm("정말 수정하시겠습니까?");
        }
    </script>
</body>
</html>