/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

/**
 *
 * @author skumar34
 */
public class BlogSites
{
    String blogsiteName;

    public boolean isSelectedflag() {
        return selectedflag;
    }

    public void setSelectedflag(boolean selectedflag) {
        this.selectedflag = selectedflag;
    }
    int blogsiteID;
    String blogsiteType;
    boolean selectedflag;

    public String getBlogsiteType() {
        return blogsiteType;
    }

    public void setBlogsiteType(String blogsiteType) {
        this.blogsiteType = blogsiteType;
    }

    public BlogSites(String iblogName,int id, String type,boolean selflag)
    {
        blogsiteName= iblogName;
        blogsiteID = id;
        blogsiteType = type;
        selectedflag = selflag;
    }

    public int getBlogsiteID() {
        return blogsiteID;
    }

    public void setBlogsiteID(int blogsiteID) {
        this.blogsiteID = blogsiteID;
    }

    public String getBlogsiteName() {
        return blogsiteName;
    }

    public void setBlogsiteName(String blogsiteName) {
        this.blogsiteName = blogsiteName;
    }

}
