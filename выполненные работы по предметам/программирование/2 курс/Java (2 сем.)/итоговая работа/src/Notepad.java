import javafx.scene.control.Button;
import javafx.scene.layout.VBox;

import java.beans.EventHandler;
import java.lang.reflect.Array;
import java.util.*;
import java.util.stream.Collectors;

public class Notepad extends VBox {

    Notepad(Writer writer, ArrayList<Note> listNote) {

        this.addAllNotes(listNote);

        // задать событие добавления записи
        writer.getBtnAddNote().setOnMouseClicked(e -> {
            String textNewNote = writer.getSubstringText(40);
            if (!textNewNote.equals("")) {
                int idNewNote = getCountNotes() + 1;
                this.addNote(new Note(idNewNote, textNewNote, "DEFAULT"));
            }
        });
    }

    private void addAllNotes(ArrayList<Note> listNote) {
        for (Note tmpNote : listNote) {
            addNote(tmpNote);
        }
    }

    private void addNote(Note newNote) {

        // задать событие удаления записи
        newNote.getBtnRemoveNote().setOnMouseClicked(e -> {
            removeNote(newNote.getCurrentId() - 1);
        });

        // задать событие изменения статуса
        newNote.getBtnSetStatus().setOnMouseClicked(e -> {
            newNote.changeStatus();
        });

        // добавление записи
        this.getChildren().add(newNote);
    }

    private void removeNote(int indexRemoveNote) {
        // удаление записи
        this.getChildren().remove(indexRemoveNote);

        // обновление идентификаторов записей начиная с индекса удаленной записи
        if (getCountNotes() != 0) {
            updateIndexes(indexRemoveNote);
        }
    }

    private void updateIndexes(int startIndex) {
        // обновление идентификаторов записей
        for (int i = startIndex; i < getCountNotes(); i++) {
            Note tmpNote = (Note) this.getChildren().get(i);
            tmpNote.setNewId(i + 1);
        }
    }

    private int getCountNotes() { return this.getChildren().size(); }

    public ArrayList<Note> getListNotes() {
        ArrayList<Note> listNote = new ArrayList<>();

        for (int i = 0; i < getCountNotes(); i++) {
            Note tmpNote = (Note) this.getChildren().get(i);
            listNote.add(tmpNote);

            System.out.println("getListNotes(): " + i);
        }

        return listNote;
    }
}
