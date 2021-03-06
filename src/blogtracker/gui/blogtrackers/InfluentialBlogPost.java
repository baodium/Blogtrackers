/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

/**
 *
 * @author skumar34
 */
public class InfluentialBlogPost implements Comparable
{
    String blogger;
    int blogpostID;
    String title;
    double influenceScore;
    String postContent;

    public InfluentialBlogPost(String iblogger, int iblogpostID, String ititle, double iinfluenceScore, String ipostContent)
    {
        blogger = iblogger;
        blogpostID = iblogpostID;
        title = ititle;
        influenceScore = iinfluenceScore;
        postContent=ipostContent;
    }

    public InfluentialBlogPost()
    {
        
    }
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBlogger() {
        return blogger;
    }

    public void setBlogger(String blogger) {
        this.blogger = blogger;
    }

    public int getBlogpostID() {
        return blogpostID;
    }

    public void setBlogpostID(int blogpostID) {
        this.blogpostID = blogpostID;
    }

    public double getInfluenceScore() {
        return influenceScore;
    }

    public void setInfluenceScore(double influenceScore) {
        this.influenceScore = influenceScore;
    }
    

    public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}

	public int compareTo(Object obj)
    {
        InfluentialBlogPost tempBlogger=new InfluentialBlogPost();
        tempBlogger=(InfluentialBlogPost)obj;
        if(this.influenceScore>tempBlogger.influenceScore)
            return 1;
        if(this.influenceScore<tempBlogger.influenceScore)
            return -1;
        else
            return 0;
    }

}
