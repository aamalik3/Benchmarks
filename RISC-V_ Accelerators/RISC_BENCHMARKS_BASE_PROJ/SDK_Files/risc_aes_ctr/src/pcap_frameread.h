/***************************** Include Files *********************************/
#include "xparameters.h"
#include "xdevcfg.h"
#include "xil_cache.h"
#include "xil_io.h"
#include "sleep.h"
#include "main.h"
#include <stdbool.h>
/************************** Constant Definitions *****************************/
#define DCFG_DEVICE_ID		XPAR_XDCFG_0_DEVICE_ID
#define TOP      1 //0
#define BLOCK    0
#define HCLK     0
#define MAJOR    26//24 71
#define MINOR    34//0 26 34 35
#define FARADDRESS(TOP, BLOCK, HCLK, MAJOR, MINOR)(BLOCK << 23)|((TOP << 22)|(HCLK << 17)|(MAJOR << 7)|(MINOR << 0))
#define Words		101	/* No of Words in a Frame 7 Series Device */
#define FRAMES		2	/* No of Frames */
#define NUM_FRAME_WORDS Words*FRAMES
u32 readback_buffer [(NUM_FRAME_WORDS)<<1];
//u32 address= FARADDRESS(TOP, BLOCK, HCLK, MAJOR, MINOR);
//u32 address  = 0x0042171F;


/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

int XDcfgReadExample(u16 DeviceId,u32 address, bool print_on);
int XDcfg_GetConfigReg(XDcfg *InstancePtr,u32 address, u32 ConfigReg, u32 *RegData);
void PrintBitStream(u32 address, bool print_on);
int save_bitstream (u32 DDR_OFFSET , u32 OFFSET ,bool BRAM_FLIP);
/************************** Variable Definitions *****************************/

XDcfg DcfgInstance;		/* Device Configuration Interface Instance */

int read(u32 address, bool print_on)
{
//		print("PCAP Frame Read-back ");
		if(print_on == true){
			xil_printf("FAR Address : %08x\r\n",address);
		}
			int Status;
			Xil_DCacheDisable();
			Xil_ICacheDisable();

			Status = XDcfgReadExample(DCFG_DEVICE_ID,address,print_on);
			if (Status != XST_SUCCESS) {
				xil_printf("FPGA Read back Failed\r\n");
				return XST_FAILURE;
			}
//			address++;
			usleep(100000);
		if(print_on == true){
		xil_printf("FPGA Read back Complete\r\n");
		xil_printf("\n--------------------------------\n");
		}
		return XST_SUCCESS;
		Xil_ICacheEnable();
		Xil_DCacheEnable();

}

int XDcfgReadExample(u16 DeviceId,u32 address,bool print_on)
{
	int Status;
//	u32 Statusreg;
	unsigned int ValueBack;

	XDcfg_Config *ConfigPtr;
	XDcfg_ResetHw(DcfgInstance.Config.BaseAddr);
	/*
	 * Initialize the Device Configuration Interface driver.
	 */
	ConfigPtr = XDcfg_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
			return XST_FAILURE;
		}
	Status = XDcfg_CfgInitialize(&DcfgInstance, ConfigPtr,
					ConfigPtr->BaseAddr);
	XDcfg_SetLockRegister(&DcfgInstance, 0x757BDF0D);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	// Enable and select PCAP interface for partial reconfiguration
		XDcfg_EnablePCAP(&DcfgInstance);
	//Setting control register for PCAP mode
		XDcfg_SetControlRegister(&DcfgInstance, XDCFG_CTRL_PCAP_MODE_MASK);

	Status = XDcfg_SelfTest(&DcfgInstance);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	Status = Xil_In32(0xF8000168);
	if (!(Status & 0x01)) {
		Xil_Out32(0xF8000008, 0xDF0D);
//		Xil_Out32(0xF8000168, 0x3701);
		XDcfg_WriteReg(0xF8000000,0x168,0x701);
		Xil_Out32(0xF8000004, 0x767B);
	}
//	Xil_Out32(0xF8000008, 0xDF0D);
//	Xil_Out32(0xF8000168, 0x701);
//	Xil_Out32(0xF8000004, 0x767B);


	if (XDcfg_GetConfigReg(&DcfgInstance,address, 12, (u32 *)&ValueBack) !=
		XST_SUCCESS) {
		return XST_FAILURE;
	}
