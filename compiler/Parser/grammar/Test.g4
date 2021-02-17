grammar Test;

// <----------- PARSER RULES ----------->
start: start command 
	| command;

command: no_op
	| two_op
	| three_op
	| save_label
	| jmp_op
	| mul_op
	| not_op;
	
no_op: no_op_opcode COLON;
two_op: two_op_opcode regOne COMMA regOrIm COLON;
three_op: three_op_opcode regOne COMMA regTwo COMMA regOrIm COLON;

jmp_op: jmp_op_opcode regOne COMMA load_label COLON;
mul_op: mul_opcode regOne COMMA regTwo COMMA regOrIm COLON;
not_op: not_opcode regOne COMMA regOrIm COLON;

save_label: LABEL;
load_label: LABEL;

no_op_opcode: NOP;

two_op_opcode: 
	  CMPEQ 
	| CMPGT 
	| MOV;

three_op_opcode:
	  ADC 
	| ADD
	| SBC
	| SUB
	| SL
	| SRA
	| SRL
	| AND
	| ORR
	| XOR
	| LDR
	| STR;
	
jmp_op_opcode: JMP | B;
mul_opcode: MUL;
not_opcode: NOT;

regOne: 'r' registernumber=NUMBER;
regTwo: 'r' registernumber=NUMBER;
regOrIm: 'r' registernumber=NUMBER 
				|immediate=NUMBER;


// <----------- LEXER RULES ----------->
CMPEQ: 'CMPEQ';
CMPGT: 'CMPGT';
MOV: 'MOV';
JMP: 'JMP';
B: 'B';

ADC: 'ADC';
ADD: 'ADD';
SBC: 'SBC';
SUB: 'SUB';

SL: 'SL';
SRA: 'SRA';
SRL: 'SRL';

AND: 'AND';
ORR: 'OR';
XOR: 'XOR';

LDR: 'LDR';
STR: 'STR';

NOP: 'NOP';

NUMBER: [0-9]+;

//Macros
MUL: 'MUL';
NOT: 'NOT';

COMMA: ',';
COLON: ';';

SPECIFIER: 'h'
	| 'b'
	| 'd';

COMMENT: '/*' .*? '*/' -> skip;
LINE_COMMENT: '//' ~[\r\n]* -> skip;
ALT_LINE_COMMENT: '#' ~[\r\n]* -> skip;

WS: (' ' | '\r' | '\n' | '\t')+ -> skip;

LABEL: '.'[a-zA-Z0-9]+;

