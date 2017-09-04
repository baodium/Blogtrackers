/**
 * 
 */
package blogtracker.gui.blogtrackers;

/**
 * @author msaadghouri
 *
 */
public class BeanDoughnut {
	int posSentiments;
	int anxSentiments;
	int angSentiments;
	int sadSentiments;
	int year;
	public int getPosSentiments() {
		return posSentiments;
	}
	public void setPosSentiments(int posSentiments) {
		this.posSentiments = posSentiments;
	}

	public int getAnxSentiments() {
		return anxSentiments;
	}
	public void setAnxSentiments(int anxSentiments) {
		this.anxSentiments = anxSentiments;
	}
	public int getAngSentiments() {
		return angSentiments;
	}
	public void setAngSentiments(int angSentiments) {
		this.angSentiments = angSentiments;
	}
	public int getSadSentiments() {
		return sadSentiments;
	}
	public void setSadSentiments(int sadSentiments) {
		this.sadSentiments = sadSentiments;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	/**
	 * 
	 */
	public BeanDoughnut() {
		// TODO Auto-generated constructor stub
	}


	/**
	 * @param posSentiments
	 * @param anxSentiments
	 * @param angSentiments
	 * @param sadSentiments
	 * @param year
	 */
	public BeanDoughnut(int posSentiments, int anxSentiments, int angSentiments, int sadSentiments, int year) {
		super();
		this.posSentiments = posSentiments;
		this.anxSentiments = anxSentiments;
		this.angSentiments = angSentiments;
		this.sadSentiments = sadSentiments;
		this.year = year;
	}
	@Override
	public String toString() {
		return "{\"year\":\"" + year + "\"," 
				+ " \"posSentiments\":\"" + posSentiments + "\","
				+ " \"anxSentiments\":\"" + anxSentiments + "\","
				+ " \"angSentiments\":\"" + angSentiments + "\","
				+ " \"sadSentiments\":\"" + sadSentiments + "\"}";
	}
}
