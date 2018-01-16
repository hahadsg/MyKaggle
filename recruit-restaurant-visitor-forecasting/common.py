# coding: utf8
import os

import pandas as pd

features_path = './data/output/features/'

def read_features():
    data_df = pd.read_csv(os.path.join(features_path, 'data.csv'))
    feature_columns = pd.read_csv(os.path.join(features_path, 'feature_columns.csv'), header=None).values[:, 0].tolist()
    return data_df, feature_columns

def save_features(full_df, feature_columns):
    full_df.to_csv(os.path.join(features_path, 'data.csv'), index=False)
    pd.DataFrame(feature_columns).to_csv(os.path.join(features_path, 'feature_columns.csv'), index=False, header=False)