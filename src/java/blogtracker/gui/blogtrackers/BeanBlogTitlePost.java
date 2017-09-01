/**
 * 
 */
package blogtracker.gui.blogtrackers;

/**
 * @author msaadghouri
 *
 */
public class BeanBlogTitlePost {
	String blogTitle;
	String blogContent;
	/**
	 * 
	 */
	public BeanBlogTitlePost() {
		// TODO Auto-generated constructor stub
	}
	/**
	 * @param blogTitle
	 * @param blogContent
	 */
	public BeanBlogTitlePost(String blogTitle, String blogContent) {
		super();
		this.blogTitle = blogTitle;
		this.blogContent = blogContent;
	}
	public String getBlogTitle() {
		return blogTitle;
	}
	public void setBlogTitle(String blogTitle) {
		this.blogTitle = blogTitle;
	}
	public String getblogContent() {
		return blogContent;
	}
	public void setblogContent(String blogContent) {
		this.blogContent = blogContent;
	}

}
