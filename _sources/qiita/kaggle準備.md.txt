## steps
1. create account
1. login
1. run prepare-kaggle.sh

```prepare-kaggle.sh
# prepare python environment
# kg command
pip install kaggle-cli

# warning: save raw password
# ~/.kaggle-cli/config
kg config -u username -p password -g 

# for accept / python 3.6
pip install git+https://github.com/ksomemo/kaggle-accept

# make directory for competition
mkdir -p /path/to/kaggle-root/competition-name && cd $_
competition_name=`basename $(pwd)`

# accept
python -m kaggle_accept -c $competition_name

# download data
mkdir input && cd $_
kg download -c $competition_name && cd ..

mkdir notebooks
mkdir scripts
```

## check data
```check_data.sh
# size
ls -lh ./input/*.zip
ls -lh ./input/*.csv

# n rows
wc -l ./input/*.csv

# n columns
for f in `ls ../input/*.csv`
do
    head -n 1 $f | awk -F, -v fname="$f" '{print NF "\t" fname}'
done
```

http://qiita.com/ksomemo/items/2e7389db84f8b416ad9f


