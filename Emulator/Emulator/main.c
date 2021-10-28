#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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





// Global variables
int PC = 0;
























/*

int add(int rs, int rs) {

    int rd = 0;

    ...

    return rd;

}



int sub(inta, int b..) {}

*/






void sliceInstruction(char *instruction, char *slice, int start, int end) {

    int j = 0;

    for (int i = start; i < end; i++) {

        slice[j] = instruction[i];

        j++;

    }

}

void instructionR(char *instruction) {

    char opcode[OPCODE_LENGHT];
    char rs[RS_LENGHT];
    char rt[RT_LENGHT];
    char rd[RD_LENGHT];
    char shamt[SHAMT_LENGHT];
    char funct[FUNCT_LENGHT];

    sliceInstruction(instruction, opcode, 0, 6);
    sliceInstruction(instruction, rs, 6, 11);
    sliceInstruction(instruction, rt, 11, 16);
    sliceInstruction(instruction, rd, 16, 21);
    sliceInstruction(instruction, shamt, 21, 26);
    sliceInstruction(instruction,funct, 26, 32);

    printf ("opcode = %s\n", opcode);
    printf ("rs = %s\n", rs);
    printf ("rt = %s\n", rt);
    printf ("rd = %s\n", rd);
    printf ("shamt = %s\n", shamt);
    printf ("funct = %s\n\n", funct);

}

void instructionI(char *instruction) {

    char opcode[OPCODE_LENGHT];
    char rs[RS_LENGHT];
    char rt[RT_LENGHT];

    //char immediate[IMMEDIATE_LENGHT]; //-------> GENERA PROBLEMA Y NO SE POR QUE
    char immediate[16];

    sliceInstruction(instruction, opcode, 0, 6);
    sliceInstruction(instruction, rs, 6, 11);
    sliceInstruction(instruction, rt, 11, 16);
    sliceInstruction(instruction, immediate, 16, 32);

    printf ("opcode = %s\n", opcode);
    printf ("rs = %s\n", rs);
    printf ("rt = %s\n", rt);
    printf ("immediate = %s\n\n", immediate);

}

void instructionJ(char *instruction) {

    char opcode[OPCODE_LENGHT];
    char address[ADDRESS_LENGHT];

    sliceInstruction(instruction, opcode, 0, 6);
    sliceInstruction(instruction, address, 6, 32);

    printf ("opcode = %s\n", opcode);
    printf ("address = %s\n\n", address);

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
    while(PC < textInstructionsSize) {

        char *instruction;

        instruction = textInstructions[PC];

        char opcode[OPCODE_LENGHT];

        // getting opcode from instruction
        for(int i = 0; i < OPCODE_LENGHT; i++) {

            opcode[i] = instruction[i];

        }

        // R instruction
        if(strcmp(opcode, "000000") == 0) {

            //printf ("PC = %d\n", PC);

            //instructionR(instruction);

        // J instruction
        } else if(strcmp(opcode, "000010") == 0 || strcmp(opcode, "000011") == 0) {

            printf ("PC = %d\n", PC);

            instructionJ(instruction);

        // I instruction
        } else {

            //printf ("PC = %d\n", PC);

            //instructionI(instruction);

        }

























        PC++;

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























