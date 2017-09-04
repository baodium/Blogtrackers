/**
 * 
 */
package blogtracker.gui.blogtrackers;

/**
 * @author msaadghouri
 *
 */
public class TrackerModel {
	int trackerID;
	String userID;
	String trackerName;
	String dateCreated;
	String dateModified;
	String sqlQuery;
	String trackerDescription;
	int blogsitesNumber;

	public TrackerModel() {
	}

	public int getTrackerID() {
		return trackerID;
	}

	public void setTrackerID(int trackerID) {
		this.trackerID = trackerID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getTrackerName() {
		return trackerName;
	}

	public void setTrackerName(String trackerName) {
		this.trackerName = trackerName;
	}

	public String getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}

	public String getDateModified() {
		return dateModified;
	}

	public void setDateModified(String dateModified) {
		this.dateModified = dateModified;
	}

	public String getSqlQuery() {
		return sqlQuery;
	}

	public void setSqlQuery(String sqlQuery) {
		this.sqlQuery = sqlQuery;
	}

	public String getTrackerDescription() {
		return trackerDescription;
	}

	public void setTrackerDescription(String trackerDescription) {
		this.trackerDescription = trackerDescription;
	}

	public int getBlogsitesNumber() {
		return blogsitesNumber;
	}

	public void setBlogsitesNumber(int blogsitesNumber) {
		this.blogsitesNumber = blogsitesNumber;
	}

	/**
	 * @param trackerID
	 * @param userID
	 * @param trackerName
	 * @param dateCreated
	 * @param dateModified
	 * @param sqlQuery
	 * @param trackerDescription
	 * @param blogsitesNumber
	 */
	public TrackerModel(int trackerID, String userID, String trackerName, String dateCreated, String dateModified,
			String sqlQuery, String trackerDescription, int blogsitesNumber) {
		super();
		this.trackerID = trackerID;
		this.userID = userID;
		this.trackerName = trackerName;
		this.dateCreated = dateCreated;
		this.dateModified = dateModified;
		this.sqlQuery = sqlQuery;
		this.trackerDescription = trackerDescription;
		this.blogsitesNumber = blogsitesNumber;
	}

	/**
	 * @param userID
	 * @param trackerName
	 * @param dateCreated
	 * @param dateModified
	 * @param sqlQuery
	 * @param trackerDescription
	 * @param blogsitesNumber
	 */
	public TrackerModel(String userID, String trackerName, String dateCreated, String dateModified, String sqlQuery,
			String trackerDescription, int blogsitesNumber) {
		super();
		this.userID = userID;
		this.trackerName = trackerName;
		this.dateCreated = dateCreated;
		this.dateModified = dateModified;
		this.sqlQuery = sqlQuery;
		this.trackerDescription = trackerDescription;
		this.blogsitesNumber = blogsitesNumber;
	}

}
