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

        pc = pc + 1 + SignExtImm;

    }

}

void bne(int rs, int rt, int SignExtImm) {

    if(registers[rs] != registers[rt]) {

        pc = pc + 1 + SignExtImm;

    }

}

void j(int JumpAddr) {

    pc = JumpAddr;

}

void jal(int JumpAddr) {

    registers[31] = pc + 2;

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

    int aux = registers[rt] * (2 * shamt);

    registers[rd] = aux;

}

void srl(int rt, int rd, int shamt) {

    int aux = registers[rt] / (2 * shamt);

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

void li(int rt, int immediate) {

    registers[rt] = immediate;

}

void move(int rs, int rd) {

    registers[rd] = registers[rs];

}

void xori(int rs, int rt, int SignExtImm) {

    if(registers[rs] == SignExtImm) {

        registers[rt] = 0;

    } else {

        registers[rt] = 1;

    }

}

void syscallWait() {

   // register $a0
   int miliseconds = registers[4];

   clock_t end_time;

   end_time = clock() + miliseconds * CLOCKS_PER_SEC / 1000;

   while (clock() < end_time) {

      //blank loop for waiting

   }

}

void instructionR(char *instruction) {

    char opcodeChar[OPCODE_LENGHT];
    char rsChar[RS_LENGHT];
    char rtChar[RT_LENGHT];
    char rdChar[RD_LENGHT];
    char shamtChar[SHAMT_LENGHT];
    char functChar[FUNCT_LENGHT];

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
    printf ("rs = %s (%d)\n", rsChar, rs);
    printf ("rt = %s (%d)\n", rtChar, rt);
    printf ("rd = %s (%d)\n", rdChar, rd);
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

            //jr(rs);

            break;

        case 12:

            printf("%s\n", "syscall");

            syscallWait();

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

            and(rs, rt, rd);

            break;

        case 37:

            printf("%s\n", "or");

            or(rs, rt, rd);

            break;

        // aux method for ori
        case 38:

            printf("%s\n", "xori");

            ori(rs, rt, rd);

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

    printf ("opcode = %s (%d)\n", opcodeChar, opcode);
    printf ("rs = %s (%d)\n", rsChar, rs);
    printf ("rt = %s (%d)\n", rtChar, rt);
    printf ("immediate = %s (%d)\n", immediateChar, immediate);

    switch(opcode){

        case 4:

            printf("%s\n", "beq");

            // negative number
            if(isNegative(immediateChar) == 1) {

                complement2(immediateChar, IMMEDIATE_LENGHT);

                immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

            }

            //beq(rs, rt, immediate);

            break;

        case 5:

            printf("%s\n", "bne");

            // negative number
            if(isNegative(immediateChar) == 1) {

                complement2(immediateChar, IMMEDIATE_LENGHT);

                immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

            }

            //bne(rs, rt, immediate);

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

            // negative number
            if(isNegative(immediateChar) == 1) {

                complement2(immediateChar, IMMEDIATE_LENGHT);

                immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

            }

            andi(rs, rt, immediate);

            break;

        case 13:

            printf("%s\n", "ori");

            registers[rt] = immediate;

            break;

        case 15:

            printf("%s\n", "lui");

            // must be ignored

            /*

            // negative number
            if(isNegative(immediateChar) == 1) {

                complement2(immediateChar, IMMEDIATE_LENGHT);

                immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

            }

            lui(rs, rt, immediate);

            */

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

            lbu(rs, rt, immediate);

            break;

        case 37:

            printf("%s\n", "lhu");

            // negative number
            if(isNegative(immediateChar) == 1) {

                complement2(immediateChar, IMMEDIATE_LENGHT);

                immediate = -1 * (binaryToDecimal(immediateChar, IMMEDIATE_LENGHT) + 1);

            }

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
    address = binaryToDecimal(addressChar, ADDRESS_LENGHT);

    printf ("opcode = %s (%d)\n", opcodeChar, opcode);
    printf ("address = %s (%d)\n", addressChar, address);

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

    // Window creation
    SDL_Init(SDL_INIT_VIDEO);

	SDL_Window *window = SDL_CreateWindow("MARS MIPS EMULATOR", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);

	SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

    SDL_Rect *pixelArray;
    pixelArray = (SDL_Rect*)malloc(PIXEL_ARRAY_SIZE * sizeof(SDL_Rect));

    createPixels(pixelArray, PIXEL_ARRAY_ROW_SIZE, PIXEL_ARRAY_COLUMN_SIZE);

    int running = 1;

    SDL_Event event;

    // Infinite loop
    while(running) {

        while(SDL_PollEvent(&event)) {

            if(event.type == SDL_QUIT) {

                running = 0;

            }

        }

        // black background
        SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);

        // Clear window
        SDL_RenderClear(renderer);



        // Light blue color
        SDL_SetRenderDrawColor(renderer, 0, 102, 204, 0);

        // Draw rectangles
        showPixels(renderer, pixelArray, PIXEL_ARRAY_SIZE);





        // Show what was drawn
        SDL_RenderPresent(renderer);

    }

    // Free memory
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    //return 0;



















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

    // creating memory array
    memory = malloc(MEMORY_SIZE * sizeof(int));

    // global pointer must be positioned at the start of the memory array
    registers[DYNAMIC_DATA_POINTER_POSITION] = 0;

    // stack pointer must be positioned at the end of the memory array
    registers[STACK_POINTER_POSITION] = 1999;

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

        if(pc > 1) {

            pc = 4444;

        }


        */


        /*
        int testInteger;
        printf("Continue:");
        scanf("%d", &testInteger);
        printf("\n");
        */

    }

    /*
    // free memory
    for (size_t i = 0; i < textInstructionsSize; i++) {

        free(textInstructions[i]);

    }
    */

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

    return 0;



















}

