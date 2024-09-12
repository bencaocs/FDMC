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

    #  Filling of PKCS5Padding with data
    padding = BLOCK_SIZE - len(bufferList) % BLOCK_SIZE
    bufferList.extend([padding for x in range(0, padding)])

    buffer = cipher.encrypt(bytes(bufferList))
    return buffer.hex()  # Output in hex format


def aes_decrypt(value, secret_key, iv_key):
    cipher = init_cipher(secret_key, iv_key)
    buffer = bytes.fromhex(value)  # 
    buffer = cipher.decrypt(buffer)
    result = buffer.decode("utf-8")

    # del Filling of PKCS5Padding
    return result[:-ord(result[len(result) - 1:])]


#text = "ATGCGGGGGappleee"#One English character corresponds to 7 binary 7x16=112
key = "ACCATCGTGACAGGAT"
iv = "abcdefg"


data = np.loadtxt('DNA_encry.txt', dtype=np.str, delimiter='\n');

decryptText1=data;
for i in range(len(data)):
    decryptText1[i] = aes_decrypt(data[i], key, iv)
    #print("【", text, "】when【AES-CBC】：", encryptText1)

def Save_list(list1,filename):
    file2 = open(filename + '.txt', 'w')
    for i in range(len(list1)):
        for j in range(len(list1[i])):
            file2.write(str(list1[i][j]))              # The write function can't write int-type arguments, so use str() to convert them.
            #file2.write('\t')                          # The equivalent of Tabbing to change a cell
        file2.write('\n')                              # Write a new line as soon as you finish writing
    file2.close()

Save_list(decryptText1,'DNA_decode');

# decryptText1 = aes_decrypt(encryptText1, key, iv)
# print("【", encryptText1, "】when【AES-CBC】decrypt：", decryptText1)
#
# encryptText2 = aes_encrypt(text, key, None)
# print("【", text, "】when【AES-ECB】encrypt：", encryptText2)
#
# decryptText2 = aes_decrypt(encryptText2, key, None)
# print("【", encryptText2, "】when【AES-ECB】decrypt：", decryptText2)