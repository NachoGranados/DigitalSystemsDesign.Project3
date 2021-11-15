// Libraries
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

#include <SDL2/SDL.h>

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
const int ADDRESS_LENGHT_ADJUSTMENT = 6;

// Color constant
const int MAX_IMMEDIATE_VALUE = 65535;

// Global arrays constants
const int MEMORY_SIZE = 2000;
const int DYNAMIC_DATA_POINTER_POSITION = 28;
const int STACK_POINTER_POSITION = 29;

// Window constants
const int SCREEN_WIDTH = 512;
const int SCREEN_HEIGHT = 256;

// Rectangle array constant
const int PIXEL_ARRAY_SIZE = 2048;
const int PIXEL_ARRAY_ROW_SIZE = 32;
const int PIXEL_ARRAY_COLUMN_SIZE = 64;

// Key constants
const int NO_KEY = 0;
const int KEY_1 = 1;
const int KEY_2 = 2;
const int KEY_A = 97;
const int KEY_Z = 122;
const int KEY_K = 107;
const int KEY_M = 109;

// Movement constants
const int NO_MOVE = 0;
const int UP = 1;
const int DOWN = 2;

// Global variables
int pc = -1;

int *dataInstructions;

int *memory;

SDL_Renderer *renderer;

SDL_Rect *pixelArray;

int keyPressed;

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

int binaryToDecimal(char *binary, int lenght) {

    int decimal = 0;

    int exp = lenght - 1;

    char temp[1];

    for(int i = 0; i < lenght; i++) {

        sliceInstruction(binary, temp, i, i + 1);

        if(strcmp(temp, "1") == 0) {

            decimal += pow(2, exp);

        }

        exp--;

    }

	return decimal;

}