/*


    7fff fffc => 2147483644

    1000 8000h => 268468224

    2147483644 - 268468224 = 1879015420

    1879015420 / 4 = 469753855



    000011 00000100000000001001010110

    1049174 / 4 = 262293



    000001 00000000000000000000 => j NewGame

    000001 00000000001001010110 => j ClearBoard

    000001 00000000001011000010 => j Reset















    lw $t4, yDir
    xori $t4, $t4, 0xffffffff
    addi $t4, $t4, 1
    sw $t4, yDir





    Type I
    pc = 589
    opcode = 001111
    rs = 00000
    rt = 00001
    immediate = 0001000000000001
    lui => X

    Type I
    pc = 590
    opcode = 100011
    rs = 00001
    rt = 01100
    immediate = 0000000000001000
    lw => lw $t4, yDir

    Type I
    pc = 591
    opcode = 001111
    rs = 00000
    rt = 00001
    immediate = 1111111111111111
    lui => X




    xori $t4, $t4, 0xffffffff

    Type I
    pc = 592
    opcode = 001101 => Type I
    rs = 00001 => $at
    rt = 00001 => $at
    immediate = 1111111111111111 => ffff
    ori =>

    Type R
    pc = 593
    opcode = 000000 => Type R
    rs = 01100 => $t4
    rt = 00001 => $at
    rd = 01100 => $t4
    shamt = 00000 => X
    funct = 100110 => 26 hex






    Type I
    pc = 594
    opcode = 001000
    rs = 01100
    rt = 01100
    immediate = 0000000000000001
    addi

    Type I
    pc = 595
    opcode = 001111
    rs = 00000
    rt = 00001
    immediate = 0001000000000001
    lui

    Type I
    pc = 596
    opcode = 101011
    rs = 00001
    rt = 01100
    immediate = 0000000000001000
    sw














    #include <stdio.h>
    #include <stdlib.h>

    char *decimal_to_binary(int);

    int main()
    {
      int n;
      char *p;

      printf("Enter an integer in decimal number system\n");
      scanf("%d", &n);

      p = decimal_to_binary(n);
      printf("Binary string of %d is: %s\n", n, p);

      free(p);

      return 0;
    }

    char *decimal_to_binary(int n)
    {
      int c, d, t;
      char *p;

      t = 0;
      p = (char*)malloc(32+1);

      if (p == NULL)
        exit(EXIT_FAILURE);

      for (c = 31 ; c >= 0 ; c--)
      {
        d = n >> c;

        if (d & 1)
          *(p+t) = 1 + '0';
        else
          *(p+t) = 0 + '0';

        t++;
      }
      *(p+t) = '\0';

      return  p;
    }

















    Type I
    pc = 704
    opcode = 000100 (4)
    rs = 01000 (8)
    rt = 00000 (0)
    immediate = 1111111111111010 (65530)
    beq

    immediate = 1111111111111010 (65530)
                0000000000000101
                               1
                0000000000000110






    Type I
    pc = 646
    opcode = 000101 (5)
    rs = 00001 (1)
    rt = 01000 (8)
    immediate = 0000000000001101 (13)
    bne






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





    xori $t4, $t4, 0xffffffff

    Type I
    pc = 592
    opcode = 001101 => Type I
    rs = 00001 => $at
    rt = 00001 => $at
    immediate = 1111111111111111 => ffff
    ori =>

    Type R
    pc = 593
    opcode = 000000 => Type R
    rs = 01100 => $t4
    rt = 00001 => $at
    rd = 01100 => $t4
    shamt = 00000 => X
    funct = 100110 => 26 hex => 38 dec






    101011 00001 00000 0000000000000000
    sw $zero, 0xFFFF0000 => 323
    NO HACE NACE NADA

    sw $t1, mode
    101011 00001 01001 0000000000110100
    sw     $at   $t1   52








    xori $t4, $t4, 0xffffffff

    Type I
    pc = 592
    opcode = 001101 => Type I
    rs = 00001 => $at
    rt = 00001 => $at
    immediate = 1111111111111111 => ffff
    ori =>

    Type R
    pc = 593
    opcode = 000000 => Type R
    rs = 01100 => $t4
    rt = 00001 => $at
    rd = 01100 => $t4
    shamt = 00000 => X
    funct = 100110 => 26 hex => 38 dec






        rt     rs
    sw $ra, 0($sp)

    101011 11101 11111 0000000000000000
    opcode rs    rt    immediate










    xori $t4, $t4, 0xffffffff

    Type I
    pc = 592
    opcode = 001101 => Type I
    rs = 00001 => $at
    rt = 00001 => $at
    immediate = 1111111111111111 => ffff
    ori =>

    Type R
    pc = 593
    opcode = 000000 => Type R
    rs = 01100 => $t4
    rt = 00001 => $at
    rd = 01100 => $t4
    shamt = 00000 => X
    funct = 100110 => 26 hex => 38 dec









    lw $ra, 0($sp)

    100011 11101 11111 0000000000000000
    opcode rs    rt    immediate





    Type R
    pc = 701
    opcode = 000000 (0)
    rs = 00000 (0)
    rt = 00000 (0)
    rd = 00000 (0)
    shamt = 00000 (0)
    funct = 001100 (12)
    syscall















*/
