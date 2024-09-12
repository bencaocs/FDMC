import pandas as pd
import csv
import numpy as np
import matplotlib.pyplot as plt
df = pd.read_csv('entropy_list.csv')
#print(df)
y_zhou=range(31)#
y_old=range(29)
#[0,1,2,3,4,5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
X_old=[3.26,9.31,12.3,16.36,21.96,25.91,31.16,34.48,37.8,41.53,49.66,54.62,58.98,62.15,66.65,70.52,74.25,77.99,82.25,88.19,92.34,95.42,101.57,105.41,110.92,115.24,120.17,124.81,128.361]
with open('entropy_list.csv', encoding='utf-8-sig') as f:
    for row in csv.reader(f, skipinitialspace=True):
        print(row)#
row1=[]
for r in row:
    row1.append(float(r))

fig = plt.figure(figsize=(10, 8), facecolor='#FFFFFF')#
# x_STR=[0.5274,1.3476,2.7548,3.714,4.178,6.156]
# y_STR=[0,1,2,3,4,5]
# plt.scatter(y_STR, x_STR, c='r',
#             cmap='jet', edgecolors='black', linewidth=1, alpha=0.7, label='orange')
plt.scatter(y_old, row1[0:29], c='#00B8B8',#c is color marker is shape alpha is transparency
            cmap='jet', edgecolors='black', linewidth=1, alpha=0.9, marker='o', label='Micro in rats')

plt.scatter(y_old, X_old, c="#88c999",
            cmap='jet', edgecolors='black', linewidth=1, alpha=0.9, marker='d', label='Human STR')
plt.legend(fontsize=15)
plt.xticks(fontsize=15)
plt.yticks(fontsize=15)

plt.xlabel('Number of marks', fontsize=15)#fontsize
plt.ylabel('Accumulative entropy(bits)', fontsize=15)
plt.ylim(0,150)
# plt.scatter(y_old, row[2:31], marker="*", c="#88c999",edgecolors="pink")
# plt.scatter(y_old, X_old, marker="^", c='#00B8B8',edgecolors="pink")
x_data=[4.86523742210858,4.58375934462170,3.91364635828314,4.65109983726562,4.65189119695675,3.99106411890061,4.14624348147894,4.28811344970706,4.09716363603595,4.61755699208936,4.21538957168812,4.30670919519501,4.44027323996201,4.42780480972014,4.87122853021955,4.81463412100656,4.87239580586838,4.08010318011020,4.21366722487719,4.65709094537660,4.60049653616361,4.42321278403625,4.42400414372738,3.98350557058310,4.11706961535009,4.65825822102542,4.37678014353854,4.46809976704544,4.60166381181243,4.60245517150356]
x_data_old=[3.26,6.05,2.99,4.06,5.60,3.95,5.25,3.32,3.32,3.73,8.13,4.96,4.36,3.17,4.50,3.87,3.73,3.74,4.26,5.94,4.15,3.08,6.15,3.84,5.51,4.32,4.93,4.64,3.551]
x_width = list(range(0,len(x_data_old)))

width=0.4

ax1 = fig.add_subplot(111)
ax2 = ax1.twinx()
ax2.bar(x_width,x_data_old,lw=0.5,fc="y",  width=width, alpha=0.5, facecolor="#88c999", ec="#88c999", label="Single STR")
for i in range(len(x_width)):#
    x_width[i] = x_width[i] + width
ax2.bar(x_width,x_data[0:29],lw=0.5,fc="r",width=width, alpha=0.5, facecolor="#00B8B8", ec="#00B8B8", label="Single micro")
ax2.set_ylim(0,15)#
ax2.set_xlim(-0.6,29)#
plt.xticks(fontsize=15)
plt.yticks(fontsize=15)
plt.legend(loc='upper left', bbox_to_anchor=(0, 0.89), fontsize=15)#
plt.ylabel('Entropy(bits)',fontsize=15)
#plt.xticks(range(0,5),x_data_old)




plt.show()
