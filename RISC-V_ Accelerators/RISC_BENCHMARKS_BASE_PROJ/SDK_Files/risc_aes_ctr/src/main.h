/*
 * constants.h
 *
 *  Created on: Feb 6, 2023
 *      Author: aamalik3
 */

/**************************** Type Definitions *******************************/

#define DDR_MEMORY_LOCATION 0x00200000
#define MSB_DUMP_LOCATION 	0x00300000
#define LSB_DUMP_LOCATION 	0x00500000
#define FAR_1 				0x0042239F
#define FAR_2 				0x0042231F
//#define FRAME_2_START		0x000003AC+2+11
//#define elements			1752-35//276-6
#define Frame_Data_Location	0x00000074
#define FRAME_2_START		0x000003E0
//#define FILE_M				"RAP0D.bin"//RAP.bin"
#define FILE_M				/*"RAP1M.bin" "RAP0D.bin"*/"RAP.bin"
#define FILE_M_SIZE			 (1481580)/4	//7446 this is size of the file (not size on disk)
#define FILE_L				/*"RAP1M.bin" "RAP0D.bin"*/"RAP.bin"
//#define FILE_L				"RAP0D.bin"//RAP.bin"
#define FILE_L_SIZE			 (1481580)/4 	//6916
#define TEMPLATE_SIZE		 (984)/4 	//2660
//#define SWAP_ON		 		0x00000001
#define F_TEMPLATE			"Frame.hex"

#define DELAY_DURATION		0001000000
#define PL_CLK0 			0xF8000178
#define PL_CLK1 			0xF8000188
#define PL_CLK2 			0xF8000198
#define PL_CLK3 			0xF80001A8

#define BRAM_MASK 			0xFFFDFFFF
#define elements			(sizeof(FAR_ARRAY) / sizeof(FAR_ARRAY[0]))
//int elements;
/**************************** Type Definitions *******************************/
