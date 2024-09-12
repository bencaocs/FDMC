import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.pyplot as plt
def to_ascii(text):
    ascii_values = [ord(character) for character in text]
    return ascii_values
# text = input("Enter a string: ")
# print(to_ascii(text))

##matplotlib.axes.Axes.hist() 方法的接口
data = np.loadtxt('DNA_encry.txt', dtype=np.str, delimiter='\n');
ascii_values_all_en = []
for i in range(len(data)):
    ascii_values_all_en.append(to_ascii(data[i]))
#d=to_ascii(data[])
d_en = sum(ascii_values_all_en, [])

data_de = np.loadtxt('results_newcipin_PAP.txt', dtype=np.str, delimiter='\n');
data_de=data_de.tolist();
ascii_values_all_de = []
for i in range(len(data)):
    ascii_values_all_de.append(to_ascii(data_de[i]))
#d=to_ascii(data[])
d_de = sum(ascii_values_all_de, [])
Y1 = [25000,50000,75000,100000,125000,175000,200000,225000]
Y2 = []
for x in Y1:
    Y2.append(x/50)
##d = np.random.laplace(loc=15, scale=3, size=500)
#n, bins, patches = plt.hist([d_de,d_en], bins='auto', color=['#0504aa','#607c8e'],
#                            alpha=0.7, rwidth=0.25, range=(10,120),cumulative=False)
n1, bins1, patches1 = plt.hist(d_de, bins='auto', color='#00B8B8',
                            alpha=1, rwidth=0.55,
                               range=(47,125),cumulative=True, label='original')
n2, bins2, patches2 = plt.hist(d_en, bins='auto', color='r',
                            alpha=0.2, rwidth=0.55,
                               range=(47,125),cumulative=True, label='encrypted')

plt.plot(bins1[:-1],n1,':',lw=3)#, color='#607c8e'
plt.plot(bins2[:-1],n2,'--',lw=3)#, color='#0504aa'
#gca代表获取当前坐标轴
ax = plt.gca()
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')
#右边和上边的边框去掉



plt.grid(axis='y', alpha=0.75)
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.ticklabel_format(style='sci', scilimits=(0,0))#科学计数法
#plt.title('My Very Own Histogram')
plt.legend(loc='upper left')# 显示图例
#plt.text(23, 45, r'$\mu=15, b=3$')
#maxfreq = n.max()
# 设置y轴的上限
#plt.ylim(ymax=np.ceil(maxfreq / 10) * 10 if maxfreq % 10 else maxfreq + 10)

plt.show()
#

#下面是另一种画法
# size, scale = 1000, 10
# commutes = pd.Series(np.random.gamma(scale, size=size) ** 1.5)
#
# commutes.plot.hist(grid=True, bins=20, rwidth=0.9,
#                    color='#607c8e')
# plt.title('Commute Times for 1,000 Commuters')
# plt.xlabel('Counts')
# plt.ylabel('Commute Time')
# plt.grid(axis='y', alpha=0.75)
# plt.show()