package fr.bestdevelop.bootstrap.sse;

import javax.swing.JFrame;
import javax.swing.WindowConstants;

import fr.bestdevelop.bootstrap.sse.utils.Utils;

public class BootstrapFrame extends JFrame {
	
	public BootstrapPanel bootstrapPanel;
	
	public BootstrapFrame() {
		this.setTitle(Constants.BOOTSTRAP_NAME);
		this.setSize(383, 143);
		this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
		this.setLocationRelativeTo(null);
		this.setUndecorated(false);
		this.setResizable(false);
		this.setIconImage(Utils.getResource("favicon.png"));
		this.setContentPane(bootstrapPanel = new BootstrapPanel());
		
		this.setVisible(true);
	}
	
	public BootstrapPanel getBootstrapPanel() {
		return bootstrapPanel;
	}
}
