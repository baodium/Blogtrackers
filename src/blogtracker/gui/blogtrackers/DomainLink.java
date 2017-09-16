/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

/**
 *
 * @author skumar34
 */
public class DomainLink
{
    public String link;
    public int rank;

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }
    
	/**
	 * 
	 */
	public DomainLink() {
		super();
	}

	/**
	 * @param link
	 * @param rank
	 */
	public DomainLink(String link, int rank) {
		super();
		this.link = link;
		this.rank = rank;
	}

	@Override
	public String toString() {
		return "{\"link\":\"" + link + "\"," 
				+ " \"rank\":\"" + rank + "\"}";
	}
}
