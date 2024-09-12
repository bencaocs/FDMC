import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.pyplot as plt

#  matplotlib.axes.Axes.hist() 方法的接口
# d = np.random.laplace(loc=15, scale=3, size=500)
# n, bins, patches = plt.hist(x=d, bins='auto', color='#0504aa',
#                             alpha=0.7, rwidth=0.85)
# plt.grid(axis='y', alpha=0.75)
# plt.xlabel('Value')
# plt.ylabel('Frequency')
# plt.title('My Very Own Histogram')
# plt.text(23, 45, r'$\mu=15, b=3$')
# maxfreq = n.max()
# # 设置y轴的上限
# plt.ylim(ymax=np.ceil(maxfreq / 10) * 10 if maxfreq % 10 else maxfreq + 10)
#
# plt.show()
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