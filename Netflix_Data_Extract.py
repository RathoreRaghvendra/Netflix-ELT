import pandas as pd

df = pd.read_csv('netflix_titles.csv')

pip install psycopg2 sqlalchemy pandas
pip install psycopg2-binary

import sqlalchemy as sal

engine = sal.create_engine('postgresql+psycopg2://postgres:Rpsingh123@localhost:5432/Netflix_Analytics')
conn=engine.connect()

df.to_sql('netflix_raw', con=conn , index=False, if_exists = 'append')

df.head()

df[df.show_id=='s5023']

max(df.show_id.dropna().str.len())

df.isna().sum()