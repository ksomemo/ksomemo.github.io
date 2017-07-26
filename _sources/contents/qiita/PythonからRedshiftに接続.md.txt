# PythonからRedshiftに接続
## 動機
- PythonからRedshiftに接続してpandasで扱いたい
- 元々、SQLServer + sqlalchemy 環境だったのでsqlalchemyも使えるようにしたい

## Psycopg2
- postgresql driver
- 上記単体では使いにくい＋Redshiftは分析用なのでpandas.read_sqlのengineとして利用すると便利

### install
<del>ハマった。whlとして用意されているものを使うようにした</del>

上記は、Windows環境でのbuild失敗によるもの。しかし、最近はwheel対応したのでpypiからinstall可能である

- <del>http://prunus1350.hatenablog.com/entry/2016/01/09/135110</del>
- <del>http://www.lfd.uci.edu/~gohlke/pythonlibs/</del>
- <del>http://stackoverflow.com/questions/28611808/how-to-install-psycopg2-for-python-3-5</del>
- https://pip.pypa.io/en/latest/user_guide/#installing-from-wheels
- https://pypi.python.org/pypi/psycopg2

### 名前付きパラメータ
- http://initd.org/psycopg/docs/usage.html#passing-parameters-to-sql-queries

### 結果セットのカラム名
- http://initd.org/psycopg/docs/advanced.html?highlight=column
- http://stackoverflow.com/questions/10252247/how-do-i-get-a-list-of-column-names-from-a-psycopg2-cursor

### 応用
http://tdoc.info/blog/2012/12/05/psycopg2.html

### SSL(certificate)
http://stackoverflow.com/questions/28228241/how-to-connect-to-a-remote-postgresql-database-with-python


## sqlalchemy-redshift
sqlalchemyのengineにpsycopg2を使うため

### 利点
- transactionを使う場合など、connection/engine以外の用途でsqlalchemyを利用しつつ、pandasのengineに流用できる
- psycopg2では`%(parameter_name)s`による指定をsqlalchemyでは`:parameter_name`による指定にできる。
  - ただし、Likeで使うワイルドカード`%`に作用するので、ワイルドカードそのものを含んだパラメータにする必要がある点は変わらない

### ハマった点
- sqlalchemyの場合はdefaultで必要な設定になっていた
    - psycopg2では証明書の必要でない設定になっている

### install
```bash
pip install sqlalchemy-redshift
```

- https://pypi.python.org/pypi/sqlalchemy-redshift
- https://github.com/sqlalchemy-redshift/sqlalchemy-redshift/blob/master/sqlalchemy_redshift/redshift-ssl-ca-cert.pem ?

## code
psycopg2_and_sqlalchemy_and_pandas.py

```py3
import sqlalchemy
import psycopg2
import psycopg2.extras
import pandas as pd


con_info = {
    "host": "localhost",
    "port": port,
    "dbname": "dbname",
    "password": "password",
    "username": "username",
}


def main():
    example_psycopg2_dict()
    example_psycopg2()
    example_redshift_pd()


def con_psycopg2():
    con_fomart = "dbname={dbname} host={host} user={username} password={password} port={port}"
    return psycopg2.connect(con_fomart.format(**con_info))


def create_engine_redshift():
    con_format = 'redshift+psycopg2://{username}:{password}@{host}:{port}/{dbname}'
    connect_args = {
        # "sslmode": "disable",
        # "sslmode": "require",
        "sslmode": "prefer",
    }
    return sqlalchemy.create_engine(con_format.format(**con_info), connect_args=connect_args)


def example_psycopg2_dict():
    conn = con_psycopg2()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("SELECT * FROM table_name limit 2;")
    for row in cur.fetchall():
        # print(row, type(row), dir(row))
        print(row, row["birthday"], row["column2"])
        # [datetime.date(2016, 4, 1), 1, 0, 1, 1, ''] <class 'psycopg2.extras.DictRow'
        ['_index', 'append', 'clear', 'copy', 'count', 'extend',
        'get', 'index', 'insert', 'items', 'keys', 'pop', 'remove', 'reverse', 'sort', 'values']
    cur.close()
    conn.close()


def example_psycopg2():
    conn = con_psycopg2()

    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM table_name;")
    print(cur.fetchone())

    raw_query = """
        SELECT *
        FROM table_name
        WHERE column1 = %(column1)s
        AND column2 = %(column2)s
    """
    params = {"column1": 1, "column2": 1}
    cur.execute(raw_query, params)
    # cur.execute("SELECT * FROM table_name;")
    for row in cur.fetchall():
        print(row)

    cur.execute(raw_query, params)
    # print([a for a in dir(cur) if not a.startswith("_")])
    attrs = [
        'arraysize', 'binary_types', 'callproc', 'cast', 'close', 'closed', 'connection',
        'copy_expert', 'copy_from', 'copy_to', 'description', 'execute', 'executemany',
        'fetchall', 'fetchmany', 'fetchone', 'itersize', 'lastrowid', 'mogrify',
        'name', 'nextset', 'query', 'row_factory', 'rowcount', 'rownumber',
        'scroll', 'scrollable', 'setinputsizes', 'setoutputsize', 'statusmessage',
        'string_types', 'typecaster', 'tzinfo_factory', 'withhold']
    columns = [d.name for d in cur.description]
    description = cur.description[0]
    # print(description, type(description))
    # Column(
    #    name='birthday', type_code=1082, display_size=None, internal_size=4,
    #    precision=None, scale=None, null_ok=None)
    # <class 'psycopg2.extensions.Column'>
    df = pd.DataFrame(cur.fetchall(), columns=columns)

    cur.close()
    conn.close()


def example_redshift_pd():
    return pd.read_sql(
        """SELECT *
        FROM table_name
        WHERE column1 = %(column1)s;""",
        # 下記2つはsqlalchemy-redshiftを利用
        # WHERE column1 = :column1;""",
        # con=create_engine_redshift(),
        con=con_psycopg2(),
        params={"column1": 1}
    )

if __name__ == "__main__":
    main()
```

## SSL Mode(with sqlalchemy)
```
sslmode not specify

  File "psycopg2\__init__.py", line 164, in connect
    conn = _connect(dsn, connection_factory=connection_factory, async=async)

sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) server common name
"endpoint.ap-northeast-1.redshift.amazonaws.com" does not match host name "127.0.0.1"


sslmode: disable

  File "psycopg2\__init__.py", line 164, in connect
    conn = _connect(dsn, connection_factory=connection_factory, async=async)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError)
FATAL:  no pg_hba.conf entry for host "xxx.xxx.xxx.xxx", user "username", database "dbname", SSL off

sslmode: prefer, require -> no error
```

## SQLAlchemy/MySQL
- engineのconnect_argsを知るきっかけ
- http://stackoverflow.com/questions/8014781/how-to-make-mysql-connection-that-requires-ca-cert-with-sqlalchemy-or-sqlobject

## Postgresql
### SSL
- http://www.postgresql.org/docs/current/static/libpq-connect.html#LIBPQ-CONNSTRING
- http://www.postgresql.org/docs/current/static/libpq-ssl.html
- http://www.postgresql.org/docs/current/static/runtime-config-connection.html#RUNTIME-CONFIG-CONNECTION-SECURITY
- https://fedorahosted.org/spacewalk/wiki/HowToPostgreSQLwithClientCertificates

## redshift
### SSL/Postgresql
- http://dev.classmethod.jp/cloud/aws/connect-to-redshift-cluster-with-ssl/
- http://docs.aws.amazon.com/ja_jp/redshift/latest/mgmt/connecting-ssl-support.html
- http://docs.aws.amazon.com/ja_jp/redshift/latest/mgmt/connecting-from-psql.html

### SQL
- http://docs.aws.amazon.com/ja_jp/redshift/latest/dg/r_Examples_with_TOP.html
- http://docs.aws.amazon.com/ja_jp/redshift/latest/dg/r_ORDER_BY_clause.html

### Transaction
- http://docs.aws.amazon.com/ja_jp/redshift/latest/dg/r_BEGIN.html

## その他
### HTTPS 時の証明書関連エラーを防ぐための .wgetrc 設定
- http://friendsnow.hatenablog.com/entry/2014/03/22/012410
- http://qiita.com/cuzic/items/b24803dc0858079b4fb3

### forward with paramiko
- http://stackoverflow.com/questions/31506958/sqlalchemy-through-paramiko-ssh
- https://github.com/paramiko/paramiko/blob/master/demos/forward.py#L54
