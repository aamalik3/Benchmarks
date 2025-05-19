#include <stdio.h>
#include <string.h>
#include "nw.h"

int main() {
    // Define the test harness structure and initialize it
    struct bench_args_t test_data;
    memset(&test_data, 0, sizeof(struct bench_args_t));

    // Open the input.data file for reading
    FILE *input_file = fopen("input.data", "r");
    if (input_file == NULL) {
        perror("Error opening input.data");
        return 1;
    }



    // Read sequence A from the file, removing the newline character
    if (fgets(test_data.seqA, ALEN + 1, input_file) == NULL) {
        fprintf(stderr, "Error reading seqA from input.data\n");
        fclose(input_file);
        return 1;
    }
    test_data.seqA[strcspn(test_data.seqA, "\n")] = '\0';


    // Read sequence B from the file, removing the newline character
    if (fgets(test_data.seqB, BLEN + 1, input_file) == NULL) {
        fprintf(stderr, "Error reading seqB from input.data\n");
        fclose(input_file);
        return 1;
    }
    test_data.seqB[strcspn(test_data.seqB, "\n")] = '\0';

    // Close the input file
    fclose(input_file);

    // Call the sequence alignment function
    needwun(test_data.seqA, test_data.seqB, test_data.alignedA, test_data.alignedB, test_data.M, test_data.ptr);

    // Print the aligned sequences
    printf("Aligned Sequence A: %s\n", test_data.alignedA);
    printf("Aligned Sequence B: %s\n", test_data.alignedB);

    return 0;
}

