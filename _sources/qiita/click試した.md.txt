```links.md
- http://click.pocoo.org/5/commands/
- http://click.pocoo.org/5/testing/
- http://docs.python.jp/3.5/library/argparse.html#parsing-arguments
```

```0_python_click_impressions.md
- Clickは簡単に書ける
- 引数が素直に書ける
- testも簡単らしい
- argparseのテストは？と思ったら引数を与えるとできるらしい（知らなかった・・・）
```

```py3:argparse_parse_args_input_str.py
import argparse


parser = argparse.ArgumentParser()
parser.add_argument('-y', '--year')
parser.add_argument('-m', '--month')

args = parser.parse_args('-y 2015 --month 1'.split(' '))
# Namespace(month='1', year='2015')
```

```py3:click_ex.py
import click


@click.command()
@click.argument('year', type=int)
@click.argument('month', type=int)
@click.option('-d', '--day', type=int)
def cli(year, month, day):
	print(year, month, day)

if __name__ == "__main__":
	cli()
```

```py3:click_ex_sub.py
import click


@click.group()
@click.argument('year', type=int)
@click.argument('month', type=int)
@click.option('-d', '--day', type=int)
def cli(year, month, day):
	print(year, month, day)

@click.command()
def first():
	click.echo('first')

@click.command()
def second():
	print("second")

cli.add_command(first)
cli.add_command(second)

if __name__ == "__main__":
	cli()
```

```py3:click_ex_merge.py
import click


@click.group()
def cli1():
	print("cli1")

@cli1.command()
def cmd1():
	"""Command on cli1"""
	print("cmd1")

@cli1.command()
def cmd1_2():
	"""Command on cli1_2"""
	print("cmd1_2")

@click.group()
def cli2():
	print("cli2")

@cli2.command()
def cmd2():
	"""Command on cli2"""
	print("cmd2")

@cli2.command()
def cmd2_2():
	"""Command on cli2"""
	print("cmd2_2")

cli = click.CommandCollection(sources=[cli1, cli2])

if __name__ == '__main__':
	cli()
```

```txt:run_click.log
$ python click_ex.py
Usage: click_ex.py [OPTIONS] YEAR MONTH

Error: Missing argument "year".

$ python click_ex.py a b
Usage: click_ex.py [OPTIONS] YEAR MONTH

Error: Invalid value for "year": a is not a valid integer

$ python click_ex.py 2015 10
2015 10 None

$ python click_ex.py 2015 10 -d 11
2015 10 11

$ python click_ex.py 2015 10 --day 11
2015 10 11

$ python click_ex.py -h
Error: no such option: -h

$ python click_ex.py --help
Usage: click_ex.py [OPTIONS] YEAR MONTH

Options:
  -d, --day INTEGER
  --help             Show this message and exit.

####################
$ python click_ex_sub.py
Usage: click_ex_sub.py [OPTIONS] YEAR MONTH COMMAND [ARGS]...

Options:
  -d, --day INTEGER
  --help             Show this message and exit.

Commands:
  first
  second

$ python click_ex_sub.py 2015 10
Usage: click_ex_sub.py [OPTIONS] YEAR MONTH COMMAND [ARGS]...

Error: Missing command.

$ python click_ex_sub.py 2015 10 first
2015 10 None
first

$ python click_ex_sub.py 2015 10 second
2015 10 None
second

####################
$ python click_ex_merge.py
Usage: click_ex_merge.py [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  cmd1    Command on cli1
  cmd1_2  Command on cli1_2
  cmd2    Command on cli2
  cmd2_2  Command on cli2_2

$ python click_ex_merge.py cmd1
cmd1

$ python click_ex_merge.py cmd1_2
cmd1_2
```
