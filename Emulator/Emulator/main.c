#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

// Read file constants
const int MAX_CHARACTERS = 34;
const int NUMBER_POINTERS = 2;

// Instruction constant
const int INSTRUCTION_LENGHT = 32;
const int OPCODE_LENGHT = 6;

// Instruction R and I constants
const int RS_LENGHT = 5;
const int RT_LENGHT = 5;

// Instruction R constants
const int RD_LENGHT = 5;
const int SHAMT_LENGHT = 5;
const int FUNCT_LENGHT = 6;

// Instruction I constant
const int IMMEDIATE_LENGHT = 16;

// Instruction J constant
const int ADDRESS_LENGHT = 26;

// Register constant
//const int NUMBER_REGISTERS = 32;

// Global variables
int pc = 0;

/*
registers[0]     -> $zero   -> The Constant Value 0
registers[1]     -> $at     -> Assembler Temporary
registers[2-3]   -> $v0-$v1 -> Values for Function Results and Expression Evaluation
registers[4-7]   -> $a0-$a3 -> Arguments
registers[8-15]  -> $t0-$t7 -> Temporaries
registers[16-23] -> $s0-$s7 -> Saved Temporaries
registers[24-25] -> $t8-$t9 -> Temporaries
registers[26-27] -> $k0-$k1 -> Reserved for OS Kernel
registers[28]    -> $gp 28  -> Global Pointer
registers[29]    -> $sp 29  -> Stack Pointer
registers[30]    -> $fp 30  -> Frame Pointer
registers[31]    -> $ra 31  -> Return Address
*/
int registers[32];

void add(int rs, int rt, int rd) {

    int aux = registers[rs] + registers[rt];

    registers[rd] = aux;

}

void addi(int rs, int rt, int SignExtImm) {

    int aux = registers[rs] + SignExtImm;

    registers[rt] = aux;

}

void addiu(int rs, int rt, int SignExtImm) {

    int aux = registers[rs] + SignExtImm;

    registers[rt] = aux;

}

void addu(int rs, int rt, int rd) {

    int aux = registers[rs] + registers[rt];

    registers[rd] = aux;

}

/*
int and(int rs, int rt) {

    int rd = 0;

    // ...

    return rd;

}

int andi(int rs, int ZeroExtImm) {

    int rt = 0;

    // ...

    return rt;

}

void beq(int rs, int rt) {

    if(registers[rs] == registers[rt]) {

        pc = pc + 1 +

    }

}

void bne(int rs, int rt) {

    int result = 0;

    // ...

    return result;

}
*/

void j(int JumpAddr) {

    pc = JumpAddr;

}

void jal(int JumpAddr) {

    registers[31] = pc + 2; // pc + 8

    pc = JumpAddr;

}

void jr(int rs) {

    pc = registers[rs];

}

/*
int lbu(int rs, int SignExtImm) {

    int rt = 0;

    // ...

    return rt;

}

int lhu(int rs, int SignExtImm) {

    int rt = 0;

    // ...

    return rt;

}

int ll(int rs, int SignExtImm) {

    int rt = 0;

    // ...

    return rt;

}

int lui(int imm) {

    int rt = 0;

    // ...

    return rt;

}

void lw(int rs, int rt, int SignExtImm) {

    int rt = 0;

    // ...

    return rt;

}

int nor(int rs, int rt) {

    int rd = 0;

    // ...

    return rd;

}

int or(int rs, int rt) {

    int rd = 0;

    // ...

    return rd;

}

int ori(int rs, int ZeroExtImm) {

    int rt = 0;

    // ...

    return rt;

}
*/

void slt(int rs, int rt, int rd) {

    if(registers[rs] < registers[rt]) {

        registers[rd] = 1;

    } else {

        registers[rd] = 0;

    }

}

void slti(int rs, int rt, int SignExtImm) {

    if(registers[rs] < SignExtImm) {

        registers[rt] = 1;

    } else {

        registers[rt] = 0;

    }

}

void sltiu(int rs, int rt, int SignExtImm) {

    if(registers[rs] < SignExtImm) {

        registers[rt] = 1;

    } else {

        registers[rt] = 0;

    }

}

