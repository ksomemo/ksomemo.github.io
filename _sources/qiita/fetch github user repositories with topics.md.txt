```py3:get_github_user_repositories.py
import requests
import pandas as pd
import time


def get_repos():
    """repositories
    https://developer.github.com/v3/repos/#list-user-repositories
    """
    url = "https://api.github.com/users/{}/repos"
    user = "ksomemo"
    headers = {
        "Accept": "application/vnd.github.mercy-preview+json"
    }
    params = {
        "type": "owner"
    }
    res = requests.get(url.format(user), headers=headers, params=params)
    yield pd.DataFrame(res.json())

    def get_more_repos(res):
        next_val = res.links.get("next")
        next_url = ""
        if next_val:
            next_url = next_val.get("url")
        if next_url:
            time.sleep(1)
            res = requests.get(next_url, headers=headers, params=params)
            yield pd.DataFrame(res.json())
            yield from get_more_repos(res)

    yield from get_more_repos(res)

repos = pd.concat(get_repos())
my_repos_topics = repos[~ repos.fork].topics
```
