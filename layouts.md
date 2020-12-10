## Three-op layout
```
             3         2         1         0
            10987654321098765432109876543210
    op code XXXXX
    imm bit      0
    op_1          XXXXX
    op_2               XXXXX
    op_3                    XXXXX
```
```
             3         2         1         0
            10987654321098765432109876543210
    op code XXXXX
    imm bit      1
    op_1          XXXXX
    op_2               XXXXX
    op_imm                  XXXXXXXXXXXXXXXX
```

## Two-op layout
```
             3         2         1         0
            10987654321098765432109876543210
    op code XXXXX
    imm bit      0
    op_1               XXXXX
    op_2                    XXXXX
```
```
             3         2         1         0
            10987654321098765432109876543210
    op code XXXXX
    imm bit      1
    op_1               XXXXX
    op_imm                  XXXXXXXXXXXXXXXX
```

## One-op layout
```
             3         2         1         0
            10987654321098765432109876543210
    op code XXXXX
    imm bit      0
    op_1                    XXXXX
```
```
             3         2         1         0
            10987654321098765432109876543210
    op code XXXXX
    imm bit      1
    op_imm                  XXXXXXXXXXXXXXXX
```

## No-op layout
```
             3         2         1         0
            10987654321098765432109876543210
    op code XXXXX
    imm bit      X
```