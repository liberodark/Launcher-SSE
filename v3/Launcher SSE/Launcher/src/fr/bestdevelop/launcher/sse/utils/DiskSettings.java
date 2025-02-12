package fr.bestdevelop.launcher.sse.utils;

import java.io.File;

import com.google.gson.Gson;

import fr.bestdevelop.launcher.sse.Launcher;
import fr.bestdevelop.ml.swinger.exceptions.FailException;
import fr.bestdevelop.ml.swinger.utils.FileUtils;

public class DiskSettings {	
	
	private static Launcher launcher;
	
	private static final Gson gson = new Gson();
	private static File file;
	
	public String pseudo = "";
	public String language = "";
	public String appid1 = "";
	public String appid2 = "";
	public String steamID = "";
	
	public DiskSettings(File file) {
		DiskSettings.file = file;
		if (file.exists()) {
			DiskSettings.load();
		}
	}
	
	public void save() {
		try {
			FileUtils.writeStringToFile(DiskSettings.file, gson.toJson(this));
		} 
		catch (Exception ex) {
			launcher.logger.warning("Failed to save " + file.getName(), ex);
			throw new FailException("Failed to save " + file.getName(), ex);
		}
	}
	
	public static DiskSettings load() {
		File file = DiskSettings.file;
		DiskSettings settings = null;

		try {
			if (file.exists()) {
				settings = gson.fromJson(FileUtils.readFileToString(file), DiskSettings.class);
			}
		} 
		catch (Exception ex) {
			ex.printStackTrace();
		}
		
		if (settings == null) {
			settings = new DiskSettings(DiskSettings.file);
		}
		
		return settings;
	}
}
