/**
 * 
 */
package blogtracker.gui.blogtrackers;

/**
 * @author msaadghouri
 *
 */
public class BeanInfluenceScatter {
	String bloggerName;
	float influenceScore;
	float activityScore;
	/**
	 * 
	 */
	public BeanInfluenceScatter() {
		// TODO Auto-generated constructor stub
	}
	public String getBloggerName() {
		return bloggerName;
	}
	public void setBloggerName(String bloggerName) {
		this.bloggerName = bloggerName;
	}
	public float getInfluenceScore() {
		return influenceScore;
	}
	public void setInfluenceScore(int influenceScore) {
		this.influenceScore = influenceScore;
	}
	public float getActivityScore() {
		return activityScore;
	}
	public void setActivityScore(int activityScore) {
		this.activityScore = activityScore;
	}
	/**
	 * @param bloggerName
	 * @param influenceScore
	 * @param activityScore
	 */
	public BeanInfluenceScatter(String bloggerName, float influenceScore, float activityScore) {
		super();
		this.bloggerName = bloggerName;
		this.influenceScore = influenceScore;
		this.activityScore = activityScore;
	}


	@Override
	public String toString() {
		return "{\"bloggerName\":\"" + bloggerName + "\"," + " \"influenceScore\":\""
				+ influenceScore + "\"," + " \"activityScore\":\"" + activityScore + "\"}";
	}
}
