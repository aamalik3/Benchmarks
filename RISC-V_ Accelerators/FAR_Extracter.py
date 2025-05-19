#convert ascii to hexadecimal
def ascii_to_hex(binary_data):
    return ''.join('{:02x}'.format(byte) for byte in binary_data)

# specific bytes we are searching for
target = "30002001"  

# open and read the file
with open('./Bitfiles/WithoutCRC/falcon_delay_2/falcon_delay_2_pblock_risc_partial.bit', 'rb') as file:
    binary_data = file.read()

# converts using function 
hexadecimal_data = ascii_to_hex(binary_data)

index = 0
results = set()

# iterate through the file
while index != -1:
    #find next occurence of target
    index = hexadecimal_data.find(target, index)
    
    # if target is found, add the following bytes
    if index != -1:
        result = hexadecimal_data[index + len(target):index + len(target) + 8]
        results.add(result)
        index += len(target)  
    else:
        break

sorted_ = sorted(results, key=lambda x: int(x, 16))
with open('./Bitfiles/WithoutCRC/falcon_delay_2/FAR.txt', 'w') as output_file:
    output_file.write('u32 FAR_ARRAY [] = {\n0x')
    output_file.write(',\n0x'.join(sorted_))
    output_file.write('\n};')

print("Findings printed to Task1Output.txt")