package model;

import dao.CartDAO;

public class CartCheck {
	public boolean execute(int userId, String productId, String productSize) {
		CartDAO dao = new CartDAO();
		int cartNumber = dao.cartCheck(userId, productId, productSize);
		
		return cartNumber > 0 ;
	}
}
