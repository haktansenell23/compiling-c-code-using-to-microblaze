
#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xil_exception.h"
#include "xintc.h"


#define GPIO_DEVICE_ID			XPAR_GPIO_0_DEVICE_ID
#define INTC_GPIO_INTERRUPT_ID	XPAR_INTC_0_GPIO_0_VEC_ID
#define INTC_DEVICE_ID			XPAR_INTC_0_DEVICE_ID
#define BUTTON_CHANNEL	 		1
#define LED_CHANNEL	 			2
#define INTC_HANDLER			XIntc_InterruptHandler


XGpio Gpio;
XIntc Intc;
static volatile u32 IntrFlag;


void GpioHandler(void *CallBackRef);

int main()
{
	/*Cache 'le UART tanýmlanýr             */
    init_platform();
    int Status;
	u32 switches_val = 0;

	/* Gpio'yo kontrol edilir*/
	Status = XGpio_Initialize(&Gpio, GPIO_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*Kanallar için input output tanýmlanmasý(kontrol registerlarý) */
	XGpio_SetDataDirection(&Gpio,1,0xFFFF);
	XGpio_SetDataDirection(&Gpio,2,0x0000);

/*Buttondaki duruma göre interrupt üretilmesi */
	XGpio_InterruptEnable(&Gpio, BUTTON_CHANNEL);
	XGpio_InterruptGlobalEnable(&Gpio);

	/* Ýntterrupt kontrol registeri için initialize iþlemi yapar*/
	Status = XIntc_Initialize(&Intc, INTC_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

/* Hangi Servisi baðlanmasý gerektiði */
	XIntc_Connect(&Intc, INTC_GPIO_INTERRUPT_ID,

			(XInterruptHandler)GpioHandler, &Gpio);

/*GPIO Ýnterrup ýd 'ye göre enable et*/
	XIntc_Enable(&Intc, INTC_GPIO_INTERRUPT_ID);

/*registera yazma*/
	Status = XIntc_Start(&Intc, XIN_REAL_MODE);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	Xil_ExceptionInit();

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			 (Xil_ExceptionHandler)INTC_HANDLER, &Intc);




	Xil_ExceptionEnable();

/* interrupt oluþtuysa flag=1 olursa, buton kanalý okunsun led yansýn*/
	for (;;)
	{
		if (IntrFlag == 1)
		{
			IntrFlag = 0;
			switches_val = XGpio_DiscreteRead(&Gpio,BUTTON_CHANNEL);
			XGpio_DiscreteWrite(&Gpio,LED_CHANNEL,switches_val);

		}
	}


    cleanup_platform();
    return 0;
}



void GpioHandler(void *CallBackRef)
{
	XGpio *GpioPtr = (XGpio *)CallBackRef;

	IntrFlag = 1;

	/* Clear the Interrupt */
	XGpio_InterruptClear(GpioPtr, BUTTON_CHANNEL);
}
