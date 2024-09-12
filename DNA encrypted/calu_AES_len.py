import os
import numpy as np
from Crypto.Cipher import AES
#Counting the length of each line in an encrypted file
data = np.loadtxt('DNA_encry.txt', dtype=np.str, delimiter='\n');
encryptText1 = data;
j = 0;
k = 0;
for i in range(len(data)):
    aa = len(data[1])
    if len(data[i]) > aa:
        j = j+1
        max_j = len(data[i])
    else:
        k = k+1

file_size = k*32+j*64+(k+j)*2
print("Total number of lines", len(data),"Longest number", j, "Maximum length", max_j,)
