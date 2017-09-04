package blogtracker.gui.blogtrackers;

/**
*
* @author Nihal Muhammad
* 
*
*/
public class BlogSites2 extends BlogSites{
	
	int blogSize;

	public int getBlogSize() {
		return blogSize;
	}

	public void setBlogSize(int blogSize) {
		this.blogSize = blogSize;
	}
	
	public BlogSites2(String iblogName, int id, String type, int iblogSize, boolean selflag)
	{
		super(iblogName, id, type, selflag);
		blogSize = iblogSize;
	}

}
