#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#define SIZE 1
int main(int argc, char *argv[])
{
    
	char buf[SIZE];
	FILE * src, * dst;
	char * fileName = argv[1];

    if(fileName == "")
    {
        printf("No file provided in program arguments");
    }
	
	
	char * outFile = malloc(strlen(fileName) + strlen(".red") + 1);
	strcpy(outFile, fileName);
	
	strcat(outFile, ".red");
	
	src = fopen(fileName, "r");
	dst = fopen(outFile, "w");

	if (!src || !dst)
	{
		printf("Cannot open file");
		exit(1);
	}

	int i = 1;
    int c;

	    fclose(src);
	    fclose(dst);

}
