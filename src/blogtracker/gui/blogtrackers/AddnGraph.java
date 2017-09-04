/**
 * 
 */
package blogtracker.gui.blogtrackers;

/**
 * @author msaadghouri
 *
 */
public class AddnGraph {
	String month;
	int postCount;
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getPostCount() {
		return postCount;
	}
	public void setPostCount(int postCount) {
		this.postCount = postCount;
	}
	/**
	 * @param month
	 * @param postCount
	 */
	public AddnGraph(String month, int postCount) {
		super();
		this.month = month;
		this.postCount = postCount;
	}
	/**
	 * 
	 */
	public AddnGraph() {
		super();
	}
	@Override
	public String toString() {
		return "{\"month\":\"" + month + "\"," 
				+ " \"postCount\":\"" + postCount + "\"}";
	}
}

