```py3:sqlalchemy_with_mssql.py
import yaml
import urllib
import sqlalchemy
from sqlalchemy.orm.session import sessionmaker


def create_engine():
    con_info = yaml.load(file)
    con_format = ";".join([
        "DRIVER={{SQL Server}}", # escape for format method
        "SERVER=localhost",
        "DATABASE={database}",
        "UID={user}",
        "PWD={password}",
    ]) + ";"
    con_params = urllib.parse.quote_plus(con_format.format(**con_info))
    engine = sqlalchemy.create_engine("mssql+pyodbc:///?odbc_connect=%s" % con_params)

    return engine


def select_df(query, params):
    Session = sessionmaker(bind=create_engine())
    session = Session()
    result = session.execute(query, params)

    if result.rowcount == 0:
        return pd.DataFrame(columns=result.keys())
    return pd.DataFrame((r for r in result), columns=result.keys())
```
