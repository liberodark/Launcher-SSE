package fr.bestdevelop.launcher.sse.ui.swinger.textfield;

import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

import fr.bestdevelop.ml.swinger.textfield.STextField;

public final class DocumentJ implements DocumentListener {
    private TextField sTextField;

    public DocumentJ(TextField sTextField) {
        this.sTextField = sTextField;
    }

    public final void insertUpdate(DocumentEvent documentEvent) {
        this.sTextField.DocumentJ();
    }

    public final void removeUpdate(DocumentEvent documentEvent) {
        this.sTextField.DocumentJ();
    }

    public final void changedUpdate(DocumentEvent documentEvent) {
        this.sTextField.DocumentJ();
    }
}