void sltu(int rs, int rt, int rd) {

    if(registers[rs] < registers[rt]) {

        registers[rd] = 1;

    } else {

        registers[rd] = 0;

    }

}

void sll(int rt, int rd, int shamt) {

    int aux = registers[rt] * (2 * shamt);

    registers[rd] = aux;

}

void srl(int rt, int rd, int shamt) {

    int aux = registers[rt] / (2 * shamt);

    registers[rd] = aux;

}

/*
int sb(int rs, int SignExtImm) {

    int rt = 0;

    // ...

    return rt;

}

int sc(int rs, int SignExtImm) {

    int rt = 0;

    // ...

    return rt;

}

int sh(int rs, int SignExtImm) {

    int rt = 0;

    // ...

    return rt;

}


int sw(int rs, int SignExtImm) {

    int rt = 0;

    // ...

    return rt;

}
*/

void sub(int rs, int rt, int rd) {

    int aux = registers[rs] - registers[rt];

    registers[rd] = aux;

}

void subu(int rs, int rt, int rd) {

    int aux = registers[rs] - registers[rt];

    registers[rd] = aux;

}

int binaryToDecimal(char binary[], int length) {

	int decimal = 0;

	int position = 0;

	int index = length - 1;

	while (index >= 0) {

		decimal = decimal + (binary[index] - 48) * pow(2, position);

		index--;

		position++;

	}

	return decimal;

}

void sliceInstruction(char *instruction, char *slice, int start, int end) {

    int j = 0;

    for (int i = start; i < end; i++) {

        slice[j] = instruction[i];

        j++;

    }

}

void instructionR(char *instruction) {

    char opcodeChar[OPCODE_LENGHT];
    char rsChar[RS_LENGHT];
    char rtChar[RT_LENGHT];
    char rdChar[RD_LENGHT];
    char shamtChar[SHAMT_LENGHT];
    char functChar[FUNCT_LENGHT];

    //int opcode;
    int rs;
    int rt;
    int rd;
    int shamt;
    int funct;

    sliceInstruction(instruction, opcodeChar, 0, 6);
    sliceInstruction(instruction, rsChar, 6, 11);
    sliceInstruction(instruction, rtChar, 11, 16);
    sliceInstruction(instruction, rdChar, 16, 21);
    sliceInstruction(instruction, shamtChar, 21, 26);
    sliceInstruction(instruction,functChar, 26, 32);

    //opcode = binaryToDecimal(opcodeChar, OPCODE_LENGHT);
    rs = binaryToDecimal(rsChar, FUNCT_LENGHT);
    rt = binaryToDecimal(rtChar, FUNCT_LENGHT);
    rd = binaryToDecimal(rdChar, FUNCT_LENGHT);
    shamt = binaryToDecimal(shamtChar, FUNCT_LENGHT);
    funct = binaryToDecimal(functChar, FUNCT_LENGHT);

    printf ("opcode = %s\n", opcodeChar);
    printf ("rs = %s\n", rsChar);
    printf ("rt = %s\n", rtChar);
    printf ("rd = %s\n", rdChar);
    printf ("shamt = %s\n", shamtChar);
    printf ("funct = %s\n", functChar);

    switch(funct) {

        case 0:

            printf("%s\n", "sll");

            sll(rt, rd, shamt);

            break;

        case 2:

            printf("%s\n", "srl");

            srl(rt, rd, shamt);

            break;

        case 8:

            printf("%s\n", "jr");

            //jr(rs);

            break;

        case 12:

            printf("%s\n", "syscall");

            //syscall();

            break;

        case 32:

            printf("%s\n", "add");

            add(rs, rt, rd);

            break;

        case 33:

            printf("%s\n", "addu");

            // REVISAR PORQUE ALGUNOS PUEDE QUE VENGAN EN COMPLEMENTO A 2

            //printf("rs = %d\n", rs);
            //printf("rt = %d\n", rt);
            //printf("rd = %d\n", rd);

            //addu(rs, rt, rd);

            break;

        case 34:

            printf("%s\n", "sub");

            sub(rs, rt, rd);

            break;

        case 35:

            printf("%s\n", "subu");

            // REVISAR PORQUE ALGUNOS PUEDE QUE VENGAN EN COMPLEMENTO A 2

            subu(rs, rt, rd);

            break;

        case 36:

            printf("%s\n", "and");

            //and()

            break;

        case 37:

            printf("%s\n", "or");

            //or()

            break;

        case 39:

            printf("%s\n", "nor");

            //nor()

            break;

        case 42:

            printf("%s\n", "slt");

            slt(rs, rt, rd);

            break;

        case 43:

            printf("%s\n", "sltu");

            // REVISAR PORQUE ALGUNOS PUEDE QUE VENGAN EN COMPLEMENTO A 2

            //sltu(rs, rt, rd);

            break;

    }

    printf("\n");

}

