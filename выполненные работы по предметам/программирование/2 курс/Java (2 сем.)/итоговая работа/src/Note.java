import javafx.geometry.HPos;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.geometry.VPos;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.*;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class Note extends GridPane {

    final int COUNTROWS = 3;
    final int COUNTCOLUMNS = 4;

    int id;
    String text;
    int statusIndex;
    String[] listStatus;

    Label lblTextNote;
    Label lblDateCreated;

    Button btnSetStatus;
    Button btnRemoveNote;

    DateTimeFormatter dateTimeFormatter;
    LocalDateTime dateTimeNow;

    Note(int id, String text, String status) {
        this.id = id;
        this.text = text;

        listStatus = new String[] {status, "TO-DO", "DOING", "DONE"};
        statusIndex = 0;

        dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        dateTimeNow = LocalDateTime.now();

        lblTextNote = new Label(this.text);
        lblTextNote.setMaxWidth(Double.MAX_VALUE);
        lblTextNote.setPadding(new Insets(8, 8, 4, 4));
        lblTextNote.setFont(Font.font("Arial", 12));
        lblTextNote.setBorder(Border.stroke(Color.BLACK));
        GridPane.setMargin(lblTextNote, new Insets(0, 0, 0, 12));

        lblDateCreated = new Label(dateTimeFormatter.format(dateTimeNow));
        lblDateCreated.setFont(Font.font("Arial", 10));
        GridPane.setHalignment(lblDateCreated, HPos.RIGHT);
        GridPane.setValignment(lblDateCreated, VPos.TOP);
        GridPane.setMargin(lblDateCreated, new Insets(4));

        btnSetStatus = new Button(listStatus[statusIndex]);
        GridPane.setMargin(btnSetStatus, new Insets(4, 4, 4, 24));

        btnRemoveNote = new Button("DEL");
        GridPane.setMargin(btnRemoveNote, new Insets(0, 0, 0, 12));



        for (int i = 0; i < COUNTROWS; i++) {
            RowConstraints rowConstraints = new RowConstraints();
            rowConstraints.setPercentHeight(100.0 / COUNTROWS);
            this.getRowConstraints().add(rowConstraints);
        }

        for (int i = 0; i < COUNTCOLUMNS; i++) {
            ColumnConstraints columnConstraints = new ColumnConstraints();
            columnConstraints.setPercentWidth(100.0 / COUNTCOLUMNS);
            this.getColumnConstraints().add(columnConstraints);
        }

        this.add(btnSetStatus,      0, 0, 2, 1);
        this.add(lblTextNote,       0, 1, 3, 1);
        this.add(btnRemoveNote,     3, 1);
        this.add(lblDateCreated,    1, 2, 2, 1);

        this.setAlignment(Pos.CENTER);
        /*this.setGridLinesVisible(true);*/

        /*
        *        0        1       2         3
        *    -------------------------------------
        *  0 | button          |        |        |
        *    -------------------------------------
        *  1 | label                    | button |
        *    -------------------------------------
        *  2 |        | label           |        |
        *    -------------------------------------
        */
    }

    public int getCurrentId() { return id; }
    public void setNewId(int id) { this.id = id; }

    public Button getBtnSetStatus() { return btnSetStatus; }
    public void changeStatus() {
        statusIndex += 1;
        if (statusIndex > 3) { statusIndex = 1; } else if (statusIndex <= 1) {
            statusIndex = 1;
        }
        btnSetStatus.setText(listStatus[statusIndex]);
    }

    public Button getBtnRemoveNote() { return btnRemoveNote; }


    public String getText() { return lblTextNote.getText(); }
    public String getStatus() { return btnSetStatus.getText(); }

}