## multiprocess/thread
- interfaceが似ている
- threadは見たことがない

```py3:multiprocess_thread.py
import multiprocessing as mp
import threading as th
import datetime

n_loop = 10000 ** 2
n_x = 8


def loop():
    for _ in range(n_loop):
        pass


def run(klass):
    xs = []
    for _ in range(n_x):
        x = klass(target=loop)
        x.start()
        xs.append(x)

    for x in xs:
        x.join()


def main():
    print("start", datetime.datetime.now())
    print("-"*10)

    run(mp.Process)
    print("run end(mp)", datetime.datetime.now())
    print("-"*10)

    run(th.Thread)
    print("run end(th)", datetime.datetime.now())
    print("-"*10)

    for _ in range(n_x):
        loop()

    print("loop end", datetime.datetime.now())

if __name__ == "__main__":
    main()
```

### arguments
引数はiterator, keyword引数はdict

```multiprocess_using_arguments.py
def print_args(arg1, arg2, kwarg1=3, kwarg2=4, **kwargs):
    print(arg1, arg2)
    print(kwarg1, kwarg2)
    print(kwargs)
    return arg1 + arg2

x = mp.Process(target=print_args, args=(1, 2),
                                  kwargs={"kwarg1":5, "kwargs100":10})
x.start()
1 2
5 4
{'kwargs100': 100}
```

### Pool
- 結果を返してくれる
- lambdaがダメだった
- mapは単一引数
    - startmapは複数可能
- applyはkeywordを渡せる
    - async版がある
    - context抜ける前に処理しないとダメ

```multiprocess_pool.py
def add(x, y): return x + y
with mp.Pool() as p:
    results = p.starmap(add, [(1, 2), (3, 4)])
    result = p.apply(print_args, args=(5, 6), kwds={"kwarg1":5, "kwarg100":100})
    async_result = p.apply_async(print_args, args=(7, 8), kwds={"kwarg1":5, "kwarg100":100})
    print(async_result.get(timeout=2))
    # => 15
print(results)
# => [3, 7]
print(result)
# => 11
```

### other
- Queue/Pipe
    - message passing
- Lock
- Semaphore

もっと簡単に使いたい場合や非同期処理は下記でよさそう

- concurrent.futures
- async/await

## joblib
- sklearnのexternalsとして利用されている
- Queueはないので置き換えらなさそう
    - multiprocessingより良い点がある
    - https://pythonhosted.org/joblib/parallel.html#bad-interaction-of-multiprocessing-and-third-party-libraries
- 雑に測定してみた

```example_joblib.py
import joblib
import time

%timeit joblib.Parallel(n_jobs=1)(joblib.delayed(time.sleep)(0.1) for i in range(100))
1 loop, best of 3: 10.3 s per loop

%timeit joblib.Parallel(n_jobs=-1)(joblib.delayed(time.sleep)(0.1) for i in range(100))
1 loop, best of 3: 2.7 s per loop

%timeit [time.sleep(0.1) for i in range(100)]
1 loop, best of 3: 10.2 s per loop

joblib.Parallel(n_jobs=-1)(
    joblib.delayed(print_args)(i, 2, kwarg1=5, kwarg100=100)
    for i in range(3))
```
