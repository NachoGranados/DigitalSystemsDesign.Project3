#include <stdio.h>
#include <stdlib.h>

int main() {

    char *filename = "pongText.txt";
    //char *filename = "pongData.txt";

    FILE *fp = fopen(filename, "r");

    if (fp == NULL) {

        printf("Error: could not open file %s", filename);

        return 1;

    }

    // reading line by line, max 256 bytes
    const unsigned MAX_LENGTH = 256;
    char buffer[MAX_LENGTH];

    while (fgets(buffer, MAX_LENGTH, fp)) {

        printf("%s", buffer);

    }

    // close the file
    fclose(fp);

    return 0;

}
