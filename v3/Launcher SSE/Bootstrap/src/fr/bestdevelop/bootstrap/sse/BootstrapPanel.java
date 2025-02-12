package fr.bestdevelop.bootstrap.sse;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JProgressBar;

public class BootstrapPanel extends JPanel {
	
	private JProgressBar progressBar = new JProgressBar();
	private JButton cancelButton;
	private JLabel progressText = new JLabel();
	private JLabel downloadingText = new JLabel();
	
	public BootstrapPanel() {
		this.setLayout(null);
		setupPanelComponent();
	}
	
	private void setupPanelComponent() {
		progressText.setText("Connecting to the server...");
		progressText.setBounds(14, 10, 350, 30);
		this.add(progressText);
		
		progressBar.setBounds(14, 40, 350, 30);
		progressBar.setMaximum(100);
		progressBar.setValue(0);
		progressBar.setIndeterminate(true);
		this.add(progressBar);
		
		cancelButton = new JButton("Cancel");
		cancelButton.setBounds(284, 78, 80, 26);
		this.add(cancelButton);
		cancelButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				System.exit(0);
				return;
			}
		});
		
		downloadingText.setText("");
		downloadingText.setBounds(14, 78, 250, 30);
		this.add(downloadingText);
		
		Bootstrap.startUpdate();
	}
	
	public JProgressBar getProgressBar() {
		return progressBar;
	}
	
	public JLabel getProgressText() {
		return progressText;
	}
	
	public JLabel getDownloadingText() {
		return downloadingText;
	}
}
