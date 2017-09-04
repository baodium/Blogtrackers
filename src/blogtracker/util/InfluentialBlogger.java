package blogtracker.util;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Shamanth
 */
public class InfluentialBlogger implements Comparable {

	private String bloggerName;
	private String blogName;
	private int blogSiteID;
	private float influenceScore;

	public InfluentialBlogger()
	{

	}
	public InfluentialBlogger(String ibloggerName,int iblogSiteID,float iinfluenceScore)
	{
		this.bloggerName=ibloggerName;
		this.influenceScore=iinfluenceScore;
		this.blogSiteID=iblogSiteID;
	}

	public InfluentialBlogger(String ibloggerName,String iblogName, float iinfluenceScore)
	{
		this.bloggerName=ibloggerName;
		this.influenceScore=iinfluenceScore;
		this.blogName=iblogName;
	}


	public int compareTo(Object obj)
	{
		InfluentialBlogger tempBlogger=new InfluentialBlogger();
		tempBlogger=(InfluentialBlogger)obj;
		if(this.influenceScore>tempBlogger.influenceScore)
			return 1;
		if(this.influenceScore<tempBlogger.influenceScore)
			return -1;
		else
			return 0;
	}

	public float getInfluenceScore()
	{
		return this.influenceScore;
	}
	public String getBloggerName()
	{
		return this.bloggerName;
	}
	public void setInfluenceScore(float iInfluenceScore)
	{
		this.influenceScore=iInfluenceScore;

	}
	public void setbloggerName(String iBloggerName)
	{
		this.bloggerName=iBloggerName;
	}

	public String getBlogName() {
		return blogName;
	}
	public void setBlogName(String blogName) {
		this.blogName = blogName;
	}
	public int getBlogSiteID() {
		return blogSiteID;
	}
	public void setBlogSiteID(int blogSiteID) {
		this.blogSiteID = blogSiteID;
	}
	@Override
	public String toString() {
		return "{\"bloggerName\":\"" + bloggerName + "\"," 
				+ " \"influenceScore\":\"" + influenceScore + "\"," 
				+ " \"blogName\":\"" + blogName
				+ "\"}";
	}
}
