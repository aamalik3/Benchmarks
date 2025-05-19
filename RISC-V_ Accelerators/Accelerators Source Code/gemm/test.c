#include <stdio.h>
#include "gemm.h"

int main() {
    // Define the matrices and product
    TYPE m1[N], m2[N], prod[N];

    // Read input data from a file
    FILE *input_file = fopen("input.data", "r");
    if (input_file == NULL) {
        perror("Error opening input.data");
        return 1;
    }

    // Read values from the input file and populate m1 and m2
    for (int i = 0; i < N; i++) {
        if (fscanf(input_file, "%lf", &m1[i]) != 1) {
            fprintf(stderr, "Error reading m1[%d] from input.data\n", i);
            return 1;
        }
        //printf("Read m1[%d] = %lf\n", i, m1[i]); // Debugging output
    }
	for (int i = 0; i < N; i++) {
	    if (fscanf(input_file, "%lf", &m2[i]) != 1) {
		fprintf(stderr, "Error reading m2[%d] from input.data\n", i);
		return 1;
	    }
    //printf("Read m2[%d] = %lf\n", i, m2[i]); // Debugging output
}	


    // Close the input file
    fclose(input_file);

    // Initialize prod to zero
    for (int i = 0; i < N; i++) {
        prod[i] = 0.0;
    }

    // Call the bbgemm function
    bbgemm(m1, m2, prod);

    // Print the result
    printf("Product matrix:\n");
    for (int i = 0; i < row_size; i++) {
        for (int j = 0; j < row_size; j++) {
            printf("%lf ", prod[i * row_size + j]);
        }
        printf("\n");
    }

    return 0;
}

