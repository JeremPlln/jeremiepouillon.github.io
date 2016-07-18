/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package apriori;

import java.util.Arrays;
import java.util.TreeSet;

/**
 *
 * @author simon
 */
public class Transaction {
	private Integer id;
	private final TreeSet<String> tags;

	public Transaction() {
		this(0);
	}

	public Transaction(Integer id) {
		this(id, null);
	}

	public Transaction(Integer id, String[] tags) {
		this.id = id;
		if(tags != null)
			this.tags = new TreeSet(Arrays.asList(tags));
		else
			this.tags = new TreeSet<>();
	}

	public TreeSet<String> getTags() {
		return tags;
	}

	public void addTag(String tag) {
		if(!this.tags.contains(tag))
			this.tags.add(tag);
	}
	
	public void removeTag(String tag) {
		this.tags.remove(tag);
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
}