void instructionI(char *instruction) {

    char opcodeChar[OPCODE_LENGHT];
    char rsChar[RS_LENGHT];
    char rtChar[RT_LENGHT];
    char immediateChar[16];

    int opcode;
    int rs;
    int rt;
    int immediate;

    sliceInstruction(instruction, opcodeChar, 0, 6);
    sliceInstruction(instruction, rsChar, 6, 11);
    sliceInstruction(instruction, rtChar, 11, 16);
    sliceInstruction(instruction, immediateChar, 16, 32);

    opcode = binaryToDecimal(opcodeChar, OPCODE_LENGHT);
    rs = binaryToDecimal(rsChar, RS_LENGHT);
    rt = binaryToDecimal(rtChar, RT_LENGHT);
    immediate = binaryToDecimal(immediateChar, 16);

    printf ("opcode = %s\n", opcodeChar);
    printf ("rs = %s\n", rsChar);
    printf ("rt = %s\n", rtChar);
    printf ("immediate = %s\n", immediateChar);

    switch(opcode){

        case 4:

            printf("%s\n", "beq");

            //beq()

            break;

        case 5:

            printf("%s\n", "bne");

            //bne()

            break;

        case 8:

            printf("%s\n", "addi");

            addi(rs, rt, immediate);

            break;

        case 9:

            printf("%s\n", "addiu");

            // REVISAR PORQUE ALGUNOS PUEDE QUE VENGAN EN COMPLEMENTO A 2

            addiu(rs, rt, immediate);

            break;

        case 10:

            printf("%s\n", "slti");

            slti(rs, rt, immediate);

            break;

        case 11:

            printf("%s\n", "sltiu");

            // REVISAR PORQUE ALGUNOS PUEDE QUE VENGAN EN COMPLEMENTO A 2

            sltiu(rs, rt, immediate);

            break;

        case 12:

            printf("%s\n", "andi");

            //andi()

            break;

        case 13:

            printf("%s\n", "ori");

            //ori()

            break;

        case 15:

            printf("%s\n", "lui");

            //lui()

            break;

        case 35:

            printf("%s\n", "lw");

            //lw()

            break;

        case 36:

            printf("%s\n", "lbu");

            // REVISAR PORQUE ALGUNOS PUEDE QUE VENGAN EN COMPLEMENTO A 2

            //lbu()

            break;

        case 37:

            printf("%s\n", "lhu");

            // REVISAR PORQUE ALGUNOS PUEDE QUE VENGAN EN COMPLEMENTO A 2

            //lhu()

            break;

        case 40:

            printf("%s\n", "sb");

            //sb()

            break;

        case 41:

            printf("%s\n", "sh");

            //sh()

            break;

        case 43:

            printf("%s\n", "sw");

            //sw()

            break;

        case 48:

            printf("%s\n", "ll");

            //ll()

            break;

        case 56:

            printf("%s\n", "sc");

            //sc()

            break;

    }

    printf("\n");

}

void instructionJ(char *instruction) {

    char opcodeChar[OPCODE_LENGHT];
    char addressChar[ADDRESS_LENGHT];

    int opcode;
    int address;

    sliceInstruction(instruction, opcodeChar, 0, 6);
    sliceInstruction(instruction, addressChar, 6, 32);

    opcode = binaryToDecimal(opcodeChar, OPCODE_LENGHT);
    address = binaryToDecimal(addressChar, ADDRESS_LENGHT);

    printf ("opcode = %s\n", opcodeChar);
    printf ("address = %s\n", addressChar);

       switch(opcode){

        case 2:

            printf("%s\n", "j");

            j(address);

            break;

        case 3:

            printf("%s\n", "jal");

            jal(address);

            break;

    }

   printf("\n");

}

