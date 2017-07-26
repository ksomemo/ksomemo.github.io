# pandas で read_s3 と to_s3
```py3
# http://stackoverflow.com/questions/35803601/reading-a-file-from-a-private-s3-bucket-to-a-pandas-dataframe
# 今後の動きはこのissue https://github.com/pydata/pandas/issues/11915
# milestone 0.18.1とのこと
import boto3
import pandas as pd

def read_s3(key, **kwargs):
    """read_csv("s3://xx|https://s3-xxx")がうまくいかなかった... py3.5.1"""
    s3_cleint = boto3.client('s3')
    obj = s3_cleint.get_object(Bucket='bucket', Key=key)
    return pd.read_csv(obj['Body'], **kwargs)

# ついでに作ってみた。けど、大きすぎるファイルの場合微妙かも
# その場合は、いったんfile -> upload -> os.remove
def to_s3(df, key, **kwargs):
    with io.StringIO() as buf:
        df.to_csv(buf, **kwargs)
        s3_client = boto3.client('s3')
        s3_client.put_object(
            Bucket='bucket', Key=key,
            Body=io.BytesIO(buf.getvalue().encode()))
```



