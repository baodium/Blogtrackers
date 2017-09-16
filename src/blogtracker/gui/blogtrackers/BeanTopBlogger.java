/**
 * 
 */
package blogtracker.gui.blogtrackers;

/**
 * @author msaadghouri
 *
 */
public class BeanTopBlogger {
	String bloggerName;
	int blogCount;

	/**
	 * 
	 */
	public BeanTopBlogger() {
		super();
	}

	/**
	 * @param bloggerName
	 * @param blogCount
	 */
	public BeanTopBlogger(String bloggerName, int blogCount) {
		super();
		this.bloggerName = bloggerName;
		this.blogCount = blogCount;
	}

	public String getBloggerName() {
		return bloggerName;
	}
	public void setBloggerName(String bloggerName) {
		this.bloggerName = bloggerName;
	}
	public int getBlogCount() {
		return blogCount;
	}
	public void setBlogCount(int blogCount) {
		this.blogCount = blogCount;
	}

}
