/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package apriori;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.ListIterator;
import java.util.Scanner;

/**
 *
 * @author simon
 */
public class APriori {

	static ArrayList<Transaction> transactions = new ArrayList<>();
	static ArrayList<ArrayList<ItemSet>> frequencies = new ArrayList<>();

	static ArrayList<ArrayList<ItemSet>> taboos = new ArrayList<>();
	static ArrayList<Rule> rules = new ArrayList<>();

	static Integer minSupport = 3;
	static Double minConfiance = 0.75;
	static Integer nbTransactions = 0;

	public static void main(String[] args) throws IOException {
		File dir = new File(".");
		File fin = new File(dir.getCanonicalPath() + File.separator + "sample3.dat");

		loadFile(fin);

		Integer index = 0;
		taboos.add(new ArrayList<>());
		do {
			System.out.println("------------ ETAPE " + (index+2) + " -------------");
			System.out.println(frequencies.get(index).size());
			System.out.println(taboos.get(0).size());
			join(frequencies.get(index), taboos.get(0));
			taboos.remove(0);
			index++;
		} while (frequencies.get(index).size() >= 2);

		cleanFrequencies();
		for (ItemSet freq : frequencies.get(frequencies.size()-1)) {
			System.out.println(freq);
		}
		
		/*ArrayList<ItemSet> rs = createReresentativeSet();

		for (ItemSet r : rs) {
		 System.out.println(r);
		 }
		createRules(rs);
		
		 for (Rule r : rules) {
		 System.out.println();
		 System.out.println(r.getInput() + " - " + r.getOutput() + " -> " + r.getConfidence());
		 }
		 System.out.println(rules.size());*/
	}

	private static void loadFile(File file) throws IOException {
		try (BufferedReader br = new BufferedReader(new FileReader(file))) {
			String line;

			HashMap<String, ItemSet> frequency = new HashMap<>();
			Transaction transaction;
			while ((line = br.readLine()) != null) {
				Scanner inLine = new Scanner(line).useDelimiter("\t");
				String token = inLine.next();
				transaction = new Transaction(Integer.parseInt(token));
				while (inLine.hasNext()) {
					token = inLine.next().toLowerCase();
					if (!frequency.containsKey(token)) {
						frequency.put(token, new ItemSet(new String[]{token}));
					}
					frequency.get(token).incFrequency();
					transaction.addTag(token);
				}
				transactions.add(transaction);
			}

			nbTransactions = transactions.size();
			frequencies.add(new ArrayList<>(frequency.values()));
			prune(frequencies.get(0));
		}
	}

	private static void prune(ArrayList<ItemSet> frequency) {
		Iterator it = frequency.iterator();
		while (it.hasNext()) {
			ItemSet is = (ItemSet) it.next();
			if (is.getFrequency() < minSupport) {
				it.remove();
			}
		}
	}

	private static void join(ArrayList<ItemSet> frequency, ArrayList<ItemSet> taboos) {
		ItemSet first;
		ItemSet second;

		ArrayList<ItemSet> tempFreq = new ArrayList<>();
		ArrayList<ItemSet> tempTab = new ArrayList<>();

		for (int i = 0; i < frequency.size() - 1; i++) {
			first = frequency.get(i);
			for (int j = i + 1; j < frequency.size(); j++) {
				second = frequency.get(j);
				ItemSet concat = concatUnique(first, second);
				if (concat != null) {
					Integer value = checkUnique(concat, tempFreq, taboos);
					if (value != null) {
						concat.setFrequency(value);
						if (value >= minSupport) {
							tempFreq.add(concat);
						} else {
							tempTab.add(concat);
						}
					}
				}
			}
		}

		APriori.frequencies.add(tempFreq);
		APriori.taboos.add(tempTab);
	}

	private static ItemSet concatUnique(ItemSet first, ItemSet second) {

		ItemSet concat = new ItemSet();
		concat.addTags(second.getTags());
		first.getTags().stream().filter((tag) -> (!second.hasTag(tag))).forEach((tag) -> {
			concat.addTag(tag);
		});

		if (concat.getTagCount() == first.getTagCount() + 1) {
			concat.addSubIS(first);
			concat.addSubIS(second);
			return concat;
		}

		return null;
	}

	private static Integer checkUnique(ItemSet concat, ArrayList<ItemSet> freq, ArrayList<ItemSet> taboos) {
		for (ItemSet taboo : taboos) {
			if (concat.getTags().containsAll(taboo.getTags())) {
				return null;
			}
		}

		for (ItemSet taboo : freq) {
			if (concat.getTags().equals(taboo.getTags())) {
				taboo.addSubIS(concat.getSubIS());
				return null;
			}
		}

		Integer counter = 0;

		counter = transactions.stream().filter((transaction) -> (transaction.getTags().containsAll(concat.getTags()))).map((_item) -> 1).reduce(counter, Integer::sum);
		return counter;
	}

	private static void cleanFrequencies() {
		ListIterator<ArrayList<ItemSet>> li = frequencies.listIterator();
		ArrayList<ItemSet> al;
		while (li.hasNext()) {
			al = li.next();
			if (al.isEmpty()) {
				li.remove();
			}
		}
		frequencies.remove(0);
	}

	public static ArrayList<ItemSet> createReresentativeSet() {
		ArrayList<ItemSet> frequentIS = new ArrayList<>(frequencies.get(frequencies.size() - 1));
		
		for (ItemSet frequentIS1 : frequentIS) {
			frequentIS1.trimSubsets(frequencies);
		}
		
		for (ArrayList<ItemSet> frequency : frequencies) {
			frequentIS.addAll(frequency);
		}
		return frequentIS;
	}

	public static Double computeConfidence(Integer elmtFreq, Integer rsFreq) {
		return (double) rsFreq / (double) elmtFreq;
	}
}
