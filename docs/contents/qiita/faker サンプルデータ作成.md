```0_faker サンプルデータ作成.txt
```

```bash:install-fake-factory.sh
# http://fake-factory.readthedocs.org/en/master/locales/ja_JP.html
# pip install fake-factory

# http://faker.readthedocs.org/en/master/locales/ja_JP.html
pip install faker
```

```py3:faker_sample.py
from faker import Factory
fake = Factory.create('ja_JP')
((fake.city(), fake.month()), (fake.city(), fake.month()))
# => (('東久留米市', '05'), ('鴨川市', '09'))

# サンプルデータを引数無しで作成するための確認
import pandas as pd
import inspect

# https://docs.python.org/3/library/inspect.html#inspect.Parameter
# https://docs.python.org/3/library/inspect.html#introspecting-callables-with-the-signature-object

def add(x, y):
    return x + y

class MyClass:
    def __init__(self, a, b, c="default"):
        pass
    
for p in inspect.signature(MyClass.__init__).parameters.values():
    print(p, type(p), p.kind, p.default, type(p.default))
    print(p.KEYWORD_ONLY and p.default is param.empty)

(
    p.KEYWORD_ONLY,
    p.POSITIONAL_ONLY,
    p.POSITIONAL_OR_KEYWORD,
    p.VAR_KEYWORD,
    p.VAR_POSITIONAL,
    
)

def sample_fake():
    for name, method in inspect.getmembers(fake, inspect.ismethod):
        if name.startswith("_"):
            print(name)
            continue
        try:
            sig = inspect.signature(method)
            params = sig.parameters.values()
            
            n_args = len(params)
            n_kwargs = sum(1 for p in params
                           if p.default is not p.empty)

            if n_args == 0 or n_kwargs == n_args:
                value = method()
            else:
                value = None
            
            yield {"key": name, "value": value,
                   "n_args": n_args,
                   "n_kwargs": n_kwargs}
        except Exception as e:
            print("method error:", name)

from IPython.display import display
with pd.option_context("display.max_rows", 300):
    display(pd.DataFrame(sample_fake()))

```

```txt:faker.log
## module
faker.providers.address
faker.providers.barcode
faker.providers.color
faker.providers.company
faker.providers.credit_card
faker.providers.currency
faker.providers.date_time
faker.providers.file
faker.providers.internet
faker.providers.job
faker.providers.lorem
faker.providers.misc
faker.providers.person
faker.providers.phone_number
faker.providers.profile
faker.providers.python
faker.providers.ssn
faker.providers.user_agent

## with argument
fake.geo_coordinate(center=None, radius=0.001)
fake.ean(length=13)
fake.credit_card_security_code(card_type=None)
fake.credit_card_provider(card_type=None)
fake.credit_card_full(card_type=None)
fake.credit_card_expire(start="now", end="+10y", date_format="%m/%y")
fake.credit_card_number(card_type=None)
fake.date_time_this_year(before_now=True, after_now=False, tzinfo=None)
fake.date_time_between_dates(datetime_start=None, datetime_end=None, tzinfo=None)
fake.date_time_between(start_date="-30y", end_date="now", tzinfo=None)
fake.time(pattern="%H:%M:%S")
fake.date_time_ad(tzinfo=None)
fake.date_time_this_month(before_now=True, after_now=False, tzinfo=None)
fake.date_time_this_decade(before_now=True, after_now=False, tzinfo=None)
fake.date(pattern="%Y-%m-%d")
fake.iso8601(tzinfo=None)
fake.date_time(tzinfo=None)
fake.date_time_this_century(before_now=True, after_now=False, tzinfo=None)
fake.mime_type(category=None)
fake.file_name(category=None, extension=None)
fake.file_extension(category=None)
fake.domain_word(*args, **kwargs)
fake.image_url(width=None, height=None)
fake.slug(*args, **kwargs)
fake.user_name(*args, **kwargs)
fake.uri_path(deep=None)
fake.text(max_nb_chars=200)
fake.sentence(nb_words=6, variable_nb_words=True)
fake.paragraphs(nb=3)
fake.words(nb=3)
fake.paragraph(nb_sentences=3, variable_nb_sentences=True)
fake.sentences(nb=3)
fake.password(length=10, special_chars=True, digits=True, upper_case=True, lower_case=True)
fake.md5(raw_output=False)
fake.sha1(raw_output=False)
fake.sha256(raw_output=False)
fake.boolean(chance_of_getting_true=50)
fake.profile(fields=None)
fake.pyiterable(nb_elements=10, variable_nb_elements=True, *value_types)
fake.pystr(max_chars=20)
fake.pyfloat(left_digits=None, right_digits=None, positive=False)
fake.pystruct(count=10, *value_types)
fake.pydecimal(left_digits=None, right_digits=None, positive=False)
fake.pylist(nb_elements=10, variable_nb_elements=True, *value_types)
fake.pytuple(nb_elements=10, variable_nb_elements=True, *value_types)
fake.pyset(nb_elements=10, variable_nb_elements=True, *value_types)
fake.pydict(nb_elements=10, variable_nb_elements=True, *value_types)
```
