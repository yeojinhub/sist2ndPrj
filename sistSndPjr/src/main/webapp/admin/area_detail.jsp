<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 대시보드</title>
<link rel="stylesheet" href="../common/css/styles.css">
<script src="script.js"></script>
<!-- Font Awesome for icons -->
<link rel="stylesheet"
   href="http://localhost/sistSndPjr/common/css/styles.css">
</head>
<body>
   <div class="container">
   		<!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp" />

      <!-- Main Content -->
      <div class="main-content">
         <div class="header">
            <h1>휴게소 상세정보 수정</h1>
         </div>
         <div class="content">
         <div class="top-section">
         <div class="left-area">
            <div class="rest-area-details">
               <!-- 이미지 업로드 및 미리보기 -->
               <div class="image-upload-section">
                  <img src="../common/images/main_pic.png" alt="휴게소 이미지" class="preview-img">
               </div>
               <div>
               <!--  <input type="text" value="파일경로" readonly> <input type="file" id="fileUpload">
                     <button class="btn btn-info">파일선택</button>-->
               </div>
            </div>

               <!-- 기본 정보 -->
               <div class="info-section">
                  <label>휴게소명</label><input type="text">
                  <label>주소</label> <input type="text">
                  <label>전화번호</label> <input type="text">
                  <label>노선</label> <input type="text"> <label>영업시간</label>
                  <input type="text">
               </div>
            </div>

               <!-- 편의시설 -->
            <div class="right-area">
               <div class="facility-section">
                  <h3 style="padding-top: 25px; padding-bottom: 10px">편의시설</h3>
                  <hr style="color : #E3E3E3;">
                  <div class="checkbox-group">
                     <label class="facility-label"><input type="checkbox" class="checkbox-label"> 수유실</label>
                     <label class="facility-label"><input type="checkbox" class="checkbox-label"> 쉼터</label>
                     <label class="facility-label"><input type="checkbox" class="checkbox-label"> 수면실</label>
                     <label class="facility-label"><input type="checkbox" class="checkbox-label"> 이발소</label>
                     <label class="facility-label"><input type="checkbox" class="checkbox-label"> 샤워실</label>
                     <label class="facility-label"><input type="checkbox" class="checkbox-label"> 경정비소</label>
                     <label class="facility-label"><input type="checkbox" class="checkbox-label"> 세탁실</label>
                     <label class="facility-label"><input type="checkbox" class="checkbox-label"> 세차장</label>
                     <label class="facility-label"><input type="checkbox" class="checkbox-label"> 병원</label>
                     <label class="facility-label"><input type="checkbox" class="checkbox-label"> 약국</label>
                     <input type="text" style="margin-top: 30px;">
                  </div>
               </div>
            </div>
            </div>
               <!-- 음식 리스트 -->
               <div class="menu-section">
                  <table class="menu-table">
                     <thead>
                        <tr>
                           <th></th>
                           <th>번호</th>
                           <th>음식명</th>
                           <th>가격</th>
                           <th>이미지</th>
                        </tr>
                     </thead>
                     <tbody>
                        <tr>
                           <td><input type="checkbox"></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                        </tr>
                        <tr>
                           <td><input type="checkbox"></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                        </tr>
                        <tr>
                           <td><input type="checkbox"></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                        </tr>
                        <tr>
                           <td><input type="checkbox"></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                        </tr>
                        <tr>
                           <td><input type="checkbox"></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                        </tr>
                     </tbody>
                  </table>
               </div>
         </div>

         <div class="button-group">
            <button class="btn btn-primary">수정</button>
            <button class="btn btn-secondary">취소</button>
         </div>

      </div>
   </div>
</body>
</html>
