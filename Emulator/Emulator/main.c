#include <stdio.h>
#include <stdlib.h>
#include <string.h>



#include <sys/stat.h>





//#define MAXC 1024       /* if you need a constant, #define one (or more) */
//#define NPTRS   2






// Constants
const int MAX_CHARACTERS = 1024;
const int NUMBER_POINTERS = 2;

const int OPCODE_LENGHT = 6;



typedef struct {

    char *line;

} Instruction;





void instructionR () {

}

void instructionI () {

}

void instructionJ () {

}
















/*
int fileSize(char* file) {

    FILE *fp = fopen(file, "r");

    int size = 0;

    if (fp != NULL) {

        char buffer[LINE_LENGTH];
        //char *buffer;

        // read file line by line
        while(fgets(buffer, LINE_LENGTH, fp)) {

            size++;

        }

    } else {

        printf("Error: could not open text file %s", file);

    }

    // close the file
    fclose(fp);

    return size;

}


void readDataFile(char *file) {

    FILE *fp = fopen(file, "r");

    if (fp != NULL) {

        // read file line by line
        const unsigned MAX_LENGTH = 256;

        char buffer[MAX_LENGTH];

        while(fgets(buffer, MAX_LENGTH, fp)) {

            printf("%s", buffer);

        }

    } else {

        printf("Error: could not open data file %s", file);

    }

    // close the file
    fclose(fp);

}


void readTextFile(char *file, int size, Instruction *textFileArray) {

    FILE *fp = fopen(file, "r");

    int i = 0;

    if (fp != NULL) {

        char buffer[LINE_LENGTH];
        //char *buffer;

        // read file line by line
        while(fgets(buffer, LINE_LENGTH, fp)) {

            Instruction instruction;

            instruction.line = buffer;

            textFileArray[i] = instruction;

            i++;

        }

    } else {

        printf("Error: could not open text file %s", file);

    }

    // close the file
    fclose(fp);

}
*/






void printLines(char **lines, int stored) {


    for (size_t i = 0; i < stored; i++) {
        printf ("line[%3zu] : %s\n", i, lines[i]);

    }



}
















int main() {

    /*
    // read data file
    char *dataFile = "pongData.txt";
    readDataFile(dataFile);


    // read text file
    //char *textFile = "pongText.txt";

    //int size = fileSize(textFile);

    //Instruction *textFileCode;
    //textFileCode = (Instruction*)malloc(size * sizeof(Instruction));

    //char textFileCode[size][LINE_LENGTH];

    //char **textFileCodePtr = &textFileCode;

    //char *textFileCode;
    //textFileCode = (char*)malloc(size * (char*)malloc(size * sizeof(char)));

    //textFileCode [size][LINE_LENGTH];

    //Instruction *textFileArray;
    //textFileArray = (Instruction*)malloc(size * sizeof(Instruction));

    //readTextFile(textFile, size, textFileArray);




    // reading text file
    char *textFile = "pongText.txt";

    int size = fileSize(textFile);

    char textFileArray[size][LINE_LENGTH];

    FILE *fp = fopen(textFile, "r");

    //int i = 0;

    if (fp != NULL) {

        printf("holiiii");

        char line[LINE_LENGTH];

        // read file line by line
        while(fgets(line, LINE_LENGTH, fp)) {

            int j = 0;

            while(line[j] != '\n') {

                textFileArray[i][j] = line[j];

                j++;

            }

            printf("%s", line);

            i++;



            printf("%s", line);

        }

    } else {

        printf("Error: could not open text file %s", textFile);

    }

    // close the file
    fclose(fp);

    //free(textFileArray);

    return 0;

    */












    char buffer[MAX_CHARACTERS];
    char **lines;

    int nptrs = NUMBER_POINTERS;
    int stored = 0;

    char *textFile = "pongText.txt";

    FILE *fp = fopen(textFile, "r");

    if (!fp) {

        perror("file open failed");

        return 1;

    } else if ((lines = malloc(nptrs * sizeof *lines)) == NULL) {

        perror("malloc-lines");

        exit (EXIT_FAILURE);

    }

    while (fgets(buffer, MAX_CHARACTERS, fp)) {

        int size;

        buffer[(size = strcspn (buffer, "\n"))] = 0;

        if (stored == nptrs) {

            void *tmp = realloc(lines, (2 * nptrs) * sizeof *lines);

            if (!tmp) {

                perror ("realloc-lines");

                break;

            }

            lines = tmp;

            nptrs *= 2;

        }

        if (!(lines[stored] = malloc (size + 1))) {

            perror ("malloc-lines[used]");

            break;

        }

        memcpy (lines[stored], buffer, size + 1);

        stored += 1;

    }

    if (fp != stdin) {

        fclose (fp);

    }



    printLines(lines, stored);









    // free memory
    for (size_t i = 0; i < stored; i++) {
        //printf ("line[%3zu] : %s\n", i, lines[i]);
        free (lines[i]);
    }

    free (lines);

}























