
## Ziel??
 * Datentypen:
   * Int
   * Char
   * Long (2^32)
   * fp32
   * (Strings)
 * Festkommarechnung
 * (Fließkommazahlen -> Software)
 * Fibonacci
 * Fakultät
 * Input lesen (button)
 * LED blinken lassen
 * (Serielle Konsole??)
   * LCD/TFT display

## IS

32bit vs 64bit
  -> 64bit bietet keinen grossen Nutzen gegenueber dem Aufwand

2-Adress Format vs 3-Adress Format
  -> 32bit bieten schon genug Platz fuer 3-adress format

(https://iitd-plos.github.io/col718/ref/arm-instructionset.pdf)

Not without
 * ADC (A := B + OP + Carry)
 * ADD (A := B + OP)
 * AND (A := B AND OP)
 * B (PC := address if compare)
 * CMP (CPSR flags := Rn - Op2)
 * LDR (Rd := address)
 * MOV (Rd : = Op2)
 * MRS (Rn := PSR)
 * MSR (PSR := Rm)
 * ORR (Rd := Rn OR Op2)
 * SBC (Rd := Rn - Op2 - 1 + Carry)
 * SL (shift left)
 * SRA (shift right arithmetic)
 * SRL (shift right logic)
 * STR (<address> := Rd)
 * SUB (Rd := Rn - Op2)
 * XOR (Rd := (Rn AND NOT Op2)OR (op2 AND NOT Rn))

Nice to have
 * SWP (Rd := [Rn], [Rn] := Rm)

Shouldn't do
 * MUL (Rd := Rm * Rs)

## Flags
 * Carry
 * Compare
 * ??
 *
