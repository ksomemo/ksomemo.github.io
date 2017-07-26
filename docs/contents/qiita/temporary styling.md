# matplotlib temporary styling
```py3
import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt

%matplotlib inline
matplotlib.style.use("ggplot")

plt.style.available
['seaborn-dark',
 'seaborn-talk',
 'classic',
 'seaborn-white',
 'fivethirtyeight',
 'seaborn-ticks',
 'seaborn-colorblind',
 'seaborn-muted',
 'seaborn-notebook',
 'seaborn-dark-palette',
 'seaborn-paper',
 'seaborn-bright',
 'seaborn-darkgrid',
 'seaborn-poster',
 'seaborn-deep',
 'ggplot',
 'dark_background',
 'seaborn-pastel',
 'grayscale',
 'bmh',
 'seaborn-whitegrid']

# http://matplotlib.org/users/style_sheets.html#temporary-styling
with plt.style.context(('dark_background')):
    plt.plot(np.sin(np.linspace(0, 2*np.pi)), 'r-o')

plt.plot(np.sin(np.linspace(0, 2*np.pi)), 'r-o')
```
