<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 추천 프로젝트</title>
<style>
   body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      color: #333;
      margin: 0;
      padding: 0;
   }

   .header {
      background-color: #ff6f61;
      color: #fff;
      text-align: center;
      padding: 10px;
   }

   .header h2 {
      margin: 0;
   }

   .menu {
      background-color: #333;
      text-align: center;
   }

   .menu ul {
      list-style: none;
      padding: 0;
      margin: 0;
   }

   .menu li {
      display: inline-block;
      margin: 0;
      padding: 10px 20px;
   }

   .menu li a {
      text-decoration: none;
      color: #fff;
      font-size: 18px;
   }

   .content-container {
      text-align: center;
      margin-top: 20px;
   }

   .content {
      padding: 20px;
      text-align: left;
      background-color: #fff;
      border-radius: 5px;
      box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
   }

   .content table {
      width: 100%;
      table-layout: fixed;
      border-collapse: collapse;
   }

   .content td {
      padding: 20px;
      vertical-align: top;
   }

   .content .image-container {
      text-align: center;
      margin-bottom: 10px;
   }

   .content img {
      max-width: 100%;
      max-height: 300px;
      border-radius: 5px;
      box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
   }

   .content p {
      margin: 10px 0;
      font-size: 14px; /* 내용의 글꼴 크기 조정 */
      line-height: 1.5; /* 내용의 줄 간격 조정 */
   }

   .btn-container {
      text-align: center;
      margin-top: 20px;
   }

   .btn-container a {
      display: inline-block;
      background-color: #ff6f61;
      color: #fff;
      text-decoration: none;
      padding: 10px 20px;
      margin: 10px;
      border-radius: 5px;
      transition: background-color 0.3s ease;
   }

   .btn-container a:hover {
      background-color: #ff422d;
   }

   .footer {
      text-align: center;
      background-color: #333;
      color: #fff;
      padding: 10px;
   }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
   <div class="header">
      <h2>맛집 카테고리</h2>
   </div>
   <div class="menu">
      <ul>
         <li><a href="list">전체</a></li>
         <li><a href="list?cate=한식">한식</a></li>
         <li><a href="list?cate=중식">중식</a></li>
         <li><a href="list?cate=일식">일식</a></li>
         <li><a href="list?cate=양식">양식</a></li>
         <li><a href="list?cate=분식">분식</a></li>
         <li><a href="list?cate=패스트푸드">패스트푸드</a></li>
      </ul>
   </div>
   <div class="content-container">
      <div class="content">
         <table>
            <tr>
               <c:forEach items="${list}" var="dto" varStatus="status">
                  <td>
                     <div class="image-container">
                        <a href="content_view?pno=${dto.pno}">
                           <img src="/img/${dto.imgPath}" alt="맛집 이미지">
                        </a>
                     </div>
                     <p class="title">${dto.title}</p>
                     <p class="content">${dto.content}</p>
                     <c:if test="${status.count%3 == 0}">
                        </td></tr><tr>
                     </c:if>
               </c:forEach>
            </tr>
         </table>
      </div>
   </div>
   <div class="btn-container">
      <a href="write_view" class="btn">글작성</a>
   </div>
   <div class="footer">
      맛집 추천 프로젝트 &copy; 2023
   </div>
</body>
</html>
