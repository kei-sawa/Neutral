<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Cart,java.util.ArrayList"%>
<%
// セッションスコープからカート情報を取得
Cart cart = (Cart) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Neutral | カートの確認</title>
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
<style>
.label-danger {
color:red;
}
</style>
<!-- 小計と合計の算出メソッドを定義  -->
<script>
	function total(){
		var tableElem = document.getElementById('table_contents');
	       var rowElems = tableElem.rows;
	       var totalPrice = 0;
	       
	       for (i = 0, len = rowElems.length; i < len; i++) {
	         totalPrice += parseInt(rowElems[i].cells[6].innerText);
	       }
	       document.getElementById('total').innerText = totalPrice + " 円"; 
	};
	
    function calcurate() {
  	  if(document.getElementById("checkboxNoLabel").checked==true){
       var lot = parseInt(document.getElementById("orderLot").value);
       console.log(lot);
       var subtotal = lot * price;
       console.log(subtotal);
       document.getElementById("subtotal").innerText = subtotal + " 円";
  	  }else{
  		  
  		document.getElementById("subtotal").innerText = 0 + " 円";  
  	  }
  	  total();
   	};
</script>
</head>
<body>
<!-- HEADER -->
<jsp:include page="header.jsp"></jsp:include>

<main>
    <p>ファッションを楽しむすべての人に。</p><br>
    <p>ユニセックスアイテムでもっと自由に。もっと楽しく。</p>

    <div class="container-sc">
	    <div class="shadow p-3 mb-5 bg-body rounded">
	    	<% if(cart == null){ %>
	    		<p class="label-danger">※カートに商品が入っていません</p>
	    	<% } %>
		    <form action="  " method="post">
		    <table class="table table-bordered border-secondary">
		      <thead>
		        <tr>
		          <th scope="col" style="width: 50px"></th>
		          <th scope="col" style="width: 150px">商品ID</th>
		          <th scope="col" style="width: 200px">商品名</th>
		          <th scope="col" style="width: 100px">サイズ</th>
		          <th scope="col" style="width: 90px">個数</th>
		          <th scope="col" style="width: 120px">単価</th>
		          <th scope="col" style="width: 120px">小計</th>
		        </tr>
		      </thead>
		      <tbody id="table_contents">

		        <% // for (Cart cart: cartList) { %>
			        <% if (cart != null) { %>
			        <tr>
			          <th scope="row" style="width: 50px" class="checkbox">
				          <div>
				            <input class="form-check-input" type="checkbox" id="checkboxNoLabel" value="" onchange="calcurate()" aria-label="..." checked>
				          </div>
			          </th>
			          <td style="width: 100px"><%=cart.getProductId()%></td>
			          <td style="width: 200px"><%=cart.getOrderProduct()%></td>
			          <td style="width: 100px"><%=cart.getOrderSize()%></td>
			          <td style="width: 120px"><input class="kosuu" type="number"  min="1" id="orderLot" value="<%=cart.getOrderNumber()%>">個</td>
			          <td style="width: 120px" class="example1">
			          	<script>
			          		var price = <%=cart.getOrderPrice()%>;
			          	</script>
			          	<%=cart.getOrderPrice()%>円
			          </td>
			          <td style="width: 120px" class="example1" id="subtotal">
					    <%=cart.getSubtotal() %>円
			          </td>
			        </tr>
			        <% } else { %>
			        <tr>
			          <th scope="row" style="width: 50px" class="checkbox">
				          <div>
				            <input class="form-check-input" type="checkbox" id="checkboxNoLabel" value="" aria-label="...">
				          </div>
				      </th>
			          <td style="width: 100px"></td>
			          <td style="width: 200px"></td>
			          <td style="width: 100px"></td>
			          <td style="width: 120px"><input class="kosuu" value=""> 個</td>
			          <td style="width: 120px" class="example1">円</td>
			          <td style="width: 120px" class="example1">
			          	<script>
			          		var subtotal = 0;
			          	</script>
			          	0 円
			          </td>
			        </tr>
			        <% } %>
		        <%// } %>
		      </tbody>
		      <tfoot>
		        <tr>
		          <th scope="col" style="width: 50px"></th>
		          <th scope="col" style="width: 100px"></th>
		          <th scope="col" style="width: 200px"></th>
		          <th scope="col" style="width: 100px"></th>
		          <th scope="col" style="width: 120px"></th>
		          <th scope="col" style="width: 120px" class="example1">合計金額</th>
		          <th scope="col" style="width: 120px" class="example1" id="total">
		           <script>
                      //カートに入っている商品の合計金額を計算
                      total();
                      //数量が変更された場合の再計算処理
                      document.getElementById("orderLot").onchange = function () {
                        calcurate();
                        total();
                    };
                    </script>
		          </th>
		        </tr>
		      </tfoot>
		    </table>
		    </form>
		    <p>ご購入の商品にチェックを入れてください。</p>
		    <p>お買い物を続ける場合は、買い物を続けるボタンをクリックしてください。</p>
		    <p>※まだ会員登録がお済みでないかたは、新規会員登録ボタンから新規会員登録をして<br>
		      ログインされてからご注文をお願いいたします。</p>
		    <div><br>
				 <a href="/Neutral/WelcomeServlet"><button type="button" class="btn btn-outline-dark">買い物を続ける</button></a>
			     <a href="/Neutral/RegisterServlet"><button type="button" class="btn btn-dark">新規会員登録</button><br><br></a>
		    </div>
	    </div>
    </div>
</main>
<!-- FOOTER -->
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>