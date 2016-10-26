package fr.bestdevelop.launcher.sse;

import fr.bestdevelop.launcher.sse.ui.frame.LauncherFrame;
import fr.bestdevelop.launcher.sse.utils.Utils;

public class Main {
	private static Launcher launcher = new Launcher();
	
	private static LauncherFrame frame;
	
	public static void main(String[] args) {
		launcher.logger.info("main() called!");
		System.setProperty("java.net.preferIPv4Stack", "true");
	    System.setProperty("java.net.preferIPv6Addresses", "false");
	    Utils.setSystemLookNFeel();
	    
	    launcher.start(args);
	    startLauncher(args);
	}
	
	private static void startLauncher(String[] args) {
		launcher.logger.info("About to create JFrame.");
		frame = new LauncherFrame();
		launcher.logger.info("End of main.");
	}
	
	public static LauncherFrame getInstance() {
		return frame;
	}
}