void decimalToBinary(int decimal, char *binary) {

    int i = 0;

    char *aux;

    while (decimal > 0) {

        if(decimal % 2 == 0) {

            aux = "0";

            binary[i] = *aux;

        } else {

            aux = "1";

            binary[i] = *aux;

        }

        decimal /= 2;

        i++;

    }

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

void and(int rs, int rt, int rd) {

    char tempRs[IMMEDIATE_LENGHT];

    char tempRt[IMMEDIATE_LENGHT];

    char tempRd[IMMEDIATE_LENGHT];

    decimalToBinary(registers[rs], tempRs);

    decimalToBinary(registers[rt], tempRt);

    char auxTempRs[1];

    char auxTempRt[1];

    char *auxChar;

    for(int i = 0; i < IMMEDIATE_LENGHT; i++) {

        sliceInstruction(tempRs, auxTempRs, i, i + 1);

        sliceInstruction(tempRt, auxTempRt, i, i + 1);

        if(strcmp(auxTempRs, auxTempRt) == 0) {

            tempRd[i] = *auxTempRs;

        } else if((strcmp(auxTempRs, "0") == 0) | (strcmp(auxTempRt, "0") == 0)) {

            auxChar = "0";

            tempRd[i] = *auxChar;

        } else {

            auxChar = "1";

            tempRd[i] = *auxChar;

        }

    }

    int auxInt = binaryToDecimal(tempRd, IMMEDIATE_LENGHT);

    registers[rd] = auxInt;

}

void andi(int rs, int rt, int ZeroExtImm) {

    char tempRs[IMMEDIATE_LENGHT];

    char tempRt[IMMEDIATE_LENGHT];

    char tempZeroExtImm[IMMEDIATE_LENGHT];

    decimalToBinary(registers[rs], tempRs);

    decimalToBinary(ZeroExtImm, tempZeroExtImm);

    char auxTempRs[1];

    char auxTempZeroExtImm[1];

    char *auxChar;

    for(int i = 0; i < IMMEDIATE_LENGHT; i++) {

        sliceInstruction(tempRs, auxTempRs, i, i + 1);

        sliceInstruction(tempZeroExtImm, auxTempZeroExtImm, i, i + 1);

        if(strcmp(auxTempRs, auxTempZeroExtImm) == 0) {

            tempRt[i] = *auxTempRs;

        } else if((strcmp(auxTempRs, "0") == 0) | (strcmp(auxTempZeroExtImm, "0") == 0)) {

            auxChar = "0";

            tempRt[i] = *auxChar;

        } else {

            auxChar = "1";

            tempRt[i] = *auxChar;

        }

    }

    int auxInt = binaryToDecimal(tempRt, IMMEDIATE_LENGHT);

    registers[rt] = auxInt;

}

void beq(int rs, int rt, int SignExtImm) {

    if(registers[rs] == registers[rt]) {

        pc = pc + SignExtImm;

    }

}

void bne(int rs, int rt, int SignExtImm) {

    if(registers[rs] != registers[rt]) {

        pc = pc + SignExtImm;

    }

}

void blez(int rs, int SignExtImm) {

    if(registers[rs] <= 0) {

        pc = pc + SignExtImm;

    }

}

void j(int JumpAddr) {

    pc = JumpAddr;

}

void jal(int JumpAddr) {

    registers[31] = pc;

    pc = JumpAddr;

}

void jr(int rs) {

    pc = registers[rs];

}

void lbu(int rs, int rt, int SignExtImm) {

    registers[rt] = registers[rs] + SignExtImm;

}

void lhu(int rs, int rt, int SignExtImm) {

    registers[rt] = registers[rs] + SignExtImm;

}

void ll(int rs, int rt, int SignExtImm) {

    registers[rt] = registers[rs] + SignExtImm;

}

void lui(int rs, int rt, int SignExtImm) {

    registers[rt] = registers[rs] + SignExtImm;

}

void lw(int rs, int rt, int SignExtImm) {

    int sp = registers[STACK_POINTER_POSITION];

    int aux = sp + SignExtImm / 4;

    int temp = memory[aux];

    registers[rt] = temp;

}

void nor(int rs, int rt, int rd) {

    char tempRs[IMMEDIATE_LENGHT];

    char tempRt[IMMEDIATE_LENGHT];

    char tempRd[IMMEDIATE_LENGHT];

    decimalToBinary(registers[rs], tempRs);

    decimalToBinary(registers[rt], tempRt);

    char auxTempRs[1];

    char auxTempRt[1];

    char *auxChar;

    for(int i = 0; i < IMMEDIATE_LENGHT; i++) {

        sliceInstruction(tempRs, auxTempRs, i, i + 1);

        sliceInstruction(tempRt, auxTempRt, i, i + 1);

        if((strcmp(auxTempRs, "1") == 0) | (strcmp(auxTempRt, "1") == 0)) {

            auxChar = "0";

            tempRd[i] = *auxChar;

        } else {

            auxChar = "1";

            tempRd[i] = *auxChar;

        }

    }

    int auxInt = binaryToDecimal(tempRd, IMMEDIATE_LENGHT);

    registers[rd] = auxInt;

}

void or(int rs, int rt, int rd) {

    char tempRs[IMMEDIATE_LENGHT];

    char tempRt[IMMEDIATE_LENGHT];

    char tempRd[IMMEDIATE_LENGHT];

    decimalToBinary(registers[rs], tempRs);

    decimalToBinary(registers[rt], tempRt);

    char auxTempRs[1];

    char auxTempRt[1];

    char *auxChar;

    for(int i = 0; i < IMMEDIATE_LENGHT; i++) {

        sliceInstruction(tempRs, auxTempRs, i, i + 1);

        sliceInstruction(tempRt, auxTempRt, i, i + 1);

        if((strcmp(auxTempRs, "1") == 0) | (strcmp(auxTempRt, "1") == 0)) {

            auxChar = "1";

            tempRd[i] = *auxChar;

        } else {

            auxChar = "0";

            tempRd[i] = *auxChar;

        }

    }

    int auxInt = binaryToDecimal(tempRd, IMMEDIATE_LENGHT);

    registers[rd] = auxInt;

}

void ori(int rs, int rt, int rd) {

    char tempRs[IMMEDIATE_LENGHT];

    char tempRt[IMMEDIATE_LENGHT];

    char tempRd[IMMEDIATE_LENGHT];

    decimalToBinary(registers[rs], tempRs);

    decimalToBinary(registers[rt], tempRt);

    char auxTempRs[1];

    char auxTempRt[1];

    char *auxChar;

    for(int i = 0; i < IMMEDIATE_LENGHT; i++) {

        sliceInstruction(tempRs, auxTempRs, i, i + 1);

        sliceInstruction(tempRt, auxTempRt, i, i + 1);

        if(strcmp(auxTempRs, auxTempRt) == 0) {

            tempRd[i] = *auxTempRs;

        } else if((strcmp(auxTempRs, "1") == 0) | (strcmp(auxTempRt, "1") == 0)) {

            auxChar = "1";

            tempRd[i] = *auxChar;

        } else {

            auxChar = "0";

            tempRd[i] = *auxChar;

        }

    }

    int auxInt = binaryToDecimal(tempRd, IMMEDIATE_LENGHT);

    registers[rd] = auxInt;

}

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

    int aux = registers[rt] * pow(2, shamt);

    registers[rd] = aux;

}

