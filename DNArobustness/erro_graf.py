import pandas as pd
import csv
import numpy as np
import matplotlib.pyplot as plt
#
# import matplotlib.pyplot as plt
# import random
# import numpy as np
#
#
# # Create some random data
# x = np.arange(0,10,1)
# y = np.zeros_like(x)
# y = [random.random()*5 for i in x]
#
# # Calculate the simple average of the data
# y_mean = [np.mean(y)]*len(x)
#
# fig,ax = plt.subplots()
#
# # Plot the data
# data_line = ax.plot(x,y, label='Data', marker='o')
#
# # Plot the average line
# mean_line = ax.plot(x,y_mean, label='Mean', linestyle='--')
#
# # Make a legend
# legend = ax.legend(loc='upper right')
#
# plt.show()

#df_DMC_erro_insert = pd.read_csv('DMC_erro_insert.csv')
#print(df)
y_72=range(72)#生成0-31的数组
y_old=range(29)
row1=[]
#[0,1,2,3,4,5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
X_old=[3.26,9.31,12.3,16.36,21.96,25.91,31.16,34.48,37.8,41.53,49.66,54.62,58.98,62.15,66.65,70.52,74.25,77.99,82.25,88.19,92.34,95.42,101.57,105.41,110.92,115.24,120.17,124.81,128.361]
with open('DNAF_erro_SNV.csv', encoding='UTF-8-sig') as f_DMC_erro_insert:
    for row in csv.reader(f_DMC_erro_insert, skipinitialspace=True):
        #print(row)#读出csv中的值
        row1.append(row)

row2 = sum(row1, [])
row3 = []
for r in row2:
    row3.append(float(r))


row11=[]
with open('YYC_erro_SNV.csv', encoding='UTF-8-sig') as f_DMC_erro_insert:
    for row in csv.reader(f_DMC_erro_insert, skipinitialspace=True):
        #print(row)#读出csv中的值
        row11.append(row)

row22 = sum(row11, [])
row33 = []
for r in row22:
    row33.append(float(r))

row111=[]
with open('DMC_erro_SNV.csv', encoding='UTF-8-sig') as f_DMC_erro_insert:
    for row in csv.reader(f_DMC_erro_insert, skipinitialspace=True):
        #print(row)#读出csv中的值
        row111.append(row)

row222 = sum(row111, [])
row333 = []
for r in row222:
    row333.append(float(r))
sum_list_72=[list(np.random.randint(8,12,12)/100000),list(np.random.randint(8,12,12)/10000),list(np.random.randint(20,60,12)/10000),list(np.random.randint(45,55,12)/10000),list(np.random.randint(75,85,12)/10000),list(np.random.randint(95,105,12)/10000)]
sum_list_180=[list(np.random.randint(8,12,30)/100000),list(np.random.randint(8,12,30)/10000),list(np.random.randint(20,60,25)/10000),list(np.random.randint(60,65,5)/10000),list(np.random.randint(45,55,25)/10000),list(np.random.randint(55,60,5)/10000),list(np.random.randint(75,85,30)/10000),list(np.random.randint(95,105,30)/10000)]
sum_list_72 = sum(sum_list_72, [])
sum_list_180 = sum(sum_list_180, [])
sum_list6=[0.0001, 0.001, 0.003, 0.005, 0.008, 0.01]
fig = plt.figure(figsize=(10, 8), facecolor='#FFFFFF')#facecolor是边框颜色
# x_STR=[0.5274,1.3476,2.7548,3.714,4.178,6.156]
# y_STR=[0,1,2,3,4,5]
# plt.scatter(y_STR, x_STR, c='r',
#             cmap='jet', edgecolors='black', linewidth=1, alpha=0.7, label='orange')
#plt.errorbar(y_72,row3,fmt="bo:",yerr=0.2,xerr=0.02)
# plt.scatter(sum_list_180, row3, c='#00B8B8',#c是颜色 marker是形状 alpha是透明度
#            cmap='jet', edgecolors='black', linewidth=1, alpha=0.9, marker='o', label='DNA fountain')

plt.scatter(sum_list_72, row33, c="#88c999",
            cmap='jet', edgecolors='black', linewidth=1, alpha=0.9, s=100, marker='^', label='YYC')

plt.scatter(sum_list_72, row333, c="#FC011A",
            cmap='jet', edgecolors='black', linewidth=1, alpha=0.5, s=100, marker='*', label='DMC')
plt.legend(loc='right', bbox_to_anchor=(0.97, 0.80), fontsize=15)
plt.xticks(fontsize=20)
plt.yticks(fontsize=20)

plt.xlabel('Insert error rate', fontsize=15)#fontsize字的大小
plt.ylabel('Data recovery rate', fontsize=15)

#plt.xlim(-0.0004,0.0104)
scale_ls = [0.0001, 0.001, 0.003, 0.005, 0.008, 0.01]

index_ls = ['0.01%', '0.1%', '0.3%', '0.5%', '0.8%', '1%']

plt.xticks(scale_ls,index_ls)
#scale_y = [0.25, 0.5, 0.75, 1]
scale_y = [ 0.99, 0.995, 1]

index_y = ['99%', '99.5%', '100%']
#index_y = ['25%', '50%', '75%', '100%']

plt.yticks(scale_y,index_y)
plt.xlim(0.005,)
plt.ylim(0.993,1.005)
###画平均线
row_ave=[]
with open('ave_list.csv', encoding='UTF-8-sig') as f_DMC_erro_insert:
    for row in csv.reader(f_DMC_erro_insert, skipinitialspace=True):
        #print(row)#读出csv中的值
        row_ave.append(row)

row_ave_DNAF = row_ave[9]
row_ave_DNAF_num = []
for r in row_ave_DNAF:
    row_ave_DNAF_num.append(float(r))

row_ave_YYC = row_ave[10]
row_ave_YYC_num = []
for r in row_ave_YYC:
    row_ave_YYC_num.append(float(r))

row_ave_DMC = row_ave[11]
row_ave_DMC_num = []
for r in row_ave_DMC:
    row_ave_DMC_num.append(float(r))
# ax=plt.gca()
# ax.set_xticks([0.0001, 0.001, 0.003, 0.005, 0.008, 0.01])
# ax.set_xticklabels = ['0.01%', '0.1%', '0.3%', '0.5%', '0.8%', '1%']
# plt.plot(sum_list6,row_ave_DNAF_num,color='#00B8B8',marker='o',linestyle='-',alpha=0.9)
plt.plot(sum_list6,row_ave_YYC_num,color='#88c999',marker='^',linestyle='-',alpha=0.9)
plt.plot(sum_list6,row_ave_DMC_num,color='#FC011A',marker='*',linestyle='-',alpha=0.9)
plt.show()

#plt.savefig("SNV_litter.svg", dpi=600,format="svg")
