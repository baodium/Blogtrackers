/**
 * 
 */
package blogtracker.gui.blogtrackers;

/**
 * @author msaadghouri
 *
 */
public class BeanTopEntities {
	String entityName;
	String entityType;
	int entityFrequency;
	float posSentiment;
	float negSentiment;
	/**
	 * 
	 */
	public BeanTopEntities() {
		// TODO Auto-generated constructor stub
	}
	//	/**
	//	 * @param entityName
	//	 * @param entityType
	//	 * @param entityFrequency
	//	 */
	//	public BeanTopEntities(String entityName, String entityType, int entityFrequency) {
	//		super();
	//		this.entityName = entityName;
	//		this.entityType = entityType;
	//		this.entityFrequency = entityFrequency;
	//	}
	/**
	 * @param entityName
	 * @param entityType
	 * @param entityFrequency
	 * @param posSentiment
	 * @param negSentiment
	 */
	public BeanTopEntities(String entityName, String entityType, int entityFrequency, float posSentiment, float negSentiment) {
		super();
		this.entityName = entityName;
		this.entityType = entityType;
		this.entityFrequency = entityFrequency;
		this.posSentiment = posSentiment;
		this.negSentiment = negSentiment;
	}

	public String getEntityName() {
		return entityName;
	}
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	public String getEntityType() {
		return entityType;
	}
	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}
	public int getEntityFrequency() {
		return entityFrequency;
	}
	public void setEntityFrequency(int entityFrequency) {
		this.entityFrequency = entityFrequency;
	}
	public float getPosSentiment() {
		return posSentiment;
	}
	public void setPosSentiment(float posSentiment) {
		this.posSentiment = posSentiment;
	}
	public float getNegSentiment() {
		return negSentiment;
	}
	public void setNegSentiment(float negSentiment) {
		this.negSentiment = negSentiment;
	}

}
