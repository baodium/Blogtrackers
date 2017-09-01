/**
 * 
 */
package blogtracker.gui.blogtrackers;

import java.io.Serializable;

/**
 * @author msaadghouri
 *
 */
public class BeanTopKeywords implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String term;
	int frequency;

	/**
	 * 
	 */
	public BeanTopKeywords() {

	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	public int getFrequency() {
		return frequency;
	}
	public void setFrequency(int frequency) {
		this.frequency = frequency;
	}
	/**
	 * @param term
	 * @param frequency
	 */
	public BeanTopKeywords(String term, int frequency) {
		super();
		this.term = term;
		this.frequency = frequency;
	}
	@Override
	public String toString() {
		return "{\"term\":\"" + term + "\"," + " \"frequency\":\"" + frequency + "\"}";
	}

}
