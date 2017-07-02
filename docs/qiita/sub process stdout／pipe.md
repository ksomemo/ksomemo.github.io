```py3:sub_process_stdout_pipe.py
import os
import subprocess


def output():
    command = "python -V".split()
    ret = subprocess.check_output(command, stderr=subprocess.STDOUT)
    print(ret)


def call_with_pipe():
    gz_file = os.path.join(os.path.abspath(os.path.dirname(__file__)), "ababa.gz")
    print(gz_file)
    if os.path.exists(gz_file):
        os.remove(gz_file)
        print("remove")

    # command = "echo ababa | gzip > {}".format(gz_file).split()
    # ret = subprocess.check_call(command, shell=True)
    command = "echo ababa | gzip > {}".format(gz_file)
    ret = subprocess.check_call(command, shell=True)
    print(ret)

    if os.path.exists(gz_file):
        print("exists")

if __name__ == "__main__":       
    output()
    call()
```
