/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package apriori;

/**
 *
 * @author simon
 */
public class Rule {
	private Double confidence;
	private ItemSet input;
	private ItemSet output;

	public Rule(Double confidence, ItemSet input, ItemSet output) {
		this.confidence = confidence;
		this.input = input;
		this.output = output;
	}

	public Double getConfidence() {
		return confidence;
	}

	public void setConfidence(Double confidence) {
		this.confidence = confidence;
	}

	public ItemSet getInput() {
		return input;
	}

	public void setInput(ItemSet input) {
		this.input = input;
	}

	public ItemSet getOutput() {
		return output;
	}

	public void setOutput(ItemSet output) {
		this.output = output;
	}
	
	
}
