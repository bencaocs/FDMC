import matplotlib.pyplot as plt
import numpy as np

plt.style.use('fivethirtyeight')

price_orange = np.array([2.50, 1.23, 4.02, 3.25, 5.00, 4.40])
sales_per_day_orange = np.array([34, 62, 49, 22, 13, 19])
profit_margin_orange = np.array([20, 35, 40, 20, 27.5, 15])

price_cereal = np.array([1.50, 2.50, 1.15, 1.95])
sales_per_day_cereal = np.array([67, 34, 36, 12])
profit_margin_cereal = np.array([20, 42.5, 33.3, 18])

plt.scatter(price_orange, sales_per_day_orange, s=profit_margin_orange*10, c=profit_margin_orange,
            cmap='jet', edgecolors='black', linewidth=1, alpha=0.7, label='orange')


plt.scatter(price_cereal, sales_per_day_cereal, s=profit_margin_cereal*10, c=profit_margin_cereal,
            cmap='jet', edgecolors='black', linewidth=1, alpha=0.7, marker='d', label='cereal')

cbar = plt.colorbar()
cbar.set_label('利润率')

plt.title('价格和销量的关系')
plt.xlabel('价格')
plt.ylabel('销量')

plt.legend()
plt.tight_layout()
plt.show()