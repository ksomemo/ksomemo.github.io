# note jinja2 template engine
```py3
from jinja2 import (
    Environment,
    FileSystemLoader
)

env = Environment(loader=FileSystemLoader(templates_dir))
template = env.get_template(file_name)
rendered = template.render(**render_params)

"""
{% if var %}
  {{ var }}
{% else %}
  nothing
{% endif %}
"""

# var.attribute は、varが定義されていればundefined
# 定義されていなければerror
# 同様に var未定義でvarを評価するとundefinedとなるので、ifの条件に使える
# ここらへんはjavascriptに似てる
```
