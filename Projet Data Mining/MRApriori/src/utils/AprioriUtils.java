package utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.ItemSet;
import model.Transaction;

/*
 * Contains utility methods for Apriori algorithm
 */
public class AprioriUtils {

    /*
     * Returns a transaction object for the input txn record.
     */
    public static Transaction getTransaction(String txnRecord) {
        Transaction transaction;

        String currLine = txnRecord;
        String[] words = currLine.split("[\\t]+");
		
        int currTid = Integer.parseInt(words[0].trim());
        List<String> currItems = new ArrayList<>();
        for (int i = 1; i < words.length; i++) {
            currItems.add(words[i].toLowerCase());
        }

        transaction = new Transaction(currTid, currTid, currItems);

        return transaction;
    }

    /*
     * Determines if an item with the specified frequency has minimum support or not.
     */
    public static boolean hasMinSupport(double minSup, int itemCount) {
		
        int minSupport = (int) ((double) (minSup));

        return (itemCount >= minSupport);
    }

    /*
     * Generates the candidateItemSets of pass K from large itemsets of pass K-1.
     */
    public static List<ItemSet> getCandidateItemsets(List<ItemSet> largeItemSetPrevPass, int itemSetSize) {
        List<ItemSet> candidateItemsets = new ArrayList<>();
        List<String> newItems;
		Map<Integer, List<ItemSet>> largeItemsetMap = getLargeItemsetMap(largeItemSetPrevPass);
		Collections.sort(largeItemSetPrevPass);

        for (int i = 0; i < (largeItemSetPrevPass.size() - 1); i++) {
            for (int j = i + 1; j < largeItemSetPrevPass.size(); j++) {
                List<String> outerItems = largeItemSetPrevPass.get(i).getItems();
                List<String> innerItems = largeItemSetPrevPass.get(j).getItems();

                if ((itemSetSize - 1) > 0) {
                    boolean isMatch = true;
                    for (int k = 0; k < (itemSetSize - 1); k++) {
                        if (!outerItems.get(k).equals(innerItems.get(k))) {
                            isMatch = false;
                            break;
                        }
                    }

                    if (isMatch) {
                        newItems = new ArrayList<>();
                        newItems.addAll(outerItems);
                        newItems.add(innerItems.get(itemSetSize - 1));					

                        ItemSet newItemSet = new ItemSet(newItems, 0);
                        if (prune(largeItemsetMap, newItemSet)) {
                            candidateItemsets.add(newItemSet);
                        }
                    }
                } else {
					if (outerItems.get(0).compareTo(innerItems.get(0)) < 0) {
                        newItems = new ArrayList<>();
                        newItems.add(outerItems.get(0));
                        newItems.add(innerItems.get(0));

                        ItemSet newItemSet = new ItemSet(newItems, 0);

                        candidateItemsets.add(newItemSet);
                    }
                }
            }
        }
        return candidateItemsets;
    }

    /*
     * Generates a map of hashcode and the corresponding itemset. Since multiple entries can
     * have the same hashcode, there would be a list of itemsets for any hashcode.
     */
    public static Map<Integer, List<ItemSet>> getLargeItemsetMap(List<ItemSet> largeItemsets) {
        Map<Integer, List<ItemSet>> largeItemsetMap;
        largeItemsetMap = new HashMap<>();

        List<ItemSet> itemsets;
        for (ItemSet largeItemset : largeItemsets) {
            int hashCode = largeItemset.hashCode();
            if (largeItemsetMap.containsKey(hashCode)) {
                itemsets = largeItemsetMap.get(hashCode);
            } else {
				itemsets = new ArrayList<>();
            }

				itemsets.add(largeItemset);
				largeItemsetMap.put(hashCode, itemsets);
            }

        return largeItemsetMap;
    }

    private static boolean prune(Map<Integer, List<ItemSet>> largeItemsetsMap, ItemSet newItemset) {
        List<ItemSet> subsets = getSubsets(newItemset);

        for (ItemSet s : subsets) {
            boolean contains = false;
            int hashCodeToSearch = s.hashCode();
            if (largeItemsetsMap.containsKey(hashCodeToSearch)) {
                List<ItemSet> candidateItemsets = largeItemsetsMap.get(hashCodeToSearch);
                for (ItemSet itemset : candidateItemsets) {
                    if (itemset.equals(s)) {
                        contains = true;
                        break;
                    }
                }
            }

            if (!contains) {
                return false;
            }
        }

        return true;
    }

    /*
     * Generate all possible k-1 subsets for this itemset (preserves order)
     */
    private static List<ItemSet> getSubsets(ItemSet itemset) {
        List<ItemSet> subsets = new ArrayList<>();

        List<String> items = itemset.getItems();
        for (int i = 0; i < items.size(); i++) {
            List<String> currItems = new ArrayList<>(items);
            currItems.remove(items.size() - 1 - i);
            subsets.add(new ItemSet(currItems, 0));
        }

        return subsets;
    }
}
