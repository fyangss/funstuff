/**
 * Someone asked why.
 */
public class UseStringBuilder {
    private final static int NUM_LOOPS = 100000;
    public static void main(String[] args) {
        // not a good way to 'benchmark' in general, good enough here
        long startTime = System.currentTimeMillis();
        String str = "";
        for (int i = 0; i < NUM_LOOPS; ++i) {
            str += "0";
        }
        System.out.println(System.currentTimeMillis() - startTime);

        startTime = System.currentTimeMillis();
        // buffer for sync, again, doesn't matter here (well, *not* using it matters here)
        StringBuilder strBuilder = new StringBuilder();
        for (int i = 0; i < NUM_LOOPS; ++i) {
            strBuilder.append("0");
        }
        System.out.println(System.currentTimeMillis() - startTime);
    }
}
