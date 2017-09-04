/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.util;

/**
 *
 * @author skumar34
 */
public class UserLocation
{
    public String username;
    public String location;
    public double latitude;
    public double longitude;
    public String tweet;
    public boolean geoflag;

    public boolean isGeoflag() {
        return geoflag;
    }

    public void setGeoflag(boolean geoflag) {
        this.geoflag = geoflag;
    }

    public String getTweet() {
        return tweet;
    }

    public void setTweet(String tweet) {
        this.tweet = tweet;
    }

    public UserLocation()
    {
        
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    //String tweet;
}
