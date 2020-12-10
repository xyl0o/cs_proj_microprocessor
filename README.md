
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

### Instructions we want to support

Three-op layout:
 * ADC (A := B + OP + Carry)
 * ADD (A := B + OP)
 * SBC (A := B - OP - 1 + Carry)
 * SUB (A := B - OP)
 * SL  (A := B << OP)
 * SRA (A := B >>> OP)
 * SRL (A := B >> OP)
 * AND (A := B AND OP)
 * OR  (A := B OR OP)
 * XOR (A := (B AND NOT OP) OR (OP AND NOT B))
 * LDR (A := address[B + OP])
 * STR (address[B + OP] := A)

Two-op layout:
 * CMPEQ (CMPR := A == OP)
 * CMPGT (CMPR := A - OP > 0)
 * MOV (A := OP)

One-op layout:
 * B   (PC := OP if compare)
 * MRS (A := FLAGS)
 * MSR (FLAGS := A)

No-op layout:
 * NOP (Do nothing)

## Flags
 * Carry
 * Compare
 * ??
 *
