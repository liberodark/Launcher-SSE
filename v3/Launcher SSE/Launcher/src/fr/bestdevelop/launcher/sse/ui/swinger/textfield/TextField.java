package fr.bestdevelop.launcher.sse.ui.swinger.textfield;

import java.awt.Color;
import java.awt.Graphics;
import javax.swing.BorderFactory;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.PlainDocument;

public final class TextField extends JTextField {
	private Color backColor = new Color(0.0F, 0.0F, 0.0F, 0.0F);
    private Color borderColor = new Color(120, 120, 120);

    public TextField(String string, int parami) {
        super(16);
        this.setBackground(new Color(129, 129, 129));
        this.setForeground(new Color(255, 255, 255));
        this.setCaretColor(new Color(129, 129, 129));
        this.setSelectionColor(new Color(243, 102, 57));
        this.setDocument(new JTextFieldLimit(parami));
        this.setText(string);
        this.setOpaque(false);
        this.setBorder(BorderFactory.createCompoundBorder(this.getBorder(), BorderFactory.createEmptyBorder(2, 6, 2, 6)));
    }

	public final void DocumentJ() {
        this.getDocument().addDocumentListener(new DocumentJ(this));
    }

    public final void TextAllow() {
        if (!this.getText().matches("[a-zA-Z0-9_]{0,16}")) {
            SwingUtilities.invokeLater(new TextAllow(this));
        }
    }

    protected final void paintComponent(Graphics graphics) {
        graphics.fillRect(0, 0, this.getWidth() - 1, this.getHeight() - 1);
        super.paintComponent(graphics);
    }

    protected final void paintBorder(Graphics graphics) {
        graphics.setColor(this.borderColor);
        graphics.drawRect(0, 0, this.getWidth() - 1, this.getHeight() - 1);
    }

    public final boolean isOpaque() {
        return true;
    }
    
	class JTextFieldLimit extends PlainDocument {
    	private int limit;
    	JTextFieldLimit(int limit) {
    	    super();
    	    this.limit = limit;
    	}

    	JTextFieldLimit(int limit, boolean upper) {
    	    super();
    	    this.limit = limit;
    	}

    	public void insertString(int offset, String str, AttributeSet attr) throws BadLocationException {
    	    if (str == null) {
    	    	return;
    	    }

    	    if ((getLength() + str.length()) <= limit) {
    	        super.insertString(offset, str, attr);
    	    }
    	}
    }
}