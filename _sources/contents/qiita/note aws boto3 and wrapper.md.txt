```py3:aws_boto3_wrapper.py
import boto3
from botocore.exceptions import ClientError


class S3():
    def __init__(self, setting):
        # proxy設定が必要な場合は事前に設定
        session = boto3.session.Session(aws_access_key_id=setting.accesskey,
                                        aws_secret_access_key=setting.secretkey,
                                        region_name=setting.region)
        self.session = session.session
        self.s3_client = self.session.client('s3')
        self.s3 = self.session.resource('s3')
        self.bucket = self.s3.Bucket(self.setting.bucket_name)

    def get_available_resources(self):
        # ['cloudformation', 'dynamodb', 'ec2', 'glacier', 'iam', 'opsworks', 's3', 'sns', 'sqs']
        self.session.get_available_resources()

    def get_available_services(self):
        """一部リソース
        ['autoscaling', 'cloudfront', 'cloudhsm', 'cloudsearch',
        'cloudsearchdomain', 'cloudtrail',
        'cloudwatch', 'codecommit', 'codedeploy', 'codepipeline',
        'cognito-identity', 'cognito-sync',
        'config', 'datapipeline', 'devicefarm', 'directconnect', 'ds',
        'dynamodbstreams', 'ecs', 'efs',
        'elasticache', 'elasticbeanstalk', 'elastictranscoder',
        'elb', 'emr', 'importexport', 'kinesis',
        'kms', 'lambda', 'logs', 'machinelearning',
        'rds', 'redshift', 'route53', 'route53domains', 'sdb',
        'ses', 'ssm', 'storagegateway', 'sts', 'support', 'swf', 'workspaces']
        """
        self.session.get_available_services()

    def upload(self, file_path, key, bucket_name=None):
        if bucket_name:
            self.s3_client.upload_file(file_path, bucket_name, key)
        else:
            with open(file_path, 'rb') as f:
                r = self.bucket.put_object(Key=key, Body=f)
                print(r)
                # s3.Object(bucket_name='', key='')

    def download(self, key, download_path, bucket_name=None):
        if not bucket_name:
            bucket_name = self.setting.bucket_name
        try:
            self.s3_client.download_file(bucket_name, key, download_path)
        except ClientError as e:
            print(e)
            # print(e.parsed_response, e.operation_name)
            raise e

    def exists_bucket(self):
        exists = True
        try:
            self.s3.meta.client.head_bucket(Bucket=self.bucket_name)
        except Exception as e:
            # If a client error is thrown, then check that it was a 404 error.
            # If it was a 404 error, then the bucket does not exist.
            error_code = int(e.response['Error']['Code'])
            # print(e.response)
            if error_code == 404:
                exists = False
        return exists

    def object_all(self):
        for v in self.bucket.objects.all():
            print(v)

    def bucket_dir(self, key):
        bucket_dir = self.s3.Bucket(self.bucket_name + key)
        print(dir(bucket_dir.objects))
        # s3.Bucket.objectsCollectionManager(
        #   s3.Bucket(name='/'), s3.ObjectSummary)
        #     ['all', 'delete', 'filter', 'iterator', 'limit', 'page_size', 'pages']
        for v in bucket_dir.objects.pages():
            print(v)

    def list_objects(self, prefix):
        response = self.s3_c.list_objects(Bucket=self.bucket_name, Prefix=prefix)
        if 'Contents' in response:
            # 該当する key がないと response に 'Contents' が含まれない
            for content in response['Contents']:
                # <class 'boto3.resources.factory.s3.Object'>
                print(content)
                print(dir(content))

    def s3_object(self, key):
        try:
            obj = self.s3.Object(bucket_name=self.bucket_name, key=key)
            # key not exists, directory, file
            print(dir(obj))
            # <class 'boto3.resources.factory.s3.Object'>
            # ['Acl', 'Bucket', 'MultipartUpload', 'Version']
            # ['accept_ranges', 'bucket_name', 'cache_control',
            # 'content_disposition', 'content_encoding', 'content_language',
            # content_length', 'content_type', 'copy_from',
            # 'delete', 'delete_marker', 'e_tag', 'expiration', 'expires', 'get',
            # initiate_multipart_upload', 'key', 'last_modified',
            # 'load', 'meta', 'metadata', 'missing_meta', 'put', 'reload',
            # replication_status', 'request_charged', 'restore',
            # 'server_side_encryption', 'sse_customer_algorithm', 'sse_customer_key_md5',
            # ssekms_key_id', 'storage_class', 'version_id',
            # 'wait_until_exists', 'wait_until_not_exists', 'website_redirect_location']

            # content not found when obj is dir
            # obj.content_length
            # obj.content_type
            # obj.content_encoding
            # obj.content_language
            # obj.content_disposition

            print(obj.key)
            print(obj.meta)
            print(obj.metadata)

            # response
            response = obj.get()
            # {'ContentType': 'text/tab-separated-values',
            # 'LastModified': datetime.datetime(yyyy, m, d, h, m, s, tzinfo=tzutc()),
            # 'ETag': '""',
            # 'ResponseMetadata': {
            #    'HostId':
            #       '',
            #    'RequestId': '', 'HTTPStatusCode': 200},
            # 'Body': <botocore.response.StreamingBody object at 0x00000000055D6CC0>,
            # 'ContentLength': 1103, 'Metadata': {}, 'AcceptRanges': 'bytes'}
            # <class 'dict'>

            data = response['Body'].read()
            print(data)
        except Exception as e:
            # except ClientError as e: -> <class 'botocore.exceptions.ClientError'>
            print(e)

    def buckets_all(self):
        for bucket in self.s3.buckets.all():
            pass
```