void srl(int rt, int rd, int shamt) {

    int aux = registers[rt] / pow(2, shamt);

    registers[rd] = aux;

}

void sb(int rs, int rt, int SignExtImm) {

    registers[rt] = registers[rs] + SignExtImm;

}

void sc(int rs, int rt, int SignExtImm) {

    registers[rt] = registers[rs] + SignExtImm;

}

void sh(int rs, int rt, int SignExtImm) {

    registers[rt] = registers[rs] + SignExtImm;

}

void sw(int rs, int rt, int SignExtImm) {

    int sp = registers[STACK_POINTER_POSITION];

    int aux = sp + (SignExtImm / 4);

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

void li(int rt, int immediate) {

    registers[rt] = immediate;

}

void move(int rt, int rd) {

    registers[rd] = registers[rt];

}

void xori(int rs, int rt, int rd) {

    int aux = registers[rs] ^ registers[rt];

    registers[rd] = aux;

}

void getRGB(int *rgbArray, int colorDecimal) {

    int b = colorDecimal / 65536;
    int g = (colorDecimal - (b * 65536)) / 256;
    int r = colorDecimal - (b * 65536) - (g * 256);

    rgbArray[0] = r;
    rgbArray[1] = g;
    rgbArray[2] = b;

}

void drawPoint(SDL_Renderer *renderer, SDL_Rect *pixelArray, int x, int y, int colorDecimal) {

    int rgbArray[3];

    getRGB(rgbArray, colorDecimal);

    int ptr = 0;

    for(int i = 0; i < PIXEL_ARRAY_ROW_SIZE; i++) {

        for(int j = 0; j < PIXEL_ARRAY_COLUMN_SIZE; j++) {

            if(i == x && j == y) {

                SDL_SetRenderDrawColor(renderer, rgbArray[0], rgbArray[1], rgbArray[2], 255);

                SDL_RenderFillRect(renderer, &pixelArray[ptr]);

                // Show what was drawn
                SDL_RenderPresent(renderer);

            }

            ptr++;

        }

    }

}

void clearBoard(SDL_Renderer *renderer, SDL_Rect *pixelArray, int pixelPosition) {

    // black
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);

    SDL_RenderFillRect(renderer, &pixelArray[pixelPosition / 4]);

    // Show what was drawn
    SDL_RenderPresent(renderer);

    if(pixelPosition == 4) {

        // light blue
        SDL_SetRenderDrawColor(renderer, 0, 255, 255, 255);

    }

}

