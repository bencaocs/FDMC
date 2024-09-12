import os
import numpy as np
from Crypto.Cipher import AES

BLOCK_SIZE = 16


def init_cipher(secret_key, iv_key):
    secret_bytes = secret_key.encode(encoding='utf-8')
    key_bytes = []
    if len(secret_bytes) >= BLOCK_SIZE:
        key_bytes = secret_bytes[:BLOCK_SIZE]
    else:
        key_bytes.extend(secret_bytes)
        key_bytes.extend([0 for x in range(0, BLOCK_SIZE - len(secret_bytes))])

    if iv_key is None or len(iv_key) == 0:
        cipher = AES.new(bytes(key_bytes), AES.MODE_ECB)
        return cipher
    else:
        iv_bytes = iv_key.encode(encoding='utf-8')
        iv_key_bytes = []
        if len(iv_bytes) >= BLOCK_SIZE:
            iv_key_bytes = iv_bytes[:BLOCK_SIZE]
        else:
            iv_key_bytes.extend(iv_bytes)
            iv_key_bytes.extend([0 for x in range(0, BLOCK_SIZE - len(iv_bytes))])

        cipher = AES.new(bytes(key_bytes), AES.MODE_CBC, bytes(iv_key_bytes))
        return cipher


def aes_encrypt(value, secret_key, iv_key):
    cipher = init_cipher(secret_key, iv_key)

    buffer = value.encode(encoding="utf-8")
    bufferList = list(buffer)

    #  PKCS5Padding 
    padding = BLOCK_SIZE - len(bufferList) % BLOCK_SIZE
    bufferList.extend([padding for x in range(0, padding)])

    buffer = cipher.encrypt(bytes(bufferList))
    return buffer.hex()  # 


def aes_decrypt(value, secret_key, iv_key):
    cipher = init_cipher(secret_key, iv_key)
    buffer = bytes.fromhex(value)  # read hex
    buffer = cipher.decrypt(buffer)
    result = buffer.decode("utf-8")

    # del PKCS5Padding
    return result[:-ord(result[len(result) - 1:])]


#text = "ATGCGGGGGappleee"#7x16=112
key = "ACCATCGTGACAGGAT"
iv = "abcdefg"


data = np.loadtxt('results_newcipin_PAP.txt', dtype=np.str, delimiter='\n');
data_list=data.tolist();
encryptText1=data_list;
for i in range(len(data)):
    encryptText1[i] = aes_encrypt(data_list[i], key, iv)
    #print("【", text, "】【AES-CBC】：", encryptText1)

def Save_list(list1,filename):
    file2 = open(filename + '.txt', 'w')
    for i in range(len(list1)):
        for j in range(len(list1[i])):
            file2.write(str(list1[i][j]))              
            #file2.write('\t')                       
        file2.write('\n')                          
    file2.close()

Save_list(encryptText1,'DNA_encry');
