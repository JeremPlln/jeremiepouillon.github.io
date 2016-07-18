package model;

import java.util.Collections;
import java.util.List;

/**
 * Represents a real-world retail store transaction. It consists of :
 * 	- tid : Transaction Id
 * 	- cid : Customer Id
 *  - items : List of items purchased in this transaction.
 *  
 *  If transaction id is not present in the dataset, it is defaulted to customer id.
 *  @author shishir
 */
public class Transaction 
{
	private int tid;
	private int cid;
	private List<String> items;
	
	public Transaction(int tid, int cid, List<String> items) {
		super();
		this.tid = tid;
		this.cid = cid;
		
		this.setItems(items);
	}

	@Override
	public String toString() {
		return "Transaction [tid=" + tid + ", cid=" + cid + ", items=" + items + "]";
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public List<String> getItems() {
		return items;
	}

	private void setItems(List<String> items) {
		this.items = items;

		Collections.sort(this.items);
	}
}
