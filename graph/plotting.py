import re

import matplotlib.pyplot as plt

years = []
count = []
pattern = re.compile(r"(\d+)\s(\d+)")
with open('raw.txt', 'r') as f:
    for line in f:
        mat = pattern.match(line.replace("\n", ""))
        years.append(mat.group(2))
        count.append(mat.group(1))
plt.plot(years, count)
plt.show()
