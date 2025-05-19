#include <stdio.h>
#include <string.h>
#include "kmp.h"

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
/*
    // Read the pattern from the first line of the file
    if (fgets(test_data.pattern, PATTERN_SIZE, input_file) == NULL) {
        fprintf(stderr, "Error reading the pattern from input.data\n");
        fclose(input_file);
        return 1;
    }
*/
    // Read the input text from the second line of the file
    if (fgets(test_data.input, STRING_SIZE, input_file) == NULL) {
        fprintf(stderr, "Error reading the input text from input.data\n");
        fclose(input_file);
        return 1;
    }

    // Close the input file
    fclose(input_file);
	memcpy(test_data.pattern, "States", 6);
    // Call the KMP function
    kmp(test_data.pattern, test_data.input, test_data.kmpNext, test_data.n_matches);

    // Print the number of matches
    printf("Number of matches: %d\n", test_data.n_matches[0]);

    return 0;
}

