# argparseのサブコマンドからのdispatchと引数の一致

## 問題点
- クラスへ割り当て各メソッドをサブコマンドとする場合、サブコマンド間で異なる引数をInit時にむりくりContextとする
- ContextObjectを作って各関数に割り当てても同じ
- どちらの場合もメソッド・関数の引数がないに等しい
- ただし、クラスなら一応他でも使える

というのを考えた時、関数から地道に各サブコマンドに対応するContextを処理して、それぞれのクラスにしたほうがよさそう？Airflowがそうしていた

## コード
arg_context.py

```python3
import argparse

class MyClass:
	def __init__(self, year, month):
		self.year = year
		self.month = month

	def fun():
		# do something

class Context:
	def __init__(self, args):
		self.year = args.year
		self.month = args.month


def func1_for_sub(args):
	context = Context(args)
	# do something

if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	subparsers = parser.add_subparsers()
	parser.add_argument('-y', '--year', required=True, type=int)
	parser.add_argument('-m', '--month', required=True, type=int)

	subcommand_parser = subparsers.add_parser('subcommand')
	subcommand_parser.set_defaults(func=MyClass.fun)

	args = parser.parse_args()
	funcname = args.func.__name__
	del args.func
	c = MyClass(**vars(args))
	getattr(c, funcname)()
```


args_to_dict.py

```python3
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers()
    parser.add_argument('-y', '--year', required=True, type=int)
    parser.add_argument('-m', '--month', required=True, type=int)
    parser.add_argument('-d', '--day', required=True, type=int)

    mytest_parser = subparsers.add_parser('mytest')
    def mytest(year, month, day):
        print(locals())
    mytest_parser.set_defaults(func=mytest)

    args = parser.parse_args()
    print(args) # namespace object
    dict_args = vars(args)
    #args.func(**dict_args) # TypeError: mytest() got an unexpected keyword argument 'func'
```
