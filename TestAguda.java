import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import org.antlr.v4.gui.TreeViewer;

import javax.swing.*;

import java.io.File;
import java.util.Arrays;

public class TestAguda {
    public static void main(String[] args) throws Exception {
        String filePath = "C:\\Users\\henri\\Downloads\\aguda-testing-main-test-valid\\aguda-testing-main-test-valid\\test\\valid\\58168_cubesForEvenNum\\cubesForEvenNum.agu";
        CharStream cs = CharStreams.fromFileName(filePath);

        // Lexing and parsing
        CharStream cs2 = CharStreams.fromFileName(filePath);
        AgudaLexer lexer = new AgudaLexer(cs2);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        AgudaParser parser = new AgudaParser(tokens);

        // Parse the input starting from the 'program' rule
        ParseTree tree = parser.program();

        // Print tree in console
        System.out.println(tree.toStringTree(parser));

        // === GUI ===
        JFrame frame = new JFrame("ANTLR Parse Tree Viewer");
        JPanel panel = new JPanel();
        TreeViewer viewer = new TreeViewer(Arrays.asList(parser.getRuleNames()), tree);
        viewer.setScale(0.8); // Optional zoom
        panel.add(viewer);
        frame.add(panel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);
        frame.setVisible(true);
    }
}
