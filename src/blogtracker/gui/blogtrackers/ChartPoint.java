/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

/**
 *
 * @author skumar34
 */
public class ChartPoint
{
    public String interval;
    int noofposts0;
    int noofposts1;
    int noofposts2;
    int noofposts3;
	double avg;

    public ChartPoint()
    {
        
    }

    public ChartPoint(String interval) {
        this.interval = interval;
    }

    public String getInterval() {
        return interval;
    }

    public double getAvg() {
        return avg;
    }

    public void setAvg(double avg) {
        this.avg = avg;
    }

    public void setInterval(String interval) {
        this.interval = interval;
    }

    public int getNoofposts0() {
        return noofposts0;
    }

    public void setNoofposts0(int noofposts0) {
        this.noofposts0 = noofposts0;
    }

    public int getNoofposts1() {
        return noofposts1;
    }

    public void setNoofposts1(int noofposts1) {
        this.noofposts1 = noofposts1;
    }

    public int getNoofposts2() {
        return noofposts2;
    }

    public void setNoofposts2(int noofposts2) {
        this.noofposts2 = noofposts2;
    }
    
    public int getNoofposts3() {
		return noofposts3;
	}
    
	public void setNoofposts3(int noofposts3) {
		this.noofposts3 = noofposts3;
	}

}
