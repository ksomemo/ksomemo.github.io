#/bin/bash

cd docs
make clean
make html
cd ..
rm -rf _images _sources _static
rm -rf contents
cp -r docs/_build/html/* .

