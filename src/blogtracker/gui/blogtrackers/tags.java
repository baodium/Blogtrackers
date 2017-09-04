/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

/**
 *
 * @author skumar34
 */
public class tags implements Comparable{
    String key;
    double value;
    double fractionofbloggers;

    public double getFractionofbloggers() {
        return fractionofbloggers;
    }

    public void setFractionofbloggers(double fractionofbloggers) {
        this.fractionofbloggers = fractionofbloggers;
    }

    
    public tags()
    {

    }

    public tags(String key, double value) {
        this.key = key;
        this.value = value;
    }
     public int compareTo(Object obj)
        {
            tags tempObject=new tags();
            tempObject=(tags) obj;
            if(this.value>tempObject.value)
                return 1;
            if(this.value<tempObject.value)
                return -1;
            else
                return 0;
        }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }
}
