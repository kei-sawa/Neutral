package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AccountDAO;
import dao.CartDAO;
import model.Account;
import model.Cart;
import model.Login;
import model.RegisterLogic;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/register.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//リクエストパラメータの取得
		request.setCharacterEncoding("UTF-8");
		String userName = request.getParameter("userName");
		String adress = request.getParameter("adress");
		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
		String tel = request.getParameter("tel");
		String card = request.getParameter("card");

		//アカウントデータ格納用のAccountオブジェクトを生成
		Account account = new Account();
		account.setUserName(userName);
		account.setAdress(adress);
		account.setEmail(email);
		account.setPass(pass);
		account.setTel(tel);
		account.setCard(card);

		// USER_IDを取得して変数に代入
		int userId = account.getUserId();

		//DAOオブジェクト宣言
		AccountDAO ad = new AccountDAO();

		//登録処理の実行
		RegisterLogic rl = new RegisterLogic();
		boolean b = rl.execute(account);

		//登録処理成功時
		if(b == true) {
			//ログイン情報の取得
			Login login = new Login(email, pass);
			Account user = ad.findByLogin(login);

			//セッションスコープに登録したAccountオブジェクトを保存
			HttpSession session = request.getSession();
			session.setAttribute("Account", user);
			
			// セッションスコープからカート情報を取得
			Cart cart = (Cart) session.getAttribute("cart");
			
			//cartに情報が入っていた時の処理
			if(cart != null) {
			// 新規顧客IDをcartに反映する
			cart.setUserId(user.getUserId());

			// CartDAOインスタンスを生成し、Cartテーブルに情報を追加
			CartDAO cartDao = new CartDAO();
			cartDao.insert(cart);
			}
			//フォワード
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/registerOK.jsp");
			dispatcher.forward(request, response);

		//登録処理失敗時
		} else {

			//アカウント削除
			ad.delete(userId);

			//フォワード
			request.setAttribute("message", "このメールアドレスとパスワードは既に使用されています");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/register.jsp");
			dispatcher.forward(request, response);

		}
	}
}

