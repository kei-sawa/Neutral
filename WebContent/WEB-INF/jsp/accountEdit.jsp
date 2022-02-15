<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Account"  %>
<%
// セッションスコープからインスタンスを取得
Account account = (Account) session.getAttribute("Account");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Neutral | 会員情報編集ページ</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lobster&family=Nunito:ital,wght@1,200&family=Permanent+Marker&family=Titillium+Web:wght@200&family=Ubuntu:wght@300&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="js/item-image.js"></script>
<link rel="shortcut icon" href="favicon.ico"/>
<link rel="stylesheet" href="css/headers.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<!-- HEADER -->
<jsp:include page="header.jsp"></jsp:include>

<main>
    <p>ファッションを楽しむすべての人に。</p><br>
    <p>ユニセックスアイテムでもっと自由に。もっと楽しく。</p>

    <div class="container-scr">
     	<div class="shadow p-3 mb-5 bg-body rounded">
      		<p strong>会員登録情報編集ページ</p>
			<form action="/Neutral/AccountEditServlet" method="post">
				<div class="input-group flex-nowrap">
				  <span class="input-group-text bg-dark" id="addon-wrapping">名 前</span>
				  <input type="text" name="user_Name" class="form-control" value="<c:out value="${sessionScope.Account.getUserName() }"/>" aria-label="Username" aria-describedby="addon-wrapping" maxlength='20'>
				</div><br>
				<div class="input-group flex-nowrap">
				  <span class="input-group-text bg-dark" id="addon-wrapping">住 所</span>
				  <input type="text" name="adress" class="form-control" value="<c:out value="${sessionScope.Account.getAdress() }"/>" aria-label="Username" aria-describedby="addon-wrapping" maxlength='50'>
				</div><br>
				<div class="input-group flex-nowrap">
				  <span class="input-group-text bg-dark" id="addon-wrapping">メール</span>
				  <input type="email" name="email" class="form-control" value="<c:out value="${sessionScope.Account.getEmail() }"/>" aria-label="Username" aria-describedby="addon-wrapping" maxlength='50' pattern="^[0-9A-Za-z.!?/-@]+$" >
				</div><br>
				<div class="input-group flex-nowrap">
				  <span class="input-group-text bg-dark" id="addon-wrapping">TEL</span>
				  <input type="text" name="tel" class="form-control" value="<c:out value="${sessionScope.Account.getTel() }"/>" aria-label="Username" aria-describedby="addon-wrapping" maxlength='15' pattern="^[0-9A-Za-z-]+$">
				</div><br>
				<div class="input-group flex-nowrap">
				  <span class="input-group-text bg-dark" id="addon-wrapping">パスワード</span>
				  <input type="password" name="pass" class="form-control" value="<c:out value="${sessionScope.Account.getPass() }"/>" aria-label="Username" aria-describedby="addon-wrapping" maxlength='10' pattern="^[0-9A-Za-z.!?/-@]+$" >
				</div><br>
				<div class="input-group flex-nowrap">
				  <span class="input-group-text bg-dark" id="addon-wrapping">CARD</span>
				  <input type="text" name="card" class="form-control" value="<c:out value="${sessionScope.Account.getCard() }"/>" aria-label="Username" aria-describedby="addon-wrapping" maxlength='16' pattern="^[0-9A-Za-z]+$">
				</div><br>
				<button type="submit" class="btn btn-dark">変更する</button><br>
			</form>
      </div>
    </div>
</main>
<!--▼FOTTER-->
<jsp:include page="footer.jsp"></jsp:include>
<!--▲FOTTER-->
</body>
</html>