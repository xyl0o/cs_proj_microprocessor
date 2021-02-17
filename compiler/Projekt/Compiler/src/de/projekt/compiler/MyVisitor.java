package de.projekt.compiler;

import java.util.HashMap;

import de.projekt.parser.TestBaseVisitor;
import de.projekt.parser.TestParser.CommandContext;
import de.projekt.parser.TestParser.Jmp_opContext;
import de.projekt.parser.TestParser.Jmp_op_opcodeContext;
import de.projekt.parser.TestParser.Load_labelContext;
import de.projekt.parser.TestParser.No_opContext;
import de.projekt.parser.TestParser.No_op_opcodeContext;
import de.projekt.parser.TestParser.RegOneContext;
import de.projekt.parser.TestParser.RegOrImContext;
import de.projekt.parser.TestParser.RegTwoContext;
import de.projekt.parser.TestParser.Three_opContext;
import de.projekt.parser.TestParser.Three_op_opcodeContext;
import de.projekt.parser.TestParser.Two_opContext;
import de.projekt.parser.TestParser.Two_op_opcodeContext;

public class MyVisitor extends TestBaseVisitor<String> {
	int line = 0; // Die Zeile des Befehls im Quelltext

	private HashMap<String, Integer> opcodes = new HashMap<String, Integer>();
	HashMap<String, Integer> labels;

	public MyVisitor(HashMap<String, Integer> labels) {
		this.labels = labels;
		// Dict mit Opcodes füllen
		opcodes.put("CMPEQ", 0b01001);
		opcodes.put("CMPGT", 0b01010);
		opcodes.put("MOV", 0b01011);
		opcodes.put("JMP", 0b01100);
		opcodes.put("B", 0b01101);
		opcodes.put("ADC", 0b10001);
		opcodes.put("ADD", 0b10010);
		opcodes.put("SBC", 0b10011);
		opcodes.put("SUB", 0b10100);
		opcodes.put("SL", 0b10101);
		opcodes.put("SRA", 0b10110);
		opcodes.put("SRL", 0b10111);
		opcodes.put("AND", 0b11000);
		opcodes.put("ORR", 0b11001);
		opcodes.put("XOR", 0b11010);
		opcodes.put("LDR", 0b11011);
		opcodes.put("STR", 0b11100);
		opcodes.put("NOP", 0b11111);

	}

	/******** Visitor Methoden ********/

	@Override
	public String visitCommand(CommandContext ctx) {
		line++;
		// Die einzelnen Tokens besuchen
		return visitChildren(ctx);
	}

	@Override
	public String visitThree_op(Three_opContext ctx) {
		String opcode = visitThree_op_opcode(ctx.three_op_opcode());
		String regOne = visitRegOne(ctx.regOne());
		String regTwo = visitRegTwo(ctx.regTwo());
		String isIm = "0";
		String padding = "00000000000";
		
		if (ctx.regOrIm().immediate != null) {
			isIm = "1";
			padding = "";
		}
		String regOrIm = visitRegOrIm(ctx.regOrIm());
		return line + "\t" + opcode + isIm + regOne + regTwo + regOrIm + padding + "\n";
	}

	@Override
	public String visitTwo_op(Two_opContext ctx) {
		String opcode = visitTwo_op_opcode(ctx.two_op_opcode());
		String regOne = visitRegOne(ctx.regOne());
		String isIm = "0";
		String regOrIm = visitRegOrIm(ctx.regOrIm());
		
		if (ctx.regOrIm().immediate != null) {
			isIm = "1";
			return line + "\t" + opcode + isIm+ "00000" + regOne + regOrIm +  "\n";
		}
		else {
			return line + "\t" + opcode + isIm+ "00000" + regOne + regOrIm +  "00000000000 \n";
		}
	}

	@Override
	public String visitNo_op(No_opContext ctx) {
		String opcode = visitNo_op_opcode(ctx.no_op_opcode());
		
		return line + "\t" + opcode + "000000000000000000000000000 \n";
	}

	@Override
	public String visitJmp_op(Jmp_opContext ctx) {
		String opcode = visitJmp_op_opcode(ctx.jmp_op_opcode());
		String address = visitLoad_label(ctx.load_label());
		String regOne = visitRegOne(ctx.regOne());
		return line + "\t" + opcode + "100000" + regOne + address + "\n";
	}

	@Override
	public String visitThree_op_opcode(Three_op_opcodeContext ctx) {
		String output = toBinaryString(5, opcodes.get(ctx.getText()));
		return output;
	}

	@Override
	public String visitTwo_op_opcode(Two_op_opcodeContext ctx) {
		String output = toBinaryString(5, opcodes.get(ctx.getText()));
		return output;
	}

