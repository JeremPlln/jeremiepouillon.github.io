/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package apriori;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Objects;
import java.util.Set;
import java.util.TreeSet;

/**
 *
 * @author simon
 */
public class ItemSet implements Comparable<ItemSet>{

	private final TreeSet<String> tags;
	private final TreeSet<ItemSet> subIS;
	private Integer frequency;
	private Double confidence;

	public ItemSet() {
		this(null);
	}

	public ItemSet(String[] tags) {
		this.subIS = new TreeSet<>();
		this.frequency = 0;
		if (tags != null) {
			this.tags = new TreeSet(Arrays.asList(tags));
		} else {
			this.tags = new TreeSet<>();
		}
	}

	public TreeSet<String> getTags() {
		return tags;
	}

	public boolean hasTag(String tag) {
		return this.tags.contains(tag);
	}

	public void addTag(String tag) {
		if (!this.tags.contains(tag)) {
			this.tags.add(tag);
		}
	}

	public void addTags(TreeSet<String> tags) {
		for (String tag : tags) {
			if (!this.tags.contains(tag)) {
				this.tags.add(tag);
			}
		}
	}

	public void removeTag(String tag) {
		this.tags.remove(tag);
	}

	public Integer getTagCount() {
		return this.tags.size();
	}

	public TreeSet<ItemSet> getSubIS() {
		return subIS;
	}

	public ArrayList<ItemSet> getAllSubIS() {
		if(this.subIS.isEmpty())
			return null;
		
		ArrayList<ItemSet> tmp;
		Set<ItemSet> subs = new LinkedHashSet<>(subIS);
		for (ItemSet sub : subIS) {
			tmp = sub.getAllSubIS();
			if(tmp != null)
				subs.addAll(tmp);
		}
		ArrayList<ItemSet> finalSubs = new ArrayList<>(subs);
		Collections.sort(finalSubs);
		return finalSubs;
	}
	
	public Boolean hasSubIS(ItemSet subIS){
		if(this.subIS.contains(subIS))
			return true;
		for (ItemSet subIS1 : this.subIS) {
			if(subIS1.hasSubIS(subIS))
				return true;
		}
		return false;
	}

	public void addSubIS(ItemSet subIS) {
		if (!this.subIS.contains(subIS)) {
			this.subIS.add(subIS);
		}
	}

	public void addSubIS(TreeSet<ItemSet> subIS) {
		for (ItemSet subIS1 : subIS) {
			if (!this.subIS.contains(subIS1)) {
				this.subIS.add(subIS1);
			}
		}
	}

	public void removeSubIS(ItemSet subIS) {
		this.subIS.remove(subIS);
	}

	public Integer getFrequency() {
		return frequency;
	}

	public void setFrequency(Integer frequency) {
		this.frequency = frequency;
	}

	public void incFrequency() {
		this.frequency++;
	}

	public Double getConfidence() {
		return confidence;
	}

	public void setConfidence(Double confidence) {
		this.confidence = confidence;
	}

	public String getId() {
		String id = "";
		return id;
	}

	@Override
	public String toString() {
		return String.join("\t", this.tags) + " = " + this.frequency;
	}

	@Override
	public int compareTo(ItemSet t) {
		
		if(this == t){
			return 0;
		}
		
		if(!Objects.equals(t.getTagCount(), this.getTagCount()) && t.getTags().first().equals(this.getTags().first())){
			if(this.getTagCount() > t.getTagCount())
				return 1;
			else
				return -1;
		}
		Iterator<String> it1 = t.getTags().iterator();
		Iterator<String> it2 = this.getTags().iterator();
		String s1, s2;
		while(it1.hasNext() && it2.hasNext()){
			s1 = it1.next();
			s2 = it2.next();
			if(!s1.equals(s2)){
				int i = s2.compareTo(s1);
				return i;				
			}
		}
		if(it1.hasNext())
			return -1;
		else if (it2.hasNext())
			return 1;
		
		return 0;
	}

	public void trimSubsets(ArrayList<ArrayList<ItemSet>> frequencies, final Integer minSupport) {		
		if(this.getTagCount() > 2){
			subIS.stream().forEach((subIS1) -> {
				subIS1.trimSubsets(frequencies, minSupport);
			});
		}
		
		if(this.frequency == null){
			System.out.println("NULL Frequency");
		}
		if(this.frequency <= minSupport){
			frequencies.get(this.getTagCount()-2).remove(this);
		}
	}
	
	public void trimSubsets(ArrayList<ArrayList<ItemSet>> frequencies) {		
		subIS.stream().forEach((subIS1) -> {
			subIS1.trimSubsets(frequencies, this.frequency);
		});
	}
}
