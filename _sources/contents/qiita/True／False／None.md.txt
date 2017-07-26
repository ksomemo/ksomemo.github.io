# python True／False／None
```python3
import numpy as np
import pandas as pd
import array

values = [
    0, 0.0, 1, -1,
    0j, 0.0j, 1j, -1j,
    False, True,
    '', '0', '0.0', '1',
    [], [False],
    (), (False,),
    {}, {False: False},
    object(),
    None,
    np.nan,
    np.array([]), np.array([False]), np.array([True]), np.array([0]), np.array([1]),
    array.array('b', []), array.array('b', [0]),
]

t(pd.DataFrame())
# ValueError: The truth value of a DataFrame is ambiguous. Use a.empty, a.bool(), a.item(), a.any() or a.all().
# -> not v == None, bool(v)
Empty DataFrame
Columns: []
Index: [] is     None -> False
Empty DataFrame
Columns: []
Index: [] is not None -> True
Empty DataFrame
Columns: []
Index: [] ==     None -> Empty DataFrame
Columns: []
Index: []
Empty DataFrame
Columns: []
Index: [] !=     None -> Empty DataFrame
Columns: []
Index: []



t(pd.DataFrame([False]))
# TypeError: Could not compare [None] with block values
# -> v == None, v != None
# -> not v == None, bool(v)

       0
0  False is     None -> False
       0
0  False is not None -> True

def t(v):
    print("%r is     None -> %s" % (v, v is None))
    print("%r is not None -> %s" % (v, v is not None))
    print("%r ==     None -> %s" % (v, v == None))
    print("%r !=     None -> %s" % (v, v != None))
    print("not %r == None -> %s" % (v, not v == None))
    print("bool(%r)       -> %s" % (v, bool(v)))
    print()

# result
list(map(t, values))

0 is     None -> False
0 is not None -> True
0 ==     None -> False
0 !=     None -> True
not 0 == None -> True
bool(0)       -> False

0.0 is     None -> False
0.0 is not None -> True
0.0 ==     None -> False
0.0 !=     None -> True
not 0.0 == None -> True
bool(0.0)       -> False

1 is     None -> False
1 is not None -> True
1 ==     None -> False
1 !=     None -> True
not 1 == None -> True
bool(1)       -> True

-1 is     None -> False
-1 is not None -> True
-1 ==     None -> False
-1 !=     None -> True
not -1 == None -> True
bool(-1)       -> True

0j is     None -> False
0j is not None -> True
0j ==     None -> False
0j !=     None -> True
not 0j == None -> True
bool(0j)       -> False

0j is     None -> False
0j is not None -> True
0j ==     None -> False
0j !=     None -> True
not 0j == None -> True
bool(0j)       -> False

1j is     None -> False
1j is not None -> True
1j ==     None -> False
1j !=     None -> True
not 1j == None -> True
bool(1j)       -> True

(-0-1j) is     None -> False
(-0-1j) is not None -> True
(-0-1j) ==     None -> False
(-0-1j) !=     None -> True
not (-0-1j) == None -> True
bool((-0-1j))       -> True

False is     None -> False
False is not None -> True
False ==     None -> False
False !=     None -> True
not False == None -> True
bool(False)       -> False

True is     None -> False
True is not None -> True
True ==     None -> False
True !=     None -> True
not True == None -> True
bool(True)       -> True

'' is     None -> False
'' is not None -> True
'' ==     None -> False
'' !=     None -> True
not '' == None -> True
bool('')       -> False

'0' is     None -> False
'0' is not None -> True
'0' ==     None -> False
'0' !=     None -> True
not '0' == None -> True
bool('0')       -> True

'0.0' is     None -> False
'0.0' is not None -> True
'0.0' ==     None -> False
'0.0' !=     None -> True
not '0.0' == None -> True
bool('0.0')       -> True

'1' is     None -> False
'1' is not None -> True
'1' ==     None -> False
'1' !=     None -> True
not '1' == None -> True
bool('1')       -> True

[] is     None -> False
[] is not None -> True
[] ==     None -> False
[] !=     None -> True
not [] == None -> True
bool([])       -> False

[False] is     None -> False
[False] is not None -> True
[False] ==     None -> False
[False] !=     None -> True
not [False] == None -> True
bool([False])       -> True

() is     None -> False
() is not None -> True
() ==     None -> False
() !=     None -> True
not () == None -> True
bool(())       -> False

(False,) is     None -> False
(False,) is not None -> True
(False,) ==     None -> False
(False,) !=     None -> True
not (False,) == None -> True
bool((False,))       -> True

{} is     None -> False
{} is not None -> True
{} ==     None -> False
{} !=     None -> True
not {} == None -> True
bool({})       -> False

{False: False} is     None -> False
{False: False} is not None -> True
{False: False} ==     None -> False
{False: False} !=     None -> True
not {False: False} == None -> True
bool({False: False})       -> True

<object object at 0x102802290> is     None -> False
<object object at 0x102802290> is not None -> True
<object object at 0x102802290> ==     None -> False
<object object at 0x102802290> !=     None -> True
not <object object at 0x102802290> == None -> True
bool(<object object at 0x102802290>)       -> True

None is     None -> True
None is not None -> False
None ==     None -> True
None !=     None -> False
not None == None -> False
bool(None)       -> False

nan is     None -> False
nan is not None -> True
nan ==     None -> False
nan !=     None -> True
not nan == None -> True
bool(nan)       -> True

array([], dtype=float64) is     None -> False
array([], dtype=float64) is not None -> True
/Users/xxx/.pyenv/versions/miniconda3-3.9.1/bin/ipython:4: FutureWarning: comparison to `None` will result in an elementwise object comparison in the future.
  from IPython import start_ipython
array([], dtype=float64) ==     None -> False
/Users/xxx/.pyenv/versions/miniconda3-3.9.1/bin/ipython:5: FutureWarning: comparison to `None` will result in an elementwise object comparison in the future.

array([], dtype=float64) !=     None -> True
/Users/xxx/.pyenv/versions/miniconda3-3.9.1/bin/ipython:6: FutureWarning: comparison to `None` will result in an elementwise object comparison in the future.
  sys.exit(start_ipython())
not array([], dtype=float64) == None -> True
bool(array([], dtype=float64))       -> False

array([False], dtype=bool) is     None -> False
array([False], dtype=bool) is not None -> True
array([False], dtype=bool) ==     None -> False
array([False], dtype=bool) !=     None -> True
not array([False], dtype=bool) == None -> True
bool(array([False], dtype=bool))       -> False

array([ True], dtype=bool) is     None -> False
array([ True], dtype=bool) is not None -> True
array([ True], dtype=bool) ==     None -> False
array([ True], dtype=bool) !=     None -> True
not array([ True], dtype=bool) == None -> True
bool(array([ True], dtype=bool))       -> True

array([0]) is     None -> False
array([0]) is not None -> True
array([0]) ==     None -> False
array([0]) !=     None -> True
not array([0]) == None -> True
bool(array([0]))       -> False

array([1]) is     None -> False
array([1]) is not None -> True
array([1]) ==     None -> False
array([1]) !=     None -> True
not array([1]) == None -> True
bool(array([1]))       -> True

array('b') is     None -> False
array('b') is not None -> True
array('b') ==     None -> False
array('b') !=     None -> True
not array('b') == None -> True
bool(array('b'))       -> False

array('b', [0]) is     None -> False
array('b', [0]) is not None -> True
array('b', [0]) ==     None -> False
array('b', [0]) !=     None -> True
not array('b', [0]) == None -> True
bool(array('b', [0]))       -> True
```
