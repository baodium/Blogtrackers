/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.util;

/**
 *
 * @author Shamanth
 */
public class BloggerActivity implements Comparable{
    String bloggerName;
    int BloggerPostCount;
    boolean BloggerClass;
    boolean inflBlogger;

    public boolean getInflBlogger() {
        return inflBlogger;
    }

    public void setInflBlogger(boolean inflBlogger) {
        this.inflBlogger = inflBlogger;
    }

    public void setBloggerClass(boolean BloggerClass) {
        this.BloggerClass = BloggerClass;
    }

    public void setBloggerPostCount(int BloggerPostCount) {
        this.BloggerPostCount = BloggerPostCount;
    }

    public void setBloggerName(String bloggerName) {
        this.bloggerName = bloggerName;
    }
    
    public boolean getBloggerClass() {
        return BloggerClass;
    }

    public int getBloggerPostCount() {
        return BloggerPostCount;
    }

    public String getBloggerName() {
        return bloggerName;
    }
    
    public int compareTo(Object obj) {
        //throw new UnsupportedOperationException("Not supported yet.");
        BloggerActivity tempBlogger=new BloggerActivity();
        tempBlogger=(BloggerActivity)obj;
        if(this.BloggerPostCount>tempBlogger.BloggerPostCount)
            return 1;
        if(this.BloggerPostCount<tempBlogger.BloggerPostCount)
            return -1;
        else
            return 0;
    }

}