	@Override
	public String visitJmp_op_opcode(Jmp_op_opcodeContext ctx) {
		String output = toBinaryString(5, opcodes.get(ctx.getText()));
		return output;
	}

	@Override
	public String visitNo_op_opcode(No_op_opcodeContext ctx) {
		String output = toBinaryString(5, opcodes.get(ctx.getText()));
		return output;
	}

	@Override
	public String visitRegOne(RegOneContext ctx) {
		int regnum = Integer.parseInt(ctx.registernumber.getText());
		return handleRegister(regnum);
	}

	@Override
	public String visitRegTwo(RegTwoContext ctx) {
		int regnum = Integer.parseInt(ctx.registernumber.getText());
		return handleRegister(regnum);
	}

	@Override
	public String visitRegOrIm(RegOrImContext ctx) {
		if (ctx.registernumber != null) {

			int regnum = Integer.parseInt(ctx.registernumber.getText());
			return handleRegister(regnum);
		} else {

			int immediate = getImmediate(ctx.immediate.getText());

			if (immediate > 65536) {
				System.err.println("ERROR: Immediate Value is too large!");
				return toBinaryString(16, 0);
			} else {
				return toBinaryString(16, immediate);
			}
		}
	}

	@Override
	public String visitLoad_label(Load_labelContext ctx) {
		String label = ctx.getText();
		if (labels.containsKey(label)) {
			int address = labels.get(label); 
			return toBinaryString(16, address);
		} else {
			System.err.println("Label: " + label + " not in use!");
			return "";
		}
	}

	@Override
	protected String aggregateResult(String aggregate, String nextResult) {
		if (aggregate == null) {
			return nextResult;
		}
		
		if (nextResult == null) {
			return aggregate;
		}
		
		return aggregate + nextResult;
	}

	/******** Hilfsmethoden ********/

	// wandelt eine Zahl in binär um mit size vielen stellen (leading zeros)
	private String toBinaryString(int size, int number) {
		String binary = Integer.toBinaryString(number);
		String format = "%" + size + "s";
		
		return String.format(format, binary).replace(' ', '0');
	}

	// prüft ob die Registernummer existiert
	private String handleRegister(int regnum) {
		if (regnum > 31) {
			System.err.println("ERROR: Called Register is too large!");
			return "";
		}
		
		return toBinaryString(5, regnum);
	}

	/**
	 * Pr�ft welches Zahlenformat vorliegt und gibt eine Dezimalzahl zur�ck.
	 * 
	 * @param immediate (String)
	 * @return String as Integer
	 */
	private int getImmediate(String immediate) {
		
		if(immediate.length() > 2) {
			if (immediate.substring(0, 2).equals("0x")) {
				return hexToInt(immediate.substring(2, (immediate.length())));
			} else if (immediate.substring(0, 2).equals("0b")) {
				return binaryToInt(immediate.substring(2, (immediate.length())));
			} else {
				return Integer.parseInt(immediate);
			}
		}else {
			return Integer.parseInt(immediate);
		}

	}

	/**
	 * Wandelt einen hexadezimalen String (bestehend aus [A-F0-9]+) in eine
	 * Dezimalzahl um.
	 * 
	 * @param number
	 * @return String as Integer
	 */
	private int hexToInt(String number) {

		char[] chars = number.toCharArray();

		int intnum = 0;
		int exponent = 0;

		for (int i = chars.length - 1; i > -1; i--) {

			switch (chars[i]) {
			case 'A':
				intnum += 10 * Math.pow(16, exponent);
				break;
			case 'B':
				intnum += 11 * Math.pow(16, exponent);
				break;
			case 'C':
				intnum += 12 * Math.pow(16, exponent);
				break;
			case 'D':
				intnum += 13 * Math.pow(16, exponent);
				break;
			case 'E':
				intnum += 14 * Math.pow(16, exponent);
				break;
			case 'F':
				intnum += 15 * Math.pow(16, exponent);
				break;
			default:
				intnum += Integer.parseInt(Character.toString(chars[i])) * Math.pow(16, exponent);
			}

			exponent++;
		}

		return intnum;
	}

	/**
	 * Wandelt einen bin�ren String (bestehend aus [0-1]+) in eine Dezimalzahl um.
	 * 
	 * @param number
	 * @return String as Integer
	 */
	private int binaryToInt(String number) {

		char[] chars = number.toCharArray();

		int intnum = 0;
		int exponent = 0;

		for (int i = chars.length - 1; i > -1; i--) {
			intnum += Integer.parseInt(Character.toString(chars[i])) * Math.pow(2, exponent);
			exponent++;
		}

		return intnum;
	}

}