void printLines(char **lines, int size) {

    for (size_t i = 0; i < size; i++) {

        printf ("line[%3zu] : %s\n", i, lines[i]);

    }
}

int main() {

    char buffer[MAX_CHARACTERS];

    // reading text file
    char **textInstructions;

    int nptrs = NUMBER_POINTERS;

    int textInstructionsSize = 0;

    char *file = "pongText.txt";

    FILE *fp = fopen(file, "r");

    if (!fp) {

        perror("text file open failed");

        return 1;

    } else if ((textInstructions = malloc(nptrs * sizeof *textInstructions)) == NULL) {

        perror("malloc error");

        exit (EXIT_FAILURE);

    }

    while (fgets(buffer, MAX_CHARACTERS, fp)) {

        int size;

        buffer[(size = strcspn (buffer, "\n"))] = 0;

        if (textInstructionsSize == nptrs) {

            void *tmp = realloc(textInstructions, (2 * nptrs) * sizeof *textInstructions);

            if (!tmp) {

                perror ("realloc error");

                break;
            }

            textInstructions = tmp;

            nptrs *= 2;
        }

        if (!(textInstructions[textInstructionsSize] = malloc(size + 1))) {

            perror ("malloc error");

            break;
        }

        memcpy(textInstructions[textInstructionsSize], buffer, size + 1);

        textInstructionsSize += 1;

    }

    if (fp != stdin) {

        fclose (fp);

    }

    // reading data file
    char **dataInstructions;

    nptrs = NUMBER_POINTERS;

    int dataInstructionsSize = 0;

    file = "pongData.txt";

    fp = fopen(file, "r");

    if (!fp) {

        perror("data file open failed");

        return 1;

    } else if ((dataInstructions = malloc(nptrs * sizeof *dataInstructions)) == NULL) {

        perror("malloc error");

        exit (EXIT_FAILURE);

    }

    while (fgets(buffer, MAX_CHARACTERS, fp)) {

        int size;

        buffer[(size = strcspn (buffer, "\n"))] = 0;

        if (dataInstructionsSize == nptrs) {

            void *tmp = realloc(dataInstructions, (2 * nptrs) * sizeof *dataInstructions);

            if (!tmp) {

                perror ("realloc error");

                break;

            }

            dataInstructions = tmp;

            nptrs *= 2;

        }

        if (!(dataInstructions[dataInstructionsSize] = malloc(size + 1))) {

            perror ("malloc error");

            break;

        }

        memcpy(dataInstructions[dataInstructionsSize], buffer, size + 1);

        dataInstructionsSize += 1;

    }

    if (fp != stdin) {

        fclose (fp);

    }

    //printLines(textInstructions, textInstructionsSize);

    //printLines(dataInstructions, dataInstructionsSize);

    // ALMACENAR VARIABLES DEL DATA

    // text instructions execution
    while(pc < textInstructionsSize) {

        char *instruction;

        instruction = textInstructions[pc];

        char opcode[OPCODE_LENGHT];

        // getting opcode from instruction
        for (int i = 0; i < OPCODE_LENGHT; i++) {

            opcode[i] = instruction[i];

        }

        // R instruction
        if (strcmp(opcode, "000000") == 0) {

            printf ("Type R\n");
            printf ("pc = %d\n", pc);

            instructionR(instruction);

        // J instruction
        } else if (strcmp(opcode, "000010") == 0 || strcmp(opcode, "000011") == 0) {

            //printf ("Type J\n");
            //printf ("pc = %d\n", pc);

            //instructionJ(instruction);

        // I instruction
        } else {

            printf ("Type I\n");
            printf ("pc = %d\n", pc);

            instructionI(instruction);

        }

        pc++;

    }

    // free memory
    for (size_t i = 0; i < textInstructionsSize; i++) {

        free(textInstructions[i]);

    }

    free(textInstructions);

    // free memory
    for (size_t i = 0; i < dataInstructionsSize; i++) {

        free(dataInstructions[i]);

    }

    free(dataInstructions);

}
