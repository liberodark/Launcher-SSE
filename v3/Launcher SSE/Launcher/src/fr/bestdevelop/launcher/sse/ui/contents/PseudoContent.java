package fr.bestdevelop.launcher.sse.ui.contents;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JLabel;
import javax.swing.JPanel;

import fr.bestdevelop.launcher.sse.utils.Utils;
import fr.bestdevelop.ml.swinger.buttons.textured.STexturedButton;
import fr.bestdevelop.launcher.sse.Main;
import fr.bestdevelop.launcher.sse.ui.swinger.textfield.TextField;
import fr.bestdevelop.launcher.sse.utils.OperatingSystem;

public class PseudoContent extends JPanel {
	
	private STexturedButton pseudoButton;
	private STexturedButton languageButton;
	private STexturedButton optionsButton;
	private STexturedButton saveandrestoreButton;
	private STexturedButton launchgameButton;
	private STexturedButton webButton;
	
	private TextField pseudoField;
	private STexturedButton saveButton;
	private JLabel infoText;
	
	public PseudoContent() {
		this.setLayout(null);
		setupPanelComponent();
	}
	
	private void setupPanelComponent() {
		pseudoButton = new STexturedButton(Utils.getResource("buttons/pseudoButton.png"));
		pseudoButton.setBounds(8, 5, 95, 28);
		this.add(pseudoButton);
		pseudoButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				return;
			}
		});
		
		languageButton = new STexturedButton(Utils.getResource("buttons/languageButton.png"));
		languageButton.setBounds(108, 5, 95, 28);
		this.add(languageButton);
		languageButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				Main.getInstance().setContentPane(Main.getInstance().languageContent = new LanguageContent());
				Main.getInstance().revalidate();
				return;
			}
		});
		
		optionsButton = new STexturedButton(Utils.getResource("buttons/optionsButton.png"));
		optionsButton.setBounds(208, 5, 95, 28);
		this.add(optionsButton);
		optionsButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				Main.getInstance().setContentPane(Main.getInstance().optionsContent = new OptionsContent());
				Main.getInstance().revalidate();
				return;
			}
		});
		
		saveandrestoreButton = new STexturedButton(Utils.getResource("buttons/saveandrestoreButton.png"));
		saveandrestoreButton.setBounds(308, 5, 95, 28);
		this.add(saveandrestoreButton);
		saveandrestoreButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				Main.getInstance().setContentPane(Main.getInstance().saveAndRestoreContent = new SaveAndRestoreContent());
				Main.getInstance().revalidate();
				return;
			}
		});
		
		launchgameButton = new STexturedButton(Utils.getResource("buttons/launchgameButton.png"));
		launchgameButton.setBounds(408, 5, 95, 28);
		this.add(launchgameButton);
		launchgameButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				Main.getInstance().setContentPane(Main.getInstance().launchGameContent = new LaunchGameContent());
				Main.getInstance().revalidate();
				return;
			}
		});
		
		webButton = new STexturedButton(Utils.getResource("buttons/webButton.png"));
		webButton.setBounds(0, 402, 510, 27);
		this.add(webButton);
		webButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				OperatingSystem.openHttpUrl("https://github.com/liberodark/Launcher-SSE/");
				return;
			}
		});
		
		pseudoField = new TextField("", 16);
		pseudoField.setBounds(105, 194, 300, 30);
		pseudoField.setFont(Utils.getFont("OpenSans-Bold.ttf", 16.0F));
		this.add(pseudoField);
		
		infoText = new JLabel("", 0);
		infoText.setBounds(105, 225, 300, 30);
		infoText.setForeground(new Color(243, 102, 57));
		infoText.setFont(Utils.getFont("OpenSans-Bold.ttf", 14.0F));
		this.add(infoText);
		
		saveButton = new STexturedButton(Utils.getResource("buttons/saveButton.png"));
		saveButton.setBounds(208, 255, 95, 28);
		this.add(saveButton);
		saveButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				return;
			}
		});
	}
	
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		
		Image background = Utils.getResource("contents/PseudoContent.jpg");
		g.drawImage(background, 0, 0, this.getWidth(), this.getHeight(), this);
	}
}
