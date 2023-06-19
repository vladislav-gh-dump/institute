import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Priority;

public class Writer extends HBox {

    TextField fieldNote;
    Button btnAddNote;

    Writer() {
        fieldNote = new TextField();
        HBox.setHgrow(fieldNote, Priority.ALWAYS);
        btnAddNote = new Button("+");

        this.getChildren().addAll(fieldNote, btnAddNote);
        this.setAlignment(Pos.CENTER);
        this.setPadding(new Insets(12));
    }

    public String getSubstringText(int limitLength) {
        String text = fieldNote.getText().strip();

        if (text.length() >= limitLength) {
            text = text.substring(0, limitLength);
        }

        return text;
    }

    public Button getBtnAddNote() { return btnAddNote; }

}
