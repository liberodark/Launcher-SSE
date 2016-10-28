package fr.bestdevelop.bootstrap.sse;

import fr.bestdevelop.ml.swinger.SwingerLib;

public class Main {
	
	private static Bootstrap bootstrap = new Bootstrap();
	
	private static BootstrapFrame frame;
	
	public static void main(String[] args) {
		bootstrap.logger.info("main() called!");
		System.setProperty("java.net.preferIPv4Stack", "true");
	    System.setProperty("java.net.preferIPv6Addresses", "false");
	    SwingerLib.setSystemLookNFeel();
	    
	    bootstrap.start(args);
	    startBootstrap(args);
	}
	
	private static void startBootstrap(String[] args) {
		bootstrap.logger.info("About to create JFrame.");
		frame = new BootstrapFrame();
		bootstrap.logger.info("End of main.");
	}
	
	public static BootstrapFrame getInstance() {
		return frame;
	}
	
}
