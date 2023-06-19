import java.sql.*;

import java.util.*;

public class DBConnector {

    String fileNameDB;

    Connection conn;
    Statement createTable;
    PreparedStatement insertInto;
    ResultSet selectAll;


    String url;

    DBConnector(String fileNameDB) {
        this.fileNameDB = fileNameDB;

        this.url = "jdbc:sqlite:" + this.fileNameDB;
        this.conn = null;

        String checkFileDB = FileController.checkFile(this.fileNameDB);
        if (checkFileDB.equals("created")) {
            fileCreated();
        } else {
            if (checkFileDB.equals("exists")) {
                fileExists();
            }
        }
    }

    private void fileCreated() {
        try {
            connection();
            createTableNote();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private void fileExists() {
        try {
            connection();
            createTable = conn.createStatement();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private void createTableNote() throws SQLException {
        createTable = conn.createStatement();

        String queryCreateTable = """
                CREATE TABLE "note" (
                    "id_note"	INTEGER NOT NULL,
                    "text_note"	TEXT NOT NULL CHECK(length("text_note") <= 100),
                    "status"	TEXT NOT NULL DEFAULT "DEFAULT" CHECK("status" IN ("DEFAULT", "TO-DO", "DOING", "DONE")),
                    PRIMARY KEY("id_note" AUTOINCREMENT)
                );
                """;

        createTable.execute(queryCreateTable);

        System.out.println("Таблица создана");
    }

    private void connection() throws SQLException {
        conn = DriverManager.getConnection(url);
        System.out.println("Успешное соединение с БД");
    }

    private void saveNotes(ArrayList<Note> listNote) {
        try {
            createTable.executeUpdate("DELETE FROM note");
            insertInto = conn.prepareStatement("INSERT INTO note VALUES(?, ?, ?)");
            for (Note tmpNote : listNote) {
                insertInto.setInt(1, tmpNote.getCurrentId());
                insertInto.setString(2, tmpNote.getText());
                insertInto.setString(3, tmpNote.getStatus());

                insertInto.executeUpdate();

                System.out.println(
                        "\nid: " + tmpNote.getCurrentId() +
                        "\ntext: " + tmpNote.getText() +
                        "\nstatus: " + tmpNote.getStatus()
                );
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public ArrayList<Note> getArrayListNote() {

        ArrayList<Note> listNotes = new ArrayList<>();

        try {
            selectAll = createTable.executeQuery("SELECT * FROM note");

            while(selectAll.next()) {
                int idNote = selectAll.getInt(1);
                String textNote = selectAll.getString(2);
                String status = selectAll.getString(3);

                listNotes.add(new Note(idNote, textNote, status));

                System.out.println("\nid: " + idNote + "\ntext: " + textNote + "\nstatus: " + status);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return listNotes;
    }

    public void closeConnection(ArrayList<Note> listNote) {
        try {
            saveNotes(listNote);
            if (conn != null) {
                conn.close();

                createTable.close();
                insertInto.close();
                selectAll.close();

                System.out.println("Cоединение закрыто");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
