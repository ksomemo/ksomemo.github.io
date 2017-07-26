# python logging
## logging_sample.py
```py3
from logging import (
	getLogger,
	StreamHandler,
	DEBUG
)


# logger
logger = getLogger(__name__)
handler = StreamHandler()
handler.setLevel(DEBUG)
logger.setLevel(DEBUG)
logger.addHandler(handler)

logger.debug('hello')
logger.info('hello')
logger.warn('hello')
logger.error('hello')
```

## http://docs.python.jp/3/howto/logging.html#logging-flow

## level
- DEBUG
- INFO
- ERROR
- FATAL
- CRITICAL
- WARN(WARNING)

## advanced logging
http://docs.python.jp/3/howto/logging.html#advanced-logging-tutorial

- ロガーは、アプリケーションコードが直接使うインタフェースを公開します。
- ハンドラは、(ロガーによって生成された) ログ記録を適切な送信先に送ります。
- フィルタは、どのログ記録を出力するかを決定する、きめ細かい機能を提供します。
- フォーマッタは、ログ記録が最終的に出力されるレイアウトを指定します。

- ログイベント情報は LogRecord インスタンスの形で、
  - logger, handler, filter, formatter の間でやりとりされます。

## cookbook
http://docs.python.jp/3/howto/logging-cookbook.html#filters-contextual

## handler

- StreamHandler(stream=)
- FileHandler(filename=)
- NullHandler

### other
`import logging.handlers`

- WatchedFileHandler
- RotatingFileHandler
- TimedRotatingFileHandler
- SocketHandler
- DatagramHandler(UDP)
- SysLogHandler
- NTEventLogHandler
- SMTPHandler
- MemoryHandler
- HTTPHandler
- QueueHandler
  - QueueListener

## filter
http://docs.python.jp/3/library/logging.html#filter

フィルタ (Filter) は、ハンドラ や ロガー によって使われ、
レベルによって提供されるのよりも洗練されたフィルタリングを実現します。
基底のフィルタクラスは、ロガー階層構造内の特定地点の配下にあるイベントだけを許可します。
例えば、’A.B’ で初期化されたフィルタは、
ロガー ‘A.B’, ‘A.B.C’, ‘A.B.C.D’, ‘A.B.D’ 等によって記録されたイベントは許可しますが、
’A.BB’, ‘B.A.B’ などは許可しません。
空の文字列で初期化された場合、すべてのイベントを通過させます。


## format
```py3
logging.BASIC_FORMAT
'%(levelname)s:%(name)s:%(message)s'

formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# http://docs.python.jp/3/library/logging.html#logrecord-attributes
```

### handler
```py3
fh.setFormatter(formatter)
ch.setFormatter(formatter)
```

## warnings ?
```py3
logging.warnings
<module 'warnings' from 'C:\\Anaconda3\\lib\\warnings.py'>
```

## config
```py3
# http://docs.python.jp/3/library/logging.config.html
import logging.config

logging.config.fileConfig('config_file.conf')
```

## example
```py3
from logging import (
	getLogger,
	Formatter,
	FileHandler,
	DEBUG
)
from pprint import pprint

## logger
logger = getLogger(__name__)

logrecord_attributes = [
	'asctime', 'name', 'levelname', 'message',
	'filename', 'funcName', 'lineno', 'module',
]
func = lambda x: '%({0})s'.format(x)
format = ' - '.join(list(map(func, logrecord_attributes)))

formatter = Formatter(format)

handler = FileHandler(filename='loggin_file_handle.log')
handler.setFormatter(formatter)
handler.setLevel(DEBUG)
logger.setLevel(DEBUG)
logger.addHandler(handler)


print(logger)
pprint(dir(logger))
pprint(logger.__dict__)

def log(msg):
	logger.debug(msg + ' hello')
	logger.info(msg + ' hello')
	logger.warn(msg + ' hello')
	logger.error(msg + ' hello')
```
