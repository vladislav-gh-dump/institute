import java.io.File;

public class FileController {

    public static String checkFile(String fileName) {
        try {
            File file = new File(fileName);
            if (file.createNewFile()) {
                return "created";
            } else {
                return "exists";
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return "error";
        }
    }
}
