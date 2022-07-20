package model.bean;

import java.util.*;

public class CartBean {

    List<CartItemBean> packages;
    Double totalCost;

    public CartBean() {
    	packages = new ArrayList<>();
        totalCost = 0.00;
    }
    
    public Double getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(Double totalCost) {
		this.totalCost = totalCost;
	}

	public void addItem(CartItemBean cartItem) {
		totalCost += cartItem.getTotale();
        packages.add(cartItem);
	}
	
	public void removeItem(Integer codicePacchetto){
        for (CartItemBean c : packages) {
			if(c.getCodicePacchetto() == codicePacchetto) {
				packages.remove(c);
				totalCost -= c.getTotale();
				return;
			}
		}
    }
	
	public List<CartItemBean> getPackages() {
		return packages;
	}

	public void setPackages(List<CartItemBean> packages) {
		this.packages = packages;
	}
	
	public void updateItem(CartItemBean cartItem) {
		for(CartItemBean c: packages) {
			if(c.getCodicePacchetto() == cartItem.getCodicePacchetto()) {
				packages.remove(c);
				totalCost -= c.getTotale();
				packages.add(cartItem);
				totalCost -= cartItem.getTotale();
				return;
			}
		}
		
		
	}
	
	public void removeAllItems() {
		packages.clear();
		totalCost = 0.00;
	}
	
	public boolean isAlreadyBooked(CartItemBean otherItem) {
		for(CartItemBean cartItem : packages) {
			if(cartItem.isSamePackage(otherItem))
				return true;
		}
		return false;
	}

}
