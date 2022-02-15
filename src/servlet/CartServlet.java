package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import model.Account;
import model.Cart;
import model.CartCheck;
import model.Product;
import model.StockCheck;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// セッションスコープからAccountデータを取得
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("Account");

		// Accountデータが空でない場合（ログイン時）
		if(account != null) {
			CartDAO dao = new CartDAO();
			int userId =account.getUserId();
			ArrayList<Cart> cart = dao.selectByUserId(userId);
			session.setAttribute("cartList", cart);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/orderLogin.jsp");
			dispatcher.forward(request,  response);

		// Accountデータが空の場合（非ログイン時）
		}else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/orderLogout.jsp");
			dispatcher.forward(request,  response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// リクエストパラメーターを取得（注文個数）
		request.setCharacterEncoding("UTF-8");
		int orderNumber = Integer.parseInt(request.getParameter("orderNumber"));
		String orderSize = request.getParameter("orderSize");


		// セッションスコープからアカウントデータと商品データを取得
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("Account");
		Product product = (Product) session.getAttribute("Product");
		String productId = product.getProductId();
		String productName = product.getProductName();
		int orderPrice = product.getPrice();

		// 商品データ格納用のCartオブジェクトを生成
		Cart cart = new Cart();
		cart.setProductId(productId);
		cart.setOrderProduct(productName);
		cart.setOrderPrice(orderPrice);
		cart.setOrderSize(orderSize);
		cart.setOrderNumber(orderNumber);
		cart.setSubtotal();
		
		//商品の在庫有無を確認
    	StockCheck stockCheck = new StockCheck();
    	boolean result = stockCheck.execute(cart.getProductId(), cart.getOrderSize(), cart.getOrderNumber());
    	//在庫が不足していた場合
    	if(!result) {
    		//フォワード
			request.setAttribute("message", "※選択した商品は在庫切れです");
			request.getRequestDispatcher("/WEB-INF/jsp/order.jsp").forward(request, response);
		//在庫がある場合
    	}else {
    		// セッションスコープにCartインスタンスを保存
    		session.setAttribute("cart", cart);

    		// Accountデータが空でない場合（ログイン時）
    		if(account != null) {

    			// 顧客ID情報を取得してcartに反映する
    			int userId = account.getUserId();
    			cart.setUserId(userId);
    			
    			//既に同一顧客のカートに追加されている同製品がないか確認
    			CartCheck cartCheck = new CartCheck();
    			boolean rs = cartCheck.execute(userId, productId, orderSize);
    			//同一商品がカートに入っていた場合の処理
    			if(rs) {
    				//カートに最終的に入っている合計数量分の在庫があるかを確認
    				CartDAO cartDao = new CartDAO();
    				int cartTotal = cartDao.cartCheck(userId, productId, orderSize) + orderNumber;
    		    	boolean check = stockCheck.execute(productId, orderSize,cartTotal);
    		    	//在庫が足りなくなった場合の処理
    		    	if(!check) {
    		    		//フォワード
    					request.setAttribute("message", "※選択した商品は在庫切れです");
    					request.getRequestDispatcher("/WEB-INF/jsp/order.jsp").forward(request, response);
    				//在庫が足りる場合は、カートの数量を変更する
					}else {
	    				cartDao.cartAdd(userId, productId, orderSize, orderNumber);
					}
				}else{
				// CartDAOインスタンスを生成し、Cartテーブルに情報を追加
	    			CartDAO cartDao = new CartDAO();
	    			cartDao.insert(cart);
				}
				// 特定のユーザーに紐づくカートテーブルのデータを全件取得する命令を呼び出し、戻り値を取得する
				CartDAO cartDao = new CartDAO();
				ArrayList<Cart> cartList = cartDao.selectByUserId(userId);
					
				// カート情報をセッションスコープに格納
				session.setAttribute("cartList", cartList);
					
				// フォワード
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/orderLogin.jsp");
				dispatcher.forward(request,  response);
					
	    		// Accountデータが空の場合（非ログイン時）
	    		}else {
	    			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/orderLogout.jsp");
	    			dispatcher.forward(request,  response);
	    		}
    	}


	}

}
