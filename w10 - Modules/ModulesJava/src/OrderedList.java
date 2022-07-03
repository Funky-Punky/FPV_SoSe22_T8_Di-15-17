

class List<Entry> {
    List<Entry> next;
    Entry entry;
}


interface Collection<Entry> {
    List<Entry> createEmpty();

    List<Entry> add(Entry entry, List<Entry> collection);

    Boolean contains(Entry entry, List<Entry> collection);

    int size(List<Entry> collection);
}

interface Comparable<T> {
    int compare(T o1, T o2);
}

class ComparingCollection<Entry extends Comparable> implements Collection<Entry> {

    @Override
    public List<Entry> createEmpty() {
        return null;
    }

    @Override
    public List<Entry> add(Entry entry, List<Entry> collection) {
        if (collection == null) {
            List<Entry> list = new List<>();
            list.entry = entry;
            return list;
        } else {
            if (entry.compare(entry, collection.entry) < 0) {
                List<Entry> list = new List<>();
                list.entry = entry;
                list.next = collection;
                return list;
            } else {
                collection.next = add(entry, collection.next);
                return collection;
            }
        }
    }

    @Override
    public Boolean contains(Entry entry, List<Entry> collection) {
        while (collection != null) {
            if (entry == collection.entry) {
                return true;
            }
            collection = collection.next;
        }
        return false;
    }

    @Override
    public int size(List<Entry> collection) {
        int i = 0;
        while (collection != null) {
            i++;
            collection = collection.next;
        }
        return i;
    }
}

class IntComparable implements Comparable<Integer> {
    @Override
    public int compare(Integer o1, Integer o2) {
        return Integer.compare(o1, o2);
    }
}

public class OrderedList {
    public static void main(String[] args) {
        ComparingCollection<IntComparable> IntCollection = new ComparingCollection<IntComparable>();
    }
}
