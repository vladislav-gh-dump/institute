import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.ScrollPane;
import javafx.scene.layout.*;
import javafx.stage.Stage;

public class MainWindow extends Application {

    Writer writer;
    Notepad notepad;
    DBConnector dbConnector;

    ScrollPane scrollPane;
    BorderPane root;
    Scene scene;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void init() throws Exception {
        dbConnector = new DBConnector("Note.db");

        super.init();
    }

    @Override
    public void start(Stage stage) {

        writer = new Writer();
        notepad = new Notepad(writer, dbConnector.getArrayListNote());

        scrollPane = new ScrollPane(notepad);
        scrollPane.setFitToWidth(true);
        scrollPane.setFitToHeight(true);
        scrollPane.setHbarPolicy(ScrollPane.ScrollBarPolicy.NEVER);

        root = new BorderPane();
        root.setCenter(scrollPane);
        root.setBottom(writer);

        scene = new Scene(root);

        stage.setScene(scene);
        stage.setHeight(640);
        stage.setWidth(480);
        stage.show();
    }

    @Override
    public void stop() throws Exception {
        dbConnector.closeConnection(notepad.getListNotes());

        super.stop();
    }
}