package fr.bestdevelop.bootstrap.sse.utils;

import java.awt.Font;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.URL;

import javax.imageio.ImageIO;

import fr.bestdevelop.bootstrap.sse.Bootstrap;

public class Utils {
	private static Bootstrap bootstrap;
	
	public static Font font;
	
	public static Font getFont(String fontName, float size) {
		setFont(fontName);
		return font.deriveFont(size);
	}
	
	public static void setFont(String fontName) {
		try {
			font = Font.createFont(0, getResourceURL("fonts/" + fontName).openStream());
	    }
	    catch (Exception ex) {
	    	bootstrap.logger.error("Impossible de charger le font :", ex);
	    }
	}
	
	public static String getResourceString(String resources) {
		return Utils.class.getResource("/resources/" + resources).toString();
	}
	
	public static URL getResourceURL(String resources) {
		return Utils.class.getResource("/resources/" + resources);
	}
	
	public static BufferedImage getResource(String resource) {
        try {
            return ImageIO.read(getResourceURL(resource));
        }
        catch (IOException ex) {
        	bootstrap.logger.error("Can't load the given resource (" + getResourceURL(resource)+ ") : ", ex);
            throw new IllegalArgumentException("Can't load the given resource (" + getResourceURL(resource)+ ") : " + ex);
        }
        catch (IllegalArgumentException ex) {
        	bootstrap.logger.error("Can't load the given resource (" + getResourceURL(resource)+ ") : ", ex);
            throw new IllegalArgumentException("Can't load the given resource (" + getResourceURL(resource)+ ") : " + ex);
        }
    }
	
	public static boolean getJavaProcess() {
		boolean bl = "32".equals(System.getProperty("sun.arch.data.model"));
		if (bl) {
			int n2;
			boolean bl2 = System.getenv("PROCESSOR_ARCHITEW6432") != null && System.getenv("PROCESSOR_ARCHITEW6432").equals("AMD64");
			if (!bl2) {
				boolean bl3 = bl2 = System.getenv("PROCESSOR_ARCHITECTURE") != null && System.getenv("PROCESSOR_ARCHITECTURE").equals("AMD64");
				return false;
			}
			if (bl2) {
				return true;
			}
		}
		return bl;
	}
	
}
