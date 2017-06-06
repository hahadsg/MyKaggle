#!bin/bash

cd ./data/input

# product train/val
function move_class_file {
    source_path=$1
    target_path=$2
    data_num=$3
    class_name=$4

    class_tra_path="$target_path/train/$class_name/"
    class_val_path="$target_path/val/$class_name/"
    mkdir $class_tra_path
    mkdir $class_val_path

    if [ "$data_num" == "all" ]; then
        data_num=$(ls $source_path | grep $class_name | wc -l)
    fi
    val_num=$(( $data_num / 10 ))

    ls $source_path | grep $class_name | sort -R | head -n $data_num | awk '{print "'$source_path'"$0;}' | xargs cp -t $class_tra_path
    ls $class_tra_path | sort -R | head -n $val_num | awk '{print "'$class_tra_path'"$0;}' | xargs mv -t $class_val_path
}

# product every class train/val
function split_data {
    source_path=$1
    target_path=$2
    data_num=$3

    mkdir $target_path/train
    mkdir $target_path/val
    move_class_file "$source_path" "$target_path" "$data_num" "cat"
    move_class_file "$source_path" "$target_path" "$data_num" "dog"
}

# product train(/val) and test data
function product_data {
    file_name=$1
    train_num=$2 # every class data num (train/val)
    test_num=$3

    # train(/val)
    if [ -d "./$file_name" ]; then
        rm -r ./$file_name
    fi
    mkdir $file_name

    split_data "./train/" "./$file_name/" "$train_num"

    # test
    if [ "$test_num" == "all" ]; then
        test_num=$(ls ./test/ | wc -l)
    fi

    mkdir $file_name/test
    ls ./test/ | sort -R | head -n $test_num | awk '{print "./test/"$0;}' | xargs cp -t $file_name/test
}

product_data "sample" "10" "10"
product_data "all" "all" "all"
