# request build schedule using requests(basic authorization／post and query)
```py3
import datetime
import requests


def request_job(query_params, post_data):
    url_format = "http://{host}:{port}/job/{job_name}/{build_type}"

    setting = {
        "host": "localhost",
        "port": "8080",
        "job_name": "job_name",
        "build_type": "buildWithParameters",
    }

    url = url_format.format(**setting)
    auth = requests.auth.HTTPBasicAuth("user", "pass")
    requests.post(url, params=query_params, data=post_data, auth=auth)


def request_schedule():
    today = datetime.date.today()
    now = datetime.datetime.now()
    t = execute_time = datetime.time(12, 0, 0)
    exec_t = datetime.datetime.combine(today, t)
    if exec_t < now:
        return
    query_params = {
        "delay": int(exec_t.timestamp() - now.timestamp()),
        "cause": "schedule-{}".format(exec_t),
        "token": "token",
    }
    post_data = {
        "build_datetime": str(exec_t),
　　　}
    request_job(query_params, post_data)
```
