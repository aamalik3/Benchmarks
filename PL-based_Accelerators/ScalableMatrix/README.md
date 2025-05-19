Provided in this folder is a IP for a Scalable Matrix along with a testbench for it. 

When you open the file you will see local parameters, there is only one parameter (shown by the comments) that you should update, this will help determine the length and width of each matrix you are multiplying.
#### The Matricies MUST be a square matrix, and the two matricies you are multiplying must be the same size for this IP 

There are also Block RAM (BRAM) components inside of the IP. You will need to add a '.coe' file within these BRAMS for the IP to work as intended. 

Once these are loaded you can simulate the IP.

### Help
Make sure that you provide an accurate bit size for values, if you provide a size smaller than those in the '.coe' file, the simulator will show the ports in an unknown state.