//	Statusreg = Xil_In32(0xF8000168);
//	xil_printf("\nPCAP CLK CTRL :%x\r\n",Statusreg);
	PrintBitStream(address,print_on);
	return XST_SUCCESS;
}

int XDcfg_GetConfigReg(XDcfg *DcfgInstancePtr, u32 address, u32 ConfigReg, u32 *RegData)
{
	u32 IntrStsReg;
	u32 StatusReg;
	u32 Index;
	unsigned int CmdIndex;
	unsigned int CmdBuf[63+3+4+3/*+4*/]; //66 if Un-comment Step 3

	/*
	 * Clear the interrupt status bits
	 */
//	XDcfg_ResetHw(DcfgInstancePtr->Config.BaseAddr);
	XDcfg_IntrClear(DcfgInstancePtr, (XDCFG_IXR_PCFG_DONE_MASK |
			XDCFG_IXR_D_P_DONE_MASK | XDCFG_IXR_DMA_DONE_MASK));

	/* Check if DMA command queue is full */
	StatusReg = XDcfg_ReadReg(DcfgInstancePtr->Config.BaseAddr,
				XDCFG_STATUS_OFFSET);
	if ((StatusReg & XDCFG_STATUS_DMA_CMD_Q_F_MASK) ==
			XDCFG_STATUS_DMA_CMD_Q_F_MASK) {
		return XST_FAILURE;
	}

	/*
	 * Device Read-back in non secure mode
	 * Create the data to be written to read back the
	 * Configuration Registers from PL Region.
	 */
		CmdIndex = 0U;
		/*Step 1*/
		CmdBuf[CmdIndex++] = 0xFFFFFFFFU; 	/* Dummy Word */
		CmdBuf[CmdIndex++] = 0xFFFFFFFFU; 	/* Dummy Word */
		CmdBuf[CmdIndex++] = 0xFFFFFFFFU; 	/* Dummy Word */
		CmdBuf[CmdIndex++] = 0xFFFFFFFFU; 	/* Dummy Word */
		CmdBuf[CmdIndex++] = 0xFFFFFFFFU; 	/* Dummy Word */
		CmdBuf[CmdIndex++] = 0xFFFFFFFFU; 	/* Dummy Word */
		CmdBuf[CmdIndex++] = 0xFFFFFFFFU; 	/* Dummy Word */

		CmdBuf[CmdIndex++] = 0xFFFFFFFFU; 	/* Dummy Word */
		CmdBuf[CmdIndex++] = 0x000000BBU; //Bus width sync
		CmdBuf[CmdIndex++] = 0x11220044U; //Bus width detect
		CmdBuf[CmdIndex++] = 0xFFFFFFFFU; //Dummy
		CmdBuf[CmdIndex++] = 0xAA995566U; //Sync
		/*Step 2*/
		CmdBuf[CmdIndex++] = 0x20000000U; //NOP
		CmdBuf[CmdIndex++] = 0x20000000U; //NOP Addition

		/*Step 3 Not Needed*/
		/**/
		CmdBuf[CmdIndex++] = 0x30008001; //Write to CMD 0x20000000; //NOP
		CmdBuf[CmdIndex++] = 0x0000000B; //Shutdown 0x20000000; //NOP
		CmdBuf[CmdIndex++] = 0x20000000; //NOP
		/**/
		/*Step 4*/
		CmdBuf[CmdIndex++] = 0x30008001U; //Write to CMD
		CmdBuf[CmdIndex++] = 0x00000007U; //Reset CRC command
		CmdBuf[CmdIndex++] = 0x20000000U; //NOP
		/*Step 5*/
		CmdBuf[CmdIndex++] = 0x20000000U; //NOP
		CmdBuf[CmdIndex++] = 0x20000000U; //NOP
		CmdBuf[CmdIndex++] = 0x20000000U; //NOP
		CmdBuf[CmdIndex++] = 0x20000000U; //NOP
		CmdBuf[CmdIndex++] = 0x20000000U; //NOP


//		/*GLUT MASK*/

//		CmdBuf[CmdIndex++] = 0x30008001U;
//		CmdBuf[CmdIndex++] = 0x00000000U;


		CmdBuf[CmdIndex++] = 0x3000C001U;
		CmdBuf[CmdIndex++] = 0x00000100U;
		CmdBuf[CmdIndex++] = 0x3000A001U;
		CmdBuf[CmdIndex++] = 0x00000100U;

//		CmdBuf[CmdIndex++] = 0x3000C001U;
//		CmdBuf[CmdIndex++] = 0x00000400U;
//		CmdBuf[CmdIndex++] = 0x3000A001U;
//		CmdBuf[CmdIndex++] = 0x00000400U;




		/*GCAPTURE ADDITION*/
		CmdBuf[CmdIndex++] = 0x30008001U;
		CmdBuf[CmdIndex++] = 0x0000000CU;
		CmdBuf[CmdIndex++] = 0x20000000U;



		/*Step 6*/
		CmdBuf[CmdIndex++] = 0x30008001U; //Write to CMD
		CmdBuf[CmdIndex++] = 0x00000004U; //RCFG command
		CmdBuf[CmdIndex++] = 0x20000000U; //NOP

		CmdBuf[CmdIndex++] = 0x20000000U; //NOP Addition
		CmdBuf[CmdIndex++] = 0x20000000U; //NOP Addition

		/*Step 7*/
		CmdBuf[CmdIndex++] = 0x30002001U; //Write to FAR
//		CmdBuf[CmdIndex++] = 0x000023A2U; //Bit-stream Read-back address
		CmdBuf[CmdIndex++] = address; //Bit-stream Read-back address
		/*Step 8*/
		CmdBuf[CmdIndex++] = 0x280060CAU; //Type 1 read FDRO Addition
//		CmdBuf[CmdIndex++] = 0x48001940U;
		CmdBuf[CmdIndex++] = 0x48000000U|NUM_FRAME_WORDS;
		/*Step 9*/
		u32 noop;
		for (noop = 0 ; noop < 32 ; noop++) {
			CmdBuf[CmdIndex++] = 0x20000000U;
		}


	for (Index = 0; Index < (NUM_FRAME_WORDS<<1) ; Index++)
    {
//    	readback_buffer[Index]=0xBADDEADU;
    	readback_buffer[Index]=0x00000000U;
    }

	XDcfg_Transfer(&DcfgInstance,(&CmdBuf[0]),
			CmdIndex, (u32 *) &readback_buffer[0], NUM_FRAME_WORDS, XDCFG_PCAP_READBACK);
	/* Poll IXR_DMA_DONE */
	IntrStsReg = XDcfg_IntrGetStatus(DcfgInstancePtr);
	while ((IntrStsReg & XDCFG_IXR_DMA_DONE_MASK) !=
			XDCFG_IXR_DMA_DONE_MASK) {
		IntrStsReg = XDcfg_IntrGetStatus(DcfgInstancePtr);
	}

	/* Poll IXR_D_P_DONE */
	while ((IntrStsReg & XDCFG_IXR_D_P_DONE_MASK) !=
			XDCFG_IXR_D_P_DONE_MASK) {
		IntrStsReg = XDcfg_IntrGetStatus(DcfgInstancePtr);
	}
		CmdIndex = 0U;

//		CmdBuf[CmdIndex++] = 0x3000C001U;
//		CmdBuf[CmdIndex++] = 0x00000100U;
//		CmdBuf[CmdIndex++] = 0x3000A001U;
//		CmdBuf[CmdIndex++] = 0x00000000U;


		/*Step 11*/
		CmdBuf[CmdIndex++] = 0x20000000U;	/* Type 1 NOOP Word 0 */
		/*Step 12*/
		CmdBuf[CmdIndex++] = 0x30008001U;	/* Type 1 Write 1  Word to Command */
		CmdBuf[CmdIndex++] = 0x00000005U;	/* Start Command */
		CmdBuf[CmdIndex++] = 0x20000000U;	/* Type 1 NOOP Word 0 */
		/*Step 13*/
		CmdBuf[CmdIndex++] = 0x30008001U;	/* Type 1 Write 1  Word to Command */
		CmdBuf[CmdIndex++] = 0x00000007U;	/* RCRC Command */
		CmdBuf[CmdIndex++] = 0x20000000U;	/* Type 1 NOOP Word 0 */
		/*Step 14*/
		CmdBuf[CmdIndex++] = 0x30008001U;	/* Type 1 Write 1  Word to Command */
		CmdBuf[CmdIndex++] = 0x0000000DU;	/* DESYNC COmmand */

	XDcfg_InitiateDma(DcfgInstancePtr, (u32)(&CmdBuf[0]),XDCFG_DMA_INVALID_ADDRESS, CmdIndex, 0);
	/* Poll IXR_DMA_DONE */
	IntrStsReg = XDcfg_IntrGetStatus(DcfgInstancePtr);
	while ((IntrStsReg & XDCFG_IXR_DMA_DONE_MASK) !=
			XDCFG_IXR_DMA_DONE_MASK) {
		IntrStsReg = XDcfg_IntrGetStatus(DcfgInstancePtr);
	}

	/* Poll IXR_D_P_DONE */
	while ((IntrStsReg & XDCFG_IXR_D_P_DONE_MASK) !=
			XDCFG_IXR_D_P_DONE_MASK) {
		IntrStsReg = XDcfg_IntrGetStatus(DcfgInstancePtr);
	}
	return XST_SUCCESS;
}

void PrintBitStream(u32 address,bool print_on)
{
	u8 	R[4]= {0,0,0,0};

	for(int p=101; p<NUM_FRAME_WORDS; p++)

	{
		R[0]=(readback_buffer[p]) >> 0;
		R[1]=(readback_buffer[p]) >> 8;
		R[2]=(readback_buffer[p]) >> 16;
		R[3]=(readback_buffer[p]) >> 24;
		#ifdef SWAP_ON
		if(readback_buffer[p] !=0){
			if(print_on == true)
				xil_printf("Frame Word \t %03d  ->  %02x %02x %02x %02x ,** \t \n",p-101,R[0],R[1],R[2],R[3]);
			}
		else
			if(print_on == true)
				xil_printf("Frame Word \t %03d  ->  %02x %02x %02x %02x , \t \n",p-101,R[0],R[1],R[2],R[3]);
		#else
				if(readback_buffer[p] !=0){
					if(print_on == true)
						xil_printf("Frame Word \t %03d  ->  %02x %02x %02x %02x ,** \t \n",p-101,R[3],R[2],R[1],R[0]);
					}
				else
					if(print_on == true)
						xil_printf("Frame Word \t %03d  ->  %02x %02x %02x %02x , \t \n",p-101,R[3],R[2],R[1],R[0]);
		#endif

//		xil_printf("Frame Word \t %03d  ->  %02x%02x%02x%02x , \t \n",p-100,R[0],R[1],R[2],R[3]);
//		xil_printf("readback_b \t %03d  ->  %08x , \t \n",p-100,readback_buffer[p]);
//		xil_printf("%02x%02x%02x%02x\r\n",R[0],R[1],R[2],R[3]);
	}
	if(print_on == true)
	xil_printf("Frame read from address : %08x\r\n",address);
	usleep(200);
}