void getRegisterChar(char *registerChar, int registerNumber) {

    char *aux;

    switch(registerNumber) {

        case 0:

            aux = "$";
            registerChar[0] = *aux;

            aux = "z";
            registerChar[1] = *aux;

            aux = "e";
            registerChar[2] = *aux;

            aux = "r";
            registerChar[3] = *aux;

            aux = "o";
            registerChar[4] = *aux;

            break;

        case 1:

            aux = "$";
            registerChar[0] = *aux;

            aux = "a";
            registerChar[1] = *aux;

            aux = "t";
            registerChar[2] = *aux;

            break;

        case 2:

            aux = "$";
            registerChar[0] = *aux;

            aux = "v";
            registerChar[1] = *aux;

            aux = "0";
            registerChar[2] = *aux;

            break;

        case 3:

            aux = "$";
            registerChar[0] = *aux;

            aux = "v";
            registerChar[1] = *aux;

            aux = "1";
            registerChar[2] = *aux;
            break;

        case 4:

            aux = "$";
            registerChar[0] = *aux;

            aux = "a";
            registerChar[1] = *aux;

            aux = "0";
            registerChar[2] = *aux;

            break;

        case 5:

            aux = "$";
            registerChar[0] = *aux;

            aux = "a";
            registerChar[1] = *aux;

            aux = "1";
            registerChar[2] = *aux;

            break;

        case 6:

            aux = "$";
            registerChar[0] = *aux;

            aux = "a";
            registerChar[1] = *aux;

            aux = "2";
            registerChar[2] = *aux;

            break;

        case 7:

            aux = "$";
            registerChar[0] = *aux;

            aux = "a";
            registerChar[1] = *aux;

            aux = "3";
            registerChar[2] = *aux;

            break;

        case 8:

            aux = "$";
            registerChar[0] = *aux;

            aux = "t";
            registerChar[1] = *aux;

            aux = "0";
            registerChar[2] = *aux;

            break;

        case 9:

            aux = "$";
            registerChar[0] = *aux;

            aux = "t";
            registerChar[1] = *aux;

            aux = "1";
            registerChar[2] = *aux;

            break;


        case 10:

            aux = "$";
            registerChar[0] = *aux;

            aux = "t";
            registerChar[1] = *aux;

            aux = "2";
            registerChar[2] = *aux;

            break;


        case 11:

            aux = "$";
            registerChar[0] = *aux;

            aux = "t";
            registerChar[1] = *aux;

            aux = "3";
            registerChar[2] = *aux;

            break;


        case 12:

            aux = "$";
            registerChar[0] = *aux;

            aux = "t";
            registerChar[1] = *aux;

            aux = "4";
            registerChar[2] = *aux;

            break;


        case 13:

            aux = "$";
            registerChar[0] = *aux;

            aux = "t";
            registerChar[1] = *aux;

            aux = "5";
            registerChar[2] = *aux;

            break;


        case 14:

            aux = "$";
            registerChar[0] = *aux;

            aux = "t";
            registerChar[1] = *aux;

            aux = "6";
            registerChar[2] = *aux;

            break;


        case 15:

            aux = "$";
            registerChar[0] = *aux;

            aux = "t";
            registerChar[1] = *aux;

            aux = "7";
            registerChar[2] = *aux;

            break;

        case 16:

            aux = "$";
            registerChar[0] = *aux;

            aux = "s";
            registerChar[1] = *aux;

            aux = "0";
            registerChar[2] = *aux;

            break;

        case 17:

            aux = "$";
            registerChar[0] = *aux;

            aux = "s";
            registerChar[1] = *aux;

            aux = "1";
            registerChar[2] = *aux;

            break;

        case 18:

            aux = "$";
            registerChar[0] = *aux;

            aux = "s";
            registerChar[1] = *aux;

            aux = "2";
            registerChar[2] = *aux;

            break;

        case 19:

            aux = "$";
            registerChar[0] = *aux;

            aux = "s";
            registerChar[1] = *aux;

            aux = "3";
            registerChar[2] = *aux;

            break;

        case 20:

            aux = "$";
            registerChar[0] = *aux;

            aux = "s";
            registerChar[1] = *aux;

            aux = "4";
            registerChar[2] = *aux;

            break;

        case 21:

            aux = "$";
            registerChar[0] = *aux;

            aux = "s";
            registerChar[1] = *aux;

            aux = "5";
            registerChar[2] = *aux;

            break;

        case 22:

            aux = "$";
            registerChar[0] = *aux;

            aux = "s";
            registerChar[1] = *aux;

            aux = "6";
            registerChar[2] = *aux;

            break;

        case 23:

            aux = "$";
            registerChar[0] = *aux;

            aux = "s";
            registerChar[1] = *aux;

            aux = "7";
            registerChar[2] = *aux;

            break;

        case 24:

            aux = "$";
            registerChar[0] = *aux;

            aux = "t";
            registerChar[1] = *aux;

            aux = "8";
            registerChar[2] = *aux;

            break;

        case 25:

            aux = "$";
            registerChar[0] = *aux;

            aux = "t";
            registerChar[1] = *aux;

            aux = "9";
            registerChar[2] = *aux;

            break;

        case 26:

            aux = "$";
            registerChar[0] = *aux;

            aux = "k";
            registerChar[1] = *aux;

            aux = "0";
            registerChar[2] = *aux;

            break;

        case 27:

            aux = "$";
            registerChar[0] = *aux;

            aux = "k";
            registerChar[1] = *aux;

            aux = "1";
            registerChar[2] = *aux;

            break;

        case 28:

            aux = "$";
            registerChar[0] = *aux;

            aux = "g";
            registerChar[1] = *aux;

            aux = "p";
            registerChar[2] = *aux;

            break;

        case 29:

            aux = "$";
            registerChar[0] = *aux;

            aux = "s";
            registerChar[1] = *aux;

            aux = "p";
            registerChar[2] = *aux;

            break;

        case 30:

            aux = "$";
            registerChar[0] = *aux;

            aux = "f";
            registerChar[1] = *aux;

            aux = "p";
            registerChar[2] = *aux;

            break;

        case 31:

            aux = "$";
            registerChar[0] = *aux;

            aux = "r";
            registerChar[1] = *aux;

            aux = "a";
            registerChar[2] = *aux;

            break;

    }

}

