package de.projekt.compiler;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;

import javax.swing.JFrame;
import javax.swing.JPanel;

import org.antlr.v4.gui.TreeViewer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.tree.ParseTree;

import de.projekt.parser.TestLexer;
import de.projekt.parser.TestParser;

public class Main {

	static String path = "";
	static String target = "";
	
	static boolean execute;

	static HashMap<String, Integer> labels = new HashMap<String, Integer>();

	public static void main(String[] args) throws Exception {

		mainParams(args);

		if(execute) {
			String data = preProcess(path);
	
			CharStream charStream = CharStreams.fromString(data);
			TestLexer lexer = new TestLexer(charStream);
	
			TestParser parser = new TestParser(new CommonTokenStream(lexer));
	
			ParseTree tree = parser.start();
	
			MyVisitor visitor = new MyVisitor(labels); // der Visitor macht die meiste Arbeit und erzeugt die passenden										// Strings
	
			String result = visitor.visit(tree); // der Ergebnisstring
	
			System.out.println(result);
	
			try {
				FileWriter myWriter = new FileWriter(target);
				myWriter.write(result); // Ergebnis abspeichern
				myWriter.close();
				System.out.println("Successfully wrote to the file.");
			} catch (IOException e) {
				System.out.println("An error occurred.");
				e.printStackTrace();
			}

		//showTree(tree, parser);
		}
		
	}

	/**
	 * Verarbeitet die Startparameter
	 */
	private static void mainParams(String[] params) {

		if (params.length > 0) {
			if (params[0].equals("-help")) {
				System.out.println("java -jar fileName.jar inputfile outputfile");
				execute = false;
			} else if(params.length == 2){
				path = params[0];
				target = params[1];
				execute = true;
			}else{
				System.err.println("ERROR: Input-/Outputfile required!");
			}
		}else {
			System.err.println("ERROR: Input-/Outputfile required!");
		}
	}
	
	private static String preProcess(String path) throws IOException {
		CharStream macroCharStream = CharStreams.fromFileName(path);
		
		TestLexer macroLexer = new TestLexer(macroCharStream);
		TestParser macroParser = new TestParser(new CommonTokenStream(macroLexer));
		
		ParseTree macroTree = macroParser.start();
		
		MacroVisitor macroVisitor = new MacroVisitor();
		String macroFree = macroVisitor.visit(macroTree);
		
		CharStream preCharStream = CharStreams.fromString(macroFree);
		
		TestLexer preLexer = new TestLexer(preCharStream);
		TestParser preParser = new TestParser(new CommonTokenStream(preLexer));
		
		ParseTree preTree = preParser.start();
		
		PreProcessor preProcessor = new PreProcessor(labels);
		String result = preProcessor.visit(preTree);
		
		return result;
	}

	private static void showTree(ParseTree tree, Parser parser) {
		JFrame frame = new JFrame("Antlr TREE");

		JPanel panel = new JPanel();

		TreeViewer viewer = new TreeViewer(Arrays.asList(parser.getRuleNames()), tree);

		viewer.setScale(1.5);

		panel.add(viewer);

		frame.add(panel);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.pack();
		frame.setLocation(500, 200);
		frame.setVisible(true);
	}
}
