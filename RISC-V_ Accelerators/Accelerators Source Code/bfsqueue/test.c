/*
#include <stdio.h>
#include "bfs.h"

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

    // Read the nodes and edges from the file
    for (node_index_t i = 0; i < N_NODES; i++) {
        if (fread(&test_data.nodes[i], sizeof(node_t), 1, input_file) != 1) {
            fprintf(stderr, "Error reading nodes[%ld] from input.data\n", i);
            fclose(input_file);
            return 1;
        }
    }

    for (edge_index_t i = 0; i < N_EDGES; i++) {
        if (fread(&test_data.edges[i], sizeof(edge_t), 1, input_file) != 1) {
            fprintf(stderr, "Error reading edges[%ld] from input.data\n", i);
            fclose(input_file);
            return 1;
        }
    }

    // Read the starting node and level counts
    if (fread(&test_data.starting_node, sizeof(node_index_t), 1, input_file) != 1) {
        fprintf(stderr, "Error reading starting_node from input.data\n");
        fclose(input_file);
        return 1;
    }

    if (fread(&test_data.level_counts, sizeof(edge_index_t), N_LEVELS, input_file) != N_LEVELS) {
        fprintf(stderr, "Error reading level_counts from input.data\n");
        fclose(input_file);
        return 1;
    }

    // Close the input file
    fclose(input_file);

    // Call the BFS function
    bfs(test_data.nodes, test_data.edges, test_data.starting_node, test_data.level, test_data.level_counts);

    // Print the results or perform any desired post-processing
    // For example, you can print the level counts.
    printf("Level Counts: ");
    for (int i = 0; i < N_LEVELS; i++) {
        printf("%" PRId64 " ", test_data.level_counts[i]);
    }
    printf("\n");

    return 0;
}
*/
