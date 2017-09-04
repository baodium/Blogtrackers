/**
 * 
 */
package blogtracker.gui.blogtrackers;

/**
 * JSONEntities is a entity class for saving JSON Fields.
 * @author Kiran
 */
public class JSONEntities {
	
	String BlogSiteName;
	String Blogger;
	String Title;
	String Post;
	String PostingDate;
	String Comments;
	int PositiveEmotion;
	int NegativeEmotion;
	String Location;
	String Language;
	String Permalink;
	
	public JSONEntities() {
		// TODO Auto-generated constructor stub
	}
	/**
	    * JSONEntities constructor specifying parameters to set and export for JSON
	 */
	public JSONEntities(String BlogSiteName, String Blogger, String Title, String Post, String PostingDate, String Comments, int PositiveEmotion, int NegativeEmotion,String Location, String Language, String Permalink) {
		super();
		this.BlogSiteName = BlogSiteName;
		this.Blogger = Blogger;
		this.Title = Title;
		this.Post = Post;
		this.PostingDate = PostingDate;
		this.Comments = Comments;
		this.PositiveEmotion = PositiveEmotion;
		this.NegativeEmotion = NegativeEmotion;
		this.Location = Location;
		this.Language = Language;
		this.Permalink = Permalink;
	}

	public String getBlogSiteName() {
		return BlogSiteName;
	}

	public void setBlogSiteName(String blogSiteName) {
		BlogSiteName = blogSiteName;
	}

	public String getBlogger() {
		return Blogger;
	}

	public void setBlogger(String blogger) {
		Blogger = blogger;
	}

	public String getTitle() {
		return Title;
	}

	public void setTitle(String title) {
		Title = title;
	}

	public String getPost() {
		return Post;
	}

	public void setPost(String post) {
		Post = post;
	}

	public String getPostingDate() {
		return PostingDate;
	}

	public void setPostingDate(String postingDate) {
		PostingDate = postingDate;
	}

	public String getComments() {
		return Comments;
	}

	public void setComments(String comments) {
		Comments = comments;
	}
	
	public int getPositiveEmotion() {
		return PositiveEmotion;
	}

	public void setPositiveEmotion(int positiveEmotion) {
		PositiveEmotion = positiveEmotion;
	}

	public int getNegativeEmotion() {
		return NegativeEmotion;
	}

	public void setNegativeEmotion(int negativeEmotion) {
		NegativeEmotion = negativeEmotion;
	}

	public String getLocation() {
		return Location;
	}

	public void setLocation(String location) {
		Location = location;
	}

	public String getLanguage() {
		return Language;
	}

	public void setLanguage(String language) {
		Language = language;
	}
	public String getPermalink() {
		return Permalink;
	}

	public void setPermalink(String permalink) {
		Permalink = permalink;
	}
}