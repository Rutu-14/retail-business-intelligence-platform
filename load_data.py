import pandas as pd
from sqlalchemy import create_engine

df = pd.read_csv(
    r"C:\Users\Rutuja\Retail-Business-Intelligence-Platform\datasets\cleaned_superstore.csv"
)

engine = create_engine(
    "mysql+pymysql://root:Rutuja#2002@localhost/retail_analytics"
)

df.to_sql(
    "orders",
    con=engine,
    if_exists="replace",
    index=False
)

print("Data loaded successfully!")