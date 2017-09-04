/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

/**
 *
 * @author skumar34
 */
public class BPost {

    long blogpostID;
    String title;
    String date;
    String blogger;

    /**
     *
     * @param blogpostID
     * @param title
     * @param date
     * @param blogger
     */
    public BPost(long blogpostID, String title,String date,String blogger) {
        this.blogpostID = blogpostID;
        this.title = title;
        this.date = date;
        this.blogger = blogger;
    }

    /**
     *
     * @return
     */
    public String getBlogger() {
        return blogger;
    }

    /**
     *
     * @param blogger
     */
    public void setBlogger(String blogger) {
        this.blogger = blogger;
    }

    /**
     *
     * @return
     */
    public String getDate() {
        return date;
    }

    /**
     *
     * @param date
     */
    public void setDate(String date) {
        this.date = date;
    }

    public long getBlogpostID() {
        return blogpostID;
    }

    public void setBlogpostID(long blogpostID) {
        this.blogpostID = blogpostID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

}
