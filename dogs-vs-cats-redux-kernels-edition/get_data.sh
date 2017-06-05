#!/bin/bash

if [ -d "./data" ]; then
    echo "data exists!"
    exit 0
fi

# mkdir
mkdir ./data
mkdir ./data/input
mkdir ./data/output

# kaggle config
echo "Type Kaggle Username:"
read kg_u

echo "Type Kaggle Password:"
read kg_p

kg_c="dogs-vs-cats-redux-kernels-edition"

cd ./data/input
kg config -u $kg_u -p $kg_p -c $kg_c

# kaggle download
kg download

