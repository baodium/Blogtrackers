/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

/**
 *
 * @author skumar34
 * contains the data points for the FLEX column charts
 */
public class DataPoint
{
	String interval;
	int noofposts;
	int index;
	String endDate;
	String startDate;

	public int getIndex() {
		return index;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public DataPoint(String iperiod, int ivalue, int iindex, String iendDate,String istartDate)
	{
		interval = iperiod;
		noofposts = ivalue;
		index = iindex;
		startDate = istartDate;
		endDate= iendDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getInterval() {
		return interval;
	}

	public void setInterval(String interval) {
		this.interval = interval;
	}

	public int getNoofposts() {
		return noofposts;
	}

	public void setNoofposts(int noofposts) {
		this.noofposts = noofposts;
	}



	@Override
	public String toString() {
		return "{\"interval\":\"" + interval + "\"," + " \"noofposts\":\""
				+ noofposts + "\"," + " \"index\":\"" + index + "\","
				+ " \"endDate\":\"" + endDate + "\","
				+ " \"startDate\":\"" + startDate + "\"}";
	}

}
