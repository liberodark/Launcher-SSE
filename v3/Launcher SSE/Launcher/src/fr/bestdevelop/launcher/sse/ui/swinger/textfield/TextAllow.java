package fr.bestdevelop.launcher.sse.ui.swinger.textfield;

public final class TextAllow implements Runnable {
    private TextField sTextField;

    public TextAllow(TextField sTextField) {
        this.sTextField = sTextField;
    }

    public final void run() {
        String string = this.sTextField.getText().replaceAll("[^a-zA-Z0-9_]", "");
        this.sTextField.setText(string.substring(0, Math.min(string.length(), 16)));
    }
}