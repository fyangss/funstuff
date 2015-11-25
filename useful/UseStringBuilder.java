/**
 * Someone asked why.
 */
public class UseStringBuilder {
    public static void main(String[] args) {
        int numLoops = 100000;

        // not a good way to 'benchmark', good enough here though
        long startTime = System.currentTimeMillis();
        String str = "";
        for (int i = 0; i < numLoops; ++i) {
            str += "0";
        }
        System.out.println(System.currentTimeMillis() - startTime);

        startTime = System.currentTimeMillis();
        // buffer for sync, again, doesn't matter here (well, *not* using it matters here)
        StringBuilder strBuilder = new StringBuilder();
        for (int i = 0; i < numLoops; ++i) {
            strBuilder.append("0");
        }
        System.out.println(System.currentTimeMillis() - startTime);
    }
}
