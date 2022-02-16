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
import model.Account;
import model.Login;
import model.LoginLogic;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//リクエストパラメータの取得
		request.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");
		String pass = request.getParameter("pass");

		//ログイン処理の実行
		Login login = new Login(email, pass);
		LoginLogic bo = new LoginLogic();
		boolean result = bo.execute(login);

		//アカウント情報の取得
		AccountDAO dao = new AccountDAO();
		Account account = dao.findByLogin(login);

		//ログイン処理の成否によって処理を分岐
		if(result) {//ログイン成功時
			//セッションスコープにメールアドレスとアカウント情報を保存
			HttpSession session = request.getSession();
			session.setAttribute("Account", account);

			//フォワード
			RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/loginOK.jsp");
			dispatcher.forward(request, response);
		} else { //ログイン失敗時
			//フォワード
			request.setAttribute("message", "メールアドレスまたはパスワードが違います");
			request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
			return;
		}
	}

}
