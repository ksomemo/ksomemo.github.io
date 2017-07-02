## conda-launcher
- Pythonで書かれた?便利アプリを起動するアプリの管理ツールっぽい
- conda envのGUIとしても使える

```bash:conda-launcher.sh
# http://docs.continuum.io/anaconda/launcher
# http://docs.continuum.io/anaconda-launcher/index

conda install launcher
/.pyenv/versions/miniconda3-3.9.1/bin/launcher
# launcherの起動

# apps list
# glueviz => success
# ipython-notebook, ipython-qtconsole,
# orange => fail
# spyder-app => success
conda list | grep gl
# empty

# glueviz, click [install]
conda list | grep gl
glueviz                   0.6.0                    py34_1    defaults

# glueviz, click [launch] 
# gluevizアプリの起動

# channelはまだよくわかってない
```

## Anacondaに含まれていないpackage以外で使っているもの一覧
### 概要
- Python 3.6が出たので新しいAnacondaのVersionが出る前にまとめておきたかった
- おもに、jupyter, 決定木用のgraph関連, 形態素解析, R連携, Pandas用, など

### conda listで解決する
```pypi_packages.md
conda list | grep "<pip>"

- janome
- pyper
- jupyter_contrib_nbextensions (Python-contrib-nbextensions)
    - `jupyter contrib nbextension install --user`
- flake8
- graphviz
- html5lib
- japandas
- jupyter-cms
- mecab-python3
- pandas-datareader
- pivottablejs
- pydot2
- pyquery
- pyperclip
- rpy2
- <del>seaborn</del> anaconda3.4.3から入っている
- tabulate
- kaggle-cli
```

```conda_packages.md
- `conda install -c conda-forge jupyterlab`
```

### Anacondaに含まれていて、実際使っているもの
きちんとvenv / conda envを使うようになったのであげてみる

```requirments_for_analysis.txt
numpy
scipy
pandas
matplotlib
seaborn
scikit-learn
jupyter
# たまに
requests
sympy
statsmodels
pillow
click
```
