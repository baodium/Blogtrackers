/**
 * 
 */
package blogtracker.gui.blogtrackers;

/**
 * @author msaadghouri
 *
 */
public class BeanAllSites {
	String siteName;
	int siteID;
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public int getSiteID() {
		return siteID;
	}
	public void setSiteID(int siteID) {
		this.siteID = siteID;
	}
	/**
	 * @param siteName
	 * @param siteID
	 */
	public BeanAllSites(String siteName, int siteID) {
		super();
		this.siteName = siteName;
		this.siteID = siteID;
	}
	@Override
	public String toString() {
		return "{\"siteName\":\"" + siteName + "\"," 
				+ " \"siteID\":\"" + siteID + "\"}";
	}
}
