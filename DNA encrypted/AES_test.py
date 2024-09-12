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

    # 数据进行 PKCS5Padding 的填充
    padding = BLOCK_SIZE - len(bufferList) % BLOCK_SIZE
    bufferList.extend([padding for x in range(0, padding)])

    buffer = cipher.encrypt(bytes(bufferList))
    return buffer.hex()  # 使用hex格式输出


def aes_decrypt(value, secret_key, iv_key):
    cipher = init_cipher(secret_key, iv_key)
    buffer = bytes.fromhex(value)  # 读取hex格式数据
    buffer = cipher.decrypt(buffer)
    result = buffer.decode("utf-8")

    # 去掉 PKCS5Padding 的填充
    return result[:-ord(result[len(result) - 1:])]


#text = "ATGCGGGGGappleee"#一个英文字符对应7个二进制   7x16=112

text = "TCGATCGCGTAGGCCATGTCGATCGCGTAGGCCATGTCCATGGTCAGCTTCGACCGTTGCGACGCGTCGATGTCCTTACGGATGCAACGGCAGGACGAACGACCGACCTGGAAGCCTACTAGGCTGACGCTAGCGTCGATGGCGGTAGCCTGAAGCATCCTGCTGACGTTGGCTGC"
key = "ATGCATGCATGCATGC"
iv = "abcdefg"

encryptText1 = aes_encrypt(text, key, iv)
print("【", text, "】经过【AES-CBC】加密后：", encryptText1)

decryptText1 = aes_decrypt(encryptText1, key, iv)
print("【", encryptText1, "】经过【AES-CBC】解密后：", decryptText1)

encryptText2 = aes_encrypt(text, key, None)
print("【", text, "】经过【AES-ECB】加密后：", encryptText2)

decryptText2 = aes_decrypt(encryptText2, key, None)
print("【", encryptText2, "】经过【AES-ECB】解密后：", decryptText2)

data = np.loadtxt('results_newcipin_PAP.txt', dtype=np.str, delimiter='\n');
encryptText1=data;
for i in range(len(data)):
    encryptText1[i] = aes_encrypt(data[i], key, None)
    #print("【", text, "】经过【AES-CBC】加密后：", encryptText1)
    decryptText1 = aes_decrypt(encryptText1[i], key, None)
    print("【", decryptText1[i], "】经过【AES-CBC】解密后：", decryptText1)

def Save_list(list1,filename):
    file2 = open(filename + '.txt', 'w')
    for i in range(len(list1)):
        for j in range(len(list1[i])):
            file2.write(str(list1[i][j]))              # write函数不能写int类型的参数，所以使用str()转化
            #file2.write('\t')                          # 相当于Tab一下，换一个单元格
        file2.write('\n')                              # 写完一行立马换行
    file2.close()

Save_list(decryptText1,'DNA_decode');



# encryptText2 = aes_encrypt(text, key, None)
# print("【", text, "】经过【AES-ECB】加密后：", encryptText2)
#
# decryptText2 = aes_decrypt(encryptText2, key, None)
# print("【", encryptText2, "】经过【AES-ECB】解密后：", decryptText2)