package blogtracker.gui.blogtrackers;

import java.io.Serializable;

public class BeanBloggerDetails implements Serializable {
	private static final long serialVersionUID = 1L;
	private String author;
	private String siteName;
	private String siteURL;
	private String lastCleaned;
	private String description;
	private int maxInfluence;
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public String getSiteURL() {
		return siteURL;
	}
	public void setSiteURL(String siteURL) {
		this.siteURL = siteURL;
	}
	public String getLastCleaned() {
		return lastCleaned;
	}
	public void setLastCleaned(String lastCleaned) {
		this.lastCleaned = lastCleaned;
	}
	public int getMaxInfluence() {
		return maxInfluence;
	}
	public void setMaxInfluence(int maxInfluence) {
		this.maxInfluence = maxInfluence;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public BeanBloggerDetails(String author, String siteName, String siteURL, String lastCleaned, String description, int maxInfluence) {
		super();
		this.author = author;
		this.siteName = siteName;
		this.siteURL = siteURL;
		this.lastCleaned = lastCleaned;
		this.description = description;
		this.maxInfluence = maxInfluence;
	}
	@Override
	public String toString() {
		return "{\"author\":\"" + author + "\"," 
				+ " \"siteName\":\"" + siteName + "\","
				+ " \"siteURL\":\"" + siteURL + "\","
				+ " \"lastCleaned\":\"" + lastCleaned + "\","
				+ " \"description\":\"" + description + "\","
				+ " \"maxInfluence\":\"" + maxInfluence + "\"}";
	}
}
