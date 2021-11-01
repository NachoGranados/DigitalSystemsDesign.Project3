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

// Color constant
const int MAX_IMMEDIATE_VALUE = 65535;

// Global arrays constants
const int MEMORY_SIZE = 2000;
const int DYNAMIC_DATA_POINTER_POSITION = 28;
const int STACK_POINTER_POSITION = 29;

// Global variables
int pc = 0;

int *dataInstructions;

int *memory;

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
int and(int rs, int rt) { NO ESTA

    int rd = 0;

    // ...

    return rd;

}

int andi(int rs, int ZeroExtImm) { NO ESTA
    int rt = 0;

    // ...

    return rt;

}
*/


void beq(int rs, int rt) {

    if(registers[rs] == registers[rt]) {

        //pc = pc + 1 +

    }

}

void bne(int rs, int rt) {

    //int result = 0;

    // ...

    //return result;

}


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
int lbu(int rs, int SignExtImm) { NO ESTA

    int rt = 0;

    // ...

    return rt;

}

int lhu(int rs, int SignExtImm) { NO ESTA

    int rt = 0;

    // ...

    return rt;

}

int ll(int rs, int SignExtImm) { NO ESTA

    int rt = 0;

    // ...

    return rt;

}

int lui(int imm) { NO ESTA

    int rt = 0;

    // ...

    return rt;

}
*/

void lw(int rs, int rt, int SignExtImm) {

    // DEBE BUSCAR EN EL STACK

    /*

        lw $ra, 0($sp)

        100011 11101 11111 0000000000000000
        opcode rs    rt    immediate

    */

    int sp = registers[STACK_POINTER_POSITION];

    int aux = sp + SignExtImm / 4;

    int temp = memory[aux];

    registers[rt] = temp;

}

/*
int nor(int rs, int rt) { NO ESTA

    int rd = 0;

    // ...

    return rd;

}

int or(int rs, int rt) { NO ESTA

    int rd = 0;

    // ...

    return rd;

}

int ori(int rs, int ZeroExtImm) { NO ESTA

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
int sb(int rs, int SignExtImm) { NO ESTA

    int rt = 0;

    // ...

    return rt;

}

int sc(int rs, int SignExtImm) { NO ESTA

    int rt = 0;

    // ...

    return rt;

}

int sh(int rs, int SignExtImm) { NO ESTA

    int rt = 0;

    // ...

    return rt;

}
*/

void sw(int rs, int rt, int SignExtImm) {

    // DEBE BUSCAR EN EL STACK

    /*

            rt     rs
        sw $ra, 0($sp)

        101011 11101 11111 0000000000000000
        opcode rs    rt    immediate

    */

    int sp = registers[STACK_POINTER_POSITION];

    int aux = sp + SignExtImm / 4;

    memory[aux] = registers[rt];


}

void sub(int rs, int rt, int rd) {

    int aux = registers[rs] - registers[rt];

    registers[rd] = aux;

}

void subu(int rs, int rt, int rd) {

    int aux = registers[rs] - registers[rt];

    registers[rd] = aux;

}

void blt() {

}

void bgt() {

}

void ble() {

}

void bge() {

}

void li(int rt, int immediate) {

    registers[rt] = immediate;

}

void move(int rs, int rd) {

    registers[rd] = registers[rs];

}

void sliceInstruction(char *instruction, char *slice, int start, int end) {

    int j = 0;

    for (int i = start; i < end; i++) {

        slice[j] = instruction[i];

        j++;

    }

}

