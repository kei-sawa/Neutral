<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<header class="py-3 mb-4 border-bottom">
	<nav class="py-2 bg-white border-bottom">
		<div class="container d-flex flex-wrap">
			<ul class="nav me-auto">
				<li class="nav-item"><a href="/Neutral/WelcomeServlet" class="nav-link link-dark px-2 active" aria-current="page">TOP</a></li>
				<c:if test="${sessionScope.Account != null}">
				<li class="nav-item"><a href="/Neutral/AccountServlet" class="nav-link link-dark px-2">MYPAGE</a></li>
				</c:if>
				<li class="dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				  CATEGORY
				</a>
					<ul class="dropdown-menu dropdown-menu-secondary" aria-labelledby="navbarDarkDropdownMenuLink">
						<li><a class="dropdown-item" href="/Neutral/WelcomeServlet?id=TS">ＴＳ:　Tシャツ・カットソー</a></li>
						<li><a class="dropdown-item" href="/Neutral/WelcomeServlet?id=SW">ＳＷ:　スウェット</a></li>
						<li><a class="dropdown-item" href="/Neutral/WelcomeServlet?id=CO">ＣＯ:　コート</a></li>
						<li><a class="dropdown-item" href="/Neutral/WelcomeServlet?id=DC">ＤＣ:　ダウン</a></li>
						<li><a class="dropdown-item" href="/Neutral/WelcomeServlet?id=KN">ＫＮ:　ニット・セーター</a></li>
						<li><a class="dropdown-item" href="/Neutral/WelcomeServlet?id=JE">ＪＥ:　ジーンズ・カラージーンズ</a></li>
						<li><a class="dropdown-item" href="/Neutral/WelcomeServlet?id=HP">ＨＰ:　ハーフパンツ</a></li>
						<li><a class="dropdown-item" href="/Neutral/WelcomeServlet?id=CA">ＣＡ:　帽子・キャップ・ハット</a></li>
						<li><a class="dropdown-item" href="/Neutral/WelcomeServlet?id=MA">ＭＡ:　マスク</a></li>
						<li><a class="dropdown-item" href="/Neutral/WelcomeServlet?id=BA">ＢＡ:　バッグ</a></li>
					</ul>
				</li>
				<li class="nav-item"><a href="/Neutral/CartServlet" class="nav-link link-dark px-2">CART</a></li>
			 </ul>
			<ul class="nav">
				<c:if test="${sessionScope.Account == null}">
				<li class="nav-item"><a href="/Neutral/LoginServlet" class="nav-link link-dark px-2">ログイン</a></li>
				</c:if>
				<c:if test="${sessionScope.Account != null}">
				<li class="nav-item"><a href="/Neutral/LogoutServlet" class="nav-link link-dark px-2">ログアウト</a></li>
				</c:if>
				<c:if test="${sessionScope.Account == null}">
				<li class="nav-item"><a href="/Neutral/RegisterServlet" class="nav-link link-dark px-2">会員登録</a></li>
				</c:if>	    
				<li class="nav-item"><a href="/Neutral/AdminLoginServlet" class="nav-link link-dark px-2">お店を管理する</a></li>
			</ul>
		</div>
	</nav>
	<div class="container d-flex flex-wrap justify-content-center">
		<a href="/Neutral/WelcomeServlet" class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none">
			<svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
			<span class="fs-4"> <h1 class="logo">Neutral</h1></span>
		</a>
		<form class="d-flex" action="/Neutral/WelcomeServlet" method="post">
          <input class="form-control me-2" type="search" name="query" placeholder="Search">
          <button class="btn btn-outline-dark" type="submit">Search</button>
        </form>
	</div>
</header>