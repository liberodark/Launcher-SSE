package fr.bestdevelop.bootstrap.sse;

import java.io.File;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.swing.JOptionPane;

import fr.bestdevelop.ml.logger.LoggerLib;
import fr.bestdevelop.ml.update.PlayStatus;
import fr.bestdevelop.ml.update.UpdateLib;
import fr.bestdevelop.bootstrap.sse.utils.OperatingSystem;
import fr.bestdevelop.bootstrap.sse.utils.Utils;

public class Bootstrap {
	public static final LoggerLib logger = new LoggerLib(Constants.BOOTSTRAP_NAME);
	
	private static Thread updateThread;
	
	public void start(String[] args) {
		logger.info(Constants.BOOTSTRAP_NAME + " started on " + OperatingSystem.getCurrentPlatform().getName() + "...");
		logger.info("Current time is " + DateFormat.getDateTimeInstance(2, 2, Locale.US).format(new Date()));
		if (!OperatingSystem.getCurrentPlatform().isSupported()) {
			logger.warning("This operating system is unknown or unsupported, we cannot guarantee that the game will launch successfully.");
		}
		
		logger.info("System.getProperty('os.name') == '" + System.getProperty("os.name") + "'");
		logger.info("System.getProperty('os.version') == '" + System.getProperty("os.version") + "'");
		logger.info("System.getProperty('os.arch') == '" + System.getProperty("os.arch") + "'");
		logger.info("System.getProperty('java.version') == '" + System.getProperty("java.version") + "'");
		logger.info("System.getProperty('java.vendor') == '" + System.getProperty("java.vendor") + "'");
		logger.info("System.getProperty('sun.arch.data.model') == '" + System.getProperty("sun.arch.data.model") + "'");
		
		if(Utils.getJavaProcess()) {
			logger.warning("You use Java 32-bits when you have a 64 bits processor.");
		}
	}
	
	public static void startUpdate() {
		Thread thread = new Thread() {
			public void run() {
				logger.sleep(2000L);
				
				int i = 0;
				do {
					i++;
					try {
						update();
					}
					catch (Exception ex) {
						Main.getInstance().getBootstrapPanel().getProgressText().setText("Connecting to the server (" + i + "/2)...");
						if(i == 2) {
							JOptionPane.showMessageDialog(Main.getInstance(), "Impossible de se connecter au serveur ! \n Cela peut etre li� � un probl�me de connection Internet ou � un \n probl�me au niveau du r�seau de @Bestdevelop.", Constants.BOOTSTRAP_NAME, JOptionPane.ERROR_MESSAGE);
							System.exit(0);
							return;
						}
						logger.sleep(5000l);
					}
					
				} while(!(UpdateLib.getNumberOfFileToDownload() == 0) || i < 2); // while(!(UpdateLib.getNumberOfFileToDownload() == 0) || !(i == 5))
				
				logger.info("Starting " + "Launcher.jar");
				try {
					launch(new File("/Launcher.jar"));
				} 
				catch (Exception ex) {
					JOptionPane.showMessageDialog(Main.getInstance(), ex, Constants.BOOTSTRAP_NAME, 0);
				}
				
				logger.sleep(2000L);
				System.exit(0);
			}
		};
		thread.start();
	}
	
	public static void update() throws Exception {
		UpdateLib updateLib = new UpdateLib("http://bestdevelop.esy.es/Bestdevelop/Projects/Rust-MCVC/Launcher/bootstrap/", "http://bestdevelop.esy.es/Bestdevelop/Projects/Rust-MCVC/Launcher/config/bootstrap/ignore.init", new File(""));
		
		updateThread = new Thread() {
			public void run() {
				while(!this.isInterrupted()) {
					if(PlayStatus.getPlayStatus() == PlayStatus.LOADING) {
						Main.getInstance().getBootstrapPanel().getProgressText().setText("Please wait...");
						Main.getInstance().getBootstrapPanel().getDownloadingText().setText("");
						Main.getInstance().getBootstrapPanel().getProgressBar().setValue(0);
						Main.getInstance().getBootstrapPanel().getProgressBar().setIndeterminate(true);
					}
					if(PlayStatus.getPlayStatus() == PlayStatus.CHECKING) {
						Main.getInstance().getBootstrapPanel().getProgressText().setText("Listing the files (" + UpdateLib.getNumberOfFileServer() + " files)...");
						Main.getInstance().getBootstrapPanel().getDownloadingText().setText("");
						Main.getInstance().getBootstrapPanel().getProgressBar().setValue(0);
						Main.getInstance().getBootstrapPanel().getProgressBar().setIndeterminate(true);
					}
					if(PlayStatus.getPlayStatus() == PlayStatus.DELETING) {
						Main.getInstance().getBootstrapPanel().getProgressText().setText("Deleting the unknown files...");
						Main.getInstance().getBootstrapPanel().getDownloadingText().setText("");
						Main.getInstance().getBootstrapPanel().getProgressBar().setValue(UpdateLib.getDeletingProgress());
						Main.getInstance().getBootstrapPanel().getProgressBar().setIndeterminate(false);
					}
					if(PlayStatus.getPlayStatus() == PlayStatus.CAN_PLAY) {
						Main.getInstance().getBootstrapPanel().getProgressText().setText("Please wait...");
						Main.getInstance().getBootstrapPanel().getDownloadingText().setText("");
						Main.getInstance().getBootstrapPanel().getProgressBar().setValue(0);
						Main.getInstance().getBootstrapPanel().getProgressBar().setIndeterminate(true);
					}
					if(PlayStatus.getPlayStatus() == PlayStatus.DOWNLOADING) {
						Main.getInstance().getBootstrapPanel().getProgressText().setText("Downloading " + UpdateLib.getNameOfFileToDownload());
						Main.getInstance().getBootstrapPanel().getDownloadingText().setText((long) (UpdateLib.getNumberOfTotalDownloadedBytes() / (1024 * 1024)) + " / " + (long) (UpdateLib.getNumberOfTotalBytesToDownload() / (1024 * 1024)) + " MB");
						Main.getInstance().getBootstrapPanel().getProgressBar().setValue(UpdateLib.getDownloadingProgress());
						Main.getInstance().getBootstrapPanel().getProgressBar().setIndeterminate(false);
					}
				}
			}
		};
		updateThread.start();
    	updateLib.start();
		updateThread.interrupt();
	}
	
	public static void interruptUpdateThread() {
		updateThread.interrupt();
	}
	
	private static void launch(File jarFile) throws Exception {
		List<String> javaArgs = new ArrayList();
        if (OperatingSystem.getCurrentPlatform() == OperatingSystem.WINDOWS) {
        	javaArgs.add("javaw");
        	javaArgs.add("-Xmx128m");
        }
        else {
        	javaArgs.add("java");
        }
        javaArgs.add("-Xmx128m");
        javaArgs.add("-Dsun.java2d.noddraw=true");
        javaArgs.add("-Dsun.java2d.d3d=false");
        javaArgs.add("-Dsun.java2d.opengl=false");
        javaArgs.add("-Dsun.java2d.pmoffscreen=false");
        javaArgs.add("-jar");
        javaArgs.add(jarFile.getPath());
        
        ProcessBuilder processBuilder = new ProcessBuilder(javaArgs);
        Process process = processBuilder.start();
        if (process == null) {
            throw new Exception("Unable to launch " + jarFile.getName());
        }
	}
}
