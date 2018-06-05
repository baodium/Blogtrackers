/**
 * 
 */
package blogtracker.gui.blogtrackers;

import java.io.Serializable;

/**
 * @author msaadghouri
 *
 */
public class BeanInfluenceGraph implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	float totalInfluence;
	String startDate;
	/**
	 * 
	 */
	public BeanInfluenceGraph() {
		// TODO Auto-generated constructor stub
	}
	
	public float getTotalInfluence() {
		return totalInfluence;
	}
	public void setTotalInfluence(int totalInfluence) {
		this.totalInfluence = totalInfluence;
	}
	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @param totalInfluence
	 * @param startDate
	 */
	public BeanInfluenceGraph(float totalInfluence,String startDate) {
		this.totalInfluence = totalInfluence;
		this.startDate = startDate;
	}

	@Override
	public String toString() {
		return "{\"totalInfluence\":\"" + totalInfluence + "\"," + " \"startDate\":\"" + startDate + "\"}";
	}

}