void instructionR(char *instruction) {

    char opcodeChar[OPCODE_LENGHT];
    char rsChar[RS_LENGHT];
    char rtChar[RT_LENGHT];
    char rdChar[RD_LENGHT];
    char shamtChar[SHAMT_LENGHT];
    char functChar[FUNCT_LENGHT];
    char registerChar[5];

    int opcode;
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

    opcode = binaryToDecimal(opcodeChar, OPCODE_LENGHT);
    rs = binaryToDecimal(rsChar, RS_LENGHT);
    rt = binaryToDecimal(rtChar, RT_LENGHT);
    rd = binaryToDecimal(rdChar, RD_LENGHT);
    shamt = binaryToDecimal(shamtChar, SHAMT_LENGHT);
    funct = binaryToDecimal(functChar, FUNCT_LENGHT);

    printf ("opcode = %s (%d)\n", opcodeChar, opcode);
    getRegisterChar(registerChar, rs);
    printf ("rs = %s (%d) (%s)\n", rsChar, rs, registerChar);
    getRegisterChar(registerChar, rt);
    printf ("rt = %s (%d) (%s)\n", rtChar, rt, registerChar);
    getRegisterChar(registerChar, rd);
    printf ("rd = %s (%d) (%s)\n", rdChar, rd, registerChar);
    printf ("shamt = %s (%d)\n", shamtChar, shamt);
    printf ("funct = %s (%d)\n", functChar, funct);

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

            jr(rs);

            break;

        case 12:

            printf("%s\n", "syscall");

            // register $a0
            SDL_Delay(registers[4]);

            break;

        case 32:

            printf("%s\n", "add");

            add(rs, rt, rd);

            break;

        case 33:

            // addu o move

            // addu
            if(rt == 28) {

                printf("%s\n", "addu");

                // register $v0
                if(rs == 2) {

                    // draw point
                    if((pc >= 429) & (pc < 434)) {

                        drawPoint(renderer, pixelArray, registers[5], registers[4], registers[6]);

                    // draw paddle
                    } else if((pc >= 364) & (pc < 373)) {

                        srl(9, 9, 6);

                        drawPoint(renderer, pixelArray, registers[9], registers[4], registers[6]);

                    }

                // register $t1
                } else if(rs == 9) {

                    // register $t1
                    clearBoard(renderer, pixelArray, registers[9]);

                }

            // move
            } else if(rs == 0) {

                printf("%s\n", "move");

                move(rt, rd);

            // addu
            } else {

                printf("%s\n", "addu");

                addu(rs, rt, rd);

            }

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

            and(rs, rt, rd);

            break;

        case 37:

            printf("%s\n", "or");

            or(rs, rt, rd);

            break;

        case 38:

            printf("%s\n", "xori");

            xori(rs, rt, rd);

            break;

        case 39:

            printf("%s\n", "nor");

            nor(rs, rt, rd);

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
    char registerChar[5];

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

    // negative number
    if(isNegative(immediateChar) == 1) {

        complement2(immediateChar, IMMEDIATE_LENGHT);

        immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

    } else {

        immediate = binaryToDecimal(immediateChar, IMMEDIATE_LENGHT);

    }

    printf ("opcode = %s (%d)\n", opcodeChar, opcode);
    getRegisterChar(registerChar, rs);
    printf ("rs = %s (%d) (%s)\n", rsChar, rs, registerChar);
    getRegisterChar(registerChar, rt);
    printf ("rt = %s (%d) (%s)\n", rtChar, rt, registerChar);
    printf ("immediate = %s (%d)\n", immediateChar, immediate);

    switch(opcode) {

        case 4:

            printf("%s\n", "beq");

            // key 1
            if((keyPressed == KEY_1) & ((pc >= 210) & (pc < 214))) {

                registers[9] = 49;

                beq(rs, rt, immediate);

                keyPressed = 0;

            // key 2
            } else if((keyPressed == KEY_2) & ((pc >= 214) & (pc < 218))) {

                registers[9] = 50;

                beq(rs, rt, immediate);

                keyPressed = NO_KEY;

            } else {

                beq(rs, rt, immediate);

            }

            break;

        case 5:

            printf("%s\n", "bne");

            bne(rs, rt, immediate);

            break;

        case 6:

            printf("%s\n", "blez");

            // register $t1
            if(rs == 9) {

                // check if a key has been pressed
                if((keyPressed == KEY_A) | (keyPressed == KEY_Z) |
                   (keyPressed == KEY_K) | (keyPressed == KEY_M)) {

                    // register $t1
                    registers[9] = 1;

                }

            }

            blez(rs, immediate);

            break;

        case 8:

            printf("%s\n", "addi");

            // reserve or free space in the stack
            if(rs == STACK_POINTER_POSITION && rt == STACK_POINTER_POSITION) {

                immediate /= 4;

            }

            addi(rs, rt, immediate);

            break;

        case 9:

            // addiu o li
            printf("%s\n", "li");

            addiu(rs, rt, immediate);

            break;

        case 10:

            printf("%s\n", "slti");

            slti(rs, rt, immediate);

            break;

        case 11:

            printf("%s\n", "sltiu");

            sltiu(rs, rt, immediate);

            break;

        case 12:

            printf("%s\n", "andi");

            andi(rs, rt, immediate);

            break;

        case 13:

            printf("%s\n", "ori");

            // 0x01000000
            if((pc == 305) | (pc ==331) |
               (pc == 464) | (pc == 474)) {

                li(rt, UP);

            // 0x02000000
            } else if((pc == 308) | (pc == 328) |
                      (pc == 469) | (pc == 479)) {

                li(rt, DOWN);

            } else {

                registers[rt] = immediate;

            }

            break;

        case 15:

            printf("%s\n", "lui");

            //must be ignored
            //lui(rs, rt, immediate);

            break;

        case 35:

            printf("%s\n", "lw");

            // key pressed or data instruction
            if(rs == 1) {

                // data instruction
                if(pc == 320) {

                    // register $t1
                    registers[9] = -1;

                } else if(pc == 460) {

                    // register $t1
                    registers[rt] = keyPressed;

                } else {

                    immediate /= 4;

                    li(rt, dataInstructions[immediate]);

                }

            // stack use
            } else if(rs == 29) {

                lw(rs, rt, immediate);

            }

            break;

        case 36:

            printf("%s\n", "lbu");

            lbu(rs, rt, immediate);

            break;

        case 37:

            printf("%s\n", "lhu");

            lhu(rs, rt, immediate);

            break;

        case 40:

            printf("%s\n", "sb");

            sb(rs, rt, immediate);

            break;

        case 41:

            printf("%s\n", "sh");

            sh(rs, rt, immediate);

            break;

        case 43:

            printf("%s\n", "sw");

            // clear button pressed
            if(pc == 324) {

                keyPressed = NO_KEY;


            // reset
            } else if((pc == 707) | (pc == 709)) {

                immediate /= 4;

                dataInstructions[immediate] = registers[rt];

            // cannot overwrite register $zero
            } else if(rt != 0) {

                // data instruction
                if(rs == 1) {

                    immediate /= 4;

                    dataInstructions[immediate] = registers[rt];

                // $v0 as destiny register
                } else if(rs == 2) {

                    move(rt, rs);

                // stack use
                } else {

                    sw(rs, rt, immediate);

                }

            }

            break;

        case 48:

            printf("%s\n", "ll");

            ll(rs, rt, immediate);

            break;

        case 56:

            printf("%s\n", "sc");

            sc(rs, rt, immediate);

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
    sliceInstruction(instruction, addressChar, 12, 32);

    opcode = binaryToDecimal(opcodeChar, OPCODE_LENGHT);
    address = binaryToDecimal(addressChar, ADDRESS_LENGHT - ADDRESS_LENGHT_ADJUSTMENT);

    printf ("opcode = %s (%d)\n", opcodeChar, opcode);
    printf ("address = %s (%d)\n", addressChar, address);

   switch(opcode) {

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

void createPixels(SDL_Rect *pixelArray, int rows, int columns) {

    int ptr = 0;

    for(int i = 0; i < rows; i++) {

        for(int j = 0; j < columns; j++) {

            SDL_Rect rectangle;

            rectangle.x = 0 + (j * 8);
            rectangle.y = 0 + (i * 8);
            rectangle.w = 8;
            rectangle.h = 8;

            pixelArray[ptr] = rectangle;

            ptr++;

        }

    }

}

void showPixels(SDL_Renderer *renderer, SDL_Rect *pixelArray, int arraySize) {

    for (int i = 0; i < arraySize; i++) {

        SDL_RenderFillRect(renderer, &pixelArray[i]);

    }

}

int main (int argc, char **argv) {

    // reading text file
    char **textInstructions;

    int nptrs = NUMBER_POINTERS;

    int textInstructionsSize = 0;

    char buffer[MAX_CHARACTERS];

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

    // creating memory array
    memory = malloc(MEMORY_SIZE * sizeof(int));

    // stack pointer must be positioned at the end of the memory array
    registers[STACK_POINTER_POSITION] = 2000;

    keyPressed = NO_KEY;

    // Window creation
    SDL_Init(SDL_INIT_VIDEO);

	SDL_Window *window = SDL_CreateWindow("MARS MIPS EMULATOR", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);

	renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

    //SDL_Rect *pixelArray;
    pixelArray = (SDL_Rect*)malloc(PIXEL_ARRAY_SIZE * sizeof(SDL_Rect));

    createPixels(pixelArray, PIXEL_ARRAY_ROW_SIZE, PIXEL_ARRAY_COLUMN_SIZE);

    int initRunning = 1;

    SDL_Event event;

    // Infinite loop
    while(initRunning) {

        while(SDL_PollEvent(&event)) {

            switch(event.type) {

                case SDL_QUIT:

                    initRunning = 0;

                    break;

                case SDL_KEYDOWN:

                    // Start game
                    if (event.key.keysym.sym == SDLK_RETURN) {

                        // text instructions execution
                        while(pc < textInstructionsSize) {

                            pc++;

                            // check if a key has been pressed
                            while(SDL_PollEvent(&event)) {

                                // key 1 pressed
                                if ((event.key.keysym.sym == SDLK_1) |
                                    (event.key.keysym.sym == SDLK_KP_1)) {

                                    keyPressed = KEY_1;

                                // key 2 pressed
                                } else if ((event.key.keysym.sym == SDLK_2) |
                                           (event.key.keysym.sym == SDLK_KP_2)) {

                                    keyPressed = KEY_2;

                                // key a pressed
                                } else if (event.key.keysym.sym == SDLK_a) {

                                    keyPressed = KEY_A;

                                // key z pressed
                                } else if (event.key.keysym.sym == SDLK_z) {

                                    keyPressed = KEY_Z;

                                // key k pressed
                                } else if (event.key.keysym.sym == SDLK_k) {

                                    keyPressed = KEY_K;

                                // key m pressed
                                } else if (event.key.keysym.sym == SDLK_m) {

                                    keyPressed = KEY_M;

                                }

                            }

                            printf ("pc = %d\n", pc);

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

                                instructionR(instruction);

                            // J instruction
                            } else if(strcmp(opcode, "000010") == 0 || strcmp(opcode, "000011") == 0) {

                                printf ("Type J\n");

                                instructionJ(instruction);

                                pc--;

                            // I instruction
                            } else {

                                printf ("Type I\n");

                                instructionI(instruction);

                            }

                            // reset $zero
                            registers[0] = 0;

                        }

                        initRunning = 0;

                    }

                    break;

            }

        }

        // Clear window
        SDL_RenderClear(renderer);

        // Light blue color
        //SDL_SetRenderDrawColor(renderer, 0, 102, 204, 0);

        // Draw rectangles
        showPixels(renderer, pixelArray, PIXEL_ARRAY_SIZE);

        // Show what was drawn
        SDL_RenderPresent(renderer);

    }

    // Free memory
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    free(textInstructions);

    free(dataInstructionsAux);

    free(dataInstructions);

    free(memory);

    return 0;

}