void complement2(char *instruction, int length) {

    char temp[1];
    char *aux;

    for(int i = 0; i < length; i++) {

        sliceInstruction(instruction, temp, i, i + 1);

        if(strcmp(temp, "0") == 0) {

            aux = "1";

            instruction[i] = *aux;

        } else if(strcmp(temp, "1") == 0) {

            aux = "0";

            instruction[i] = *aux;

        }

    }

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

int isNegative(char *instruction) {

    int result = 0;

    int aux;

    char temp[1];

    sliceInstruction(instruction, temp, 0, 1);

    aux = binaryToDecimal(temp, 1);

    if(aux == 1) {

        result = 1;

    }

    return result;

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

            printf("%s\n", "addu o move");

            addu(rs, rt, rd);

            break;

        case 34:

            printf("%s\n", "sub");

            sub(rs, rt, rd);

            break;

        case 35:

            printf("%s\n", "subu");

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

            sltu(rs, rt, rd);

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
    immediate = binaryToDecimal(immediateChar, IMMEDIATE_LENGHT);

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

            // negative number
            if(isNegative(immediateChar) == 1) {

                complement2(immediateChar, IMMEDIATE_LENGHT);

                immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

            }

            // reserve or free space in the stack
            if(rs == STACK_POINTER_POSITION && rt == STACK_POINTER_POSITION) {

                immediate /= 4;

            }

            addi(rs, rt, immediate);

            break;

        case 9:

            printf("%s\n", "addiu o li");

            /*

            100011 00001 01001 0000000000000100 => lw $t1, 0xFFFF0004
            001000 00000 00001 0000000000110001 => addi $at, $zero, 49 => ??????????
            000100 00001 01001 0000000000000110 => beq $t1, 0x00000031, SetOnePlayerMode
            001000 00000 00001 0000000000110010 => addi $at, $zero, 50 => ??????????
            000100 00001 01001 0000000000000110 => beq $t1, 0x00000032, SetTwoPlayerMode
            001001 00000 00100 0000000011111010 => li $a0, 250
            001001 00000 00010 0000000000100000 => li $v0, 32
            000000 00000 00000 0000000000001100   => syscall
            000010 00000100000000000011010010   => j SelectMode
            001001 00000 01001 0000000000000001 => li $t1, 1
            000010 00000100000000000011011111   => j BeginGame
            001001 00000 01001 0000000000000010 => li $t1, 2

            000000 00000 00000 00000 00000 001100 => syscall ====> 269
            000000 00000 10110 00100 00000 100001 => addu o move
            000000 00000 10111 00101 00000 100001 => addu o move
            000011 00000100000000000111100010     => jal
            000011 00000100000000000110011000     => jal
            001001 00000 00100 0000000000001101   => addiu o li
            000000 00000 10100 00101 00000 100001 => addu o move
            001111 00000 00001 0001000000000001   => lui -------
            100011 00001 00110 0000000000100000   => lw
            000000 00000 10000 00111 00000 100001 => addu o move
            000011 00000100000000000101000111     => jal
            000000 00000 00101 10100 00000 100001 => addu o move
            000000 00000 00111 10000 00000 100001 => addu o move
            001001 00000 00100 0000000000110010   => addiu o li
            000000 00000 10101 00101 00000 100001 => addu o move
            001111 00000 00001 0001000000000001   => lui ------
            100011 00001 00110 0000000000100100   => lw =======> 285

            */

            // negative number
            if(isNegative(immediateChar) == 1) {

                complement2(immediateChar, IMMEDIATE_LENGHT);

                immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

            }

            addiu(rs, rt, immediate);

            break;

        case 10:

            printf("%s\n", "slti");

            slti(rs, rt, immediate);

            break;

        case 11:

            printf("%s\n", "sltiu");

            // negative number
            if(isNegative(immediateChar) == 1) {

                complement2(immediateChar, IMMEDIATE_LENGHT);

                immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

            }

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

            // SE IGNORA

            break;

        case 35:

            printf("%s\n", "lw");

            // key pressed or data instruction
            if(rs == 1) {

                // key pressed  0xFFFF0004                 0xFFFF0000
                if(immediate == 4294901764 || immediate == 4294901760) {

                    // REVISAR SI SE PRESIONA UNA TECLA

                // data instruction
                } else {

                    // negative number
                    if(isNegative(immediateChar) == 1) {

                        complement2(immediateChar, IMMEDIATE_LENGHT);

                        immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

                    }

                    immediate /= 4;

                    li(rt, dataInstructions[immediate]);

                    /*

                    if(dataInstructions[immediate] < MAX_IMMEDIATE_VALUE) {

                        li(rt, dataInstructions[immediate]);

                    } else {

                        // SE CARGA UN COLOR

                        // TOMAR EN CUENTA EL NEGRO QUE ES 0x00000000

                        //li(rt, dataInstructions[immediate]);

                    }

                    */

                }

            // stack use
            } else if(rs == 29) {

                lw(rs, rt, immediate);

            }

            break;

        case 36:

            printf("%s\n", "lbu");

            // negative number
            if(isNegative(immediateChar) == 1) {

                complement2(immediateChar, IMMEDIATE_LENGHT);

                immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

            }

            //lbu()

            break;

        case 37:

            printf("%s\n", "lhu");

            // negative number
            if(isNegative(immediateChar) == 1) {

                complement2(immediateChar, IMMEDIATE_LENGHT);

                immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

            }

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

            /*

            101011 00001 00000 0000000000000000
            sw $zero, 0xFFFF0000 => 323
            NO HACE NACE NADA

            sw $t1, mode
            101011 00001 01001 0000000000110100
            sw     $at   $t1   52

            */

            // cannot overwrite register $zero
            if(rt != 0) {

                // data instruction
                if(rs == 1) {

                    immediate /= 4;

                    dataInstructions[immediate] = registers[rt];

                // stack use
                } else {

                    sw(rs, rt, immediate);

                }

            }

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
    //int address;

    sliceInstruction(instruction, opcodeChar, 0, 6);
    sliceInstruction(instruction, addressChar, 12, 32);

    opcode = binaryToDecimal(opcodeChar, OPCODE_LENGHT);
    //address = binaryToDecimal(addressChar, ADDRESS_LENGHT);

    printf ("opcode = %s\n", opcodeChar);
    printf ("address = %s\n", addressChar);

   switch(opcode) {

    case 2:

        printf("%s\n", "j");

        //j(address);

        break;

    case 3:

        printf("%s\n", "jal");

        //jal(address);

        break;

    }

   printf("\n");

}

void printLines(char **lines, int size) {

    for (size_t i = 0; i < size; i++) {

        printf ("line[%3zu] : %s\n", i, lines[i]);

    }

}

void convertDataInstructions(char **instructions, int lenght) {

    int aux;

    char *temp;

    for(int i = 0; i < lenght; i++) {

        temp = instructions[i];

        // negative number
        if(isNegative(temp) == 1) {

            complement2(temp, INSTRUCTION_LENGHT);

            aux = -1 * (binaryToDecimal(temp, INSTRUCTION_LENGHT) + 1);

        } else {

            aux = binaryToDecimal(temp, INSTRUCTION_LENGHT);

        }

        dataInstructions[i] = aux;

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

    if(!fp) {

        perror("text file open failed");

        return 1;

    } else if((textInstructions = malloc(nptrs * sizeof *textInstructions)) == NULL) {

        perror("malloc error");

        exit (EXIT_FAILURE);

    }

    while(fgets(buffer, MAX_CHARACTERS, fp)) {

        int size;

        buffer[(size = strcspn (buffer, "\n"))] = 0;

        if(textInstructionsSize == nptrs) {

            void *tmp = realloc(textInstructions, (2 * nptrs) * sizeof *textInstructions);

            if(!tmp) {

                perror ("realloc error");

                break;
            }

            textInstructions = tmp;

            nptrs *= 2;
        }

        if(!(textInstructions[textInstructionsSize] = malloc(size + 1))) {

            perror ("malloc error");

            break;
        }

        memcpy(textInstructions[textInstructionsSize], buffer, size + 1);

        textInstructionsSize += 1;

    }

    if(fp != stdin) {

        fclose (fp);

    }

    // reading data file
    char **dataInstructionsAux;

    nptrs = NUMBER_POINTERS;

    int dataInstructionsSize = 0;

    file = "pongData.txt";

    fp = fopen(file, "r");

    if(!fp) {

        perror("data file open failed");

        return 1;

    } else if((dataInstructionsAux = malloc(nptrs * sizeof *dataInstructionsAux)) == NULL) {

        perror("malloc error");

        exit(EXIT_FAILURE);

    }

    while(fgets(buffer, MAX_CHARACTERS, fp)) {

        int size;

        buffer[(size = strcspn (buffer, "\n"))] = 0;

        if(dataInstructionsSize == nptrs) {

            void *tmp = realloc(dataInstructionsAux, (2 * nptrs) * sizeof *dataInstructionsAux);

            if(!tmp) {

                perror ("realloc error");

                break;

            }

            dataInstructionsAux = tmp;

            nptrs *= 2;

        }

        if(!(dataInstructionsAux[dataInstructionsSize] = malloc(size + 1))) {

            perror ("malloc error");

            break;

        }

        memcpy(dataInstructionsAux[dataInstructionsSize], buffer, size + 1);

        dataInstructionsSize += 1;

    }

    if(fp != stdin) {

        fclose (fp);

    }

    dataInstructions = malloc(dataInstructionsSize);

    convertDataInstructions(dataInstructionsAux, dataInstructionsSize);

    /*

    // creating stack array
    stack = malloc(STACK_SIZE * sizeof(int));

    registers[STACK_POINTER_POSITION] = 999;

    // creating dynamic data array
    dynamicData = malloc(DYNAMIC_DATA_SIZE * sizeof(int));

    registers[DYNAMIC_DATA_POINTER_POSITION] = 0;

    */

    // creating memory array
    memory = malloc(MEMORY_SIZE * sizeof(int));

    // global pointer must be positioned at the start of the memory array
    registers[DYNAMIC_DATA_POINTER_POSITION] = 0;

    // stack pointer must be positioned at the end of the memory array
    registers[STACK_POINTER_POSITION] = 1999;

    //printLines(textInstructions, textInstructionsSize);

    //printLines(dataInstructionsAux, dataInstructionsSize);




    // text instructions execution
    while(pc < textInstructionsSize) {

        char *instruction;

        instruction = textInstructions[pc];

        char opcode[OPCODE_LENGHT];

        // getting opcode from instruction
        for(int i = 0; i < OPCODE_LENGHT; i++) {

            opcode[i] = instruction[i];

        }

        // R instruction
        if(strcmp(opcode, "000000") == 0) {

            printf ("Type R\n");
            printf ("pc = %d\n", pc);

            instructionR(instruction);

        // J instruction
        } else if(strcmp(opcode, "000010") == 0 || strcmp(opcode, "000011") == 0) {

            printf ("Type J\n");
            printf ("pc = %d\n", pc);

            instructionJ(instruction);

        // I instruction
        } else {

            printf ("Type I\n");
            printf ("pc = %d\n", pc);

            instructionI(instruction);

        }

        // reset $zero
        registers[0] = 0;

        pc++;



        /*
        int testInteger;
        printf("Continue:");
        scanf("%d", &testInteger);
        printf("\n");
        */

    }

    // free memory
    for (size_t i = 0; i < textInstructionsSize; i++) {

        free(textInstructions[i]);

    }

    free(textInstructions);

    /*
    // free memory
    for (size_t i = 0; i < dataInstructionsSize; i++) {

        free(dataInstructionsAux[i]);

    }
    */

    free(dataInstructionsAux);

    free(dataInstructions);

    free(memory);

    //free(stack);

    //free(dynamicData);

}

/*


    7fff fffc => 2147483644

    1000 8000h => 268468224

    2147483644 - 268468224 = 1879015420

    1879015420 / 4 = 469753855



    000011 00000100000000001001010110

    1049174 / 4 = 262293



    000001 00000000000000000000 => j ClearBoard

    000001 00000000001001010110 => j NewGame

    000001 00000000001011000010 => j Reset















































*/