int save_bitstream (u32 DDR_OFFSET , u32 OFFSET , bool BRAM_FLIP)
{
	for(int DRAM_Addr=0; DRAM_Addr <101; DRAM_Addr++)
	{
	#ifdef SWAP_ON
		Xil_Out32(((DDR_OFFSET+OFFSET)+ (4*DRAM_Addr))	 ,		(   Xil_EndianSwap32 (readback_buffer[DRAM_Addr+101])));
//		xil_printf("Frame Word \t %03d  ->  %08x , \t \n",DRAM_Addr,Xil_EndianSwap32 (readback_buffer[DRAM_Addr+101]));
	#else
		if ((DRAM_Addr==4||DRAM_Addr==14|| DRAM_Addr==24|| DRAM_Addr==34|| DRAM_Addr==44|| DRAM_Addr==55|| DRAM_Addr==65|| DRAM_Addr==75|| DRAM_Addr==85|| DRAM_Addr==95) && BRAM_FLIP){
			Xil_Out32(((DDR_OFFSET+OFFSET)+ (4*DRAM_Addr)), readback_buffer[DRAM_Addr+101] & BRAM_MASK);
		}
		else{
		Xil_Out32(((DDR_OFFSET+OFFSET)+ (4*DRAM_Addr)), readback_buffer[DRAM_Addr+101]);
//		xil_printf("Frame Word \t %03d  ->  %08x , \t \n",DRAM_Addr,readback_buffer[DRAM_Addr+101]);
		}
	#endif

	}
	usleep(1000);
//	xil_printf("  * Upload  Finished* \r\n");
	return XST_SUCCESS;
}



