################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/aes.c \
../src/hmac.c \
../src/main.c \
../src/pl.c \
../src/platform.c \
../src/sd.c \
../src/sha256.c 

OBJS += \
./src/aes.o \
./src/hmac.o \
./src/main.o \
./src/pl.o \
./src/platform.o \
./src/sd.o \
./src/sha256.o 

C_DEPS += \
./src/aes.d \
./src/hmac.d \
./src/main.d \
./src/pl.d \
./src/platform.d \
./src/sd.d \
./src/sha256.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O2 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../benchmark_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


