# run job and job history(雑)

```py3
import datetime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.schema import Column
from sqlalchemy.types import (
    String,
    Integer,
    DateTime,
    Date
)

Base = declarative_base()


class JobHistory(Base):
    __tablename__ = 'job_history'

    job_id = Column(Integer, primary_key=True)
    name = Column(String)
    target_date = Column(Date)
    created_at = Column(DateTime, default=datetime.datetime.now)
    updated_at = Column(DateTime, default=datetime.datetime.now, onupdate=datetime.datetime.now)
    is_finished = Column(Integer, default=0)

    @staticmethod
    def recent_job_history(target_date, session):
        params = {"target_date": target_date}
        return session.query(JobHistory) \
            .filter_by(**params) \
            .order_by(JobHistory.created_at.desc()) \
            .first()


def runnable_job(before, cur):
    if not before:
        return False

    if not before.is_finished:
        return False

    if not cur:
        return True

    return False

def run(target_date):
    with session_scope() as session:
        before_date = target_date + relativedelta(days=-1)
        cur = JobHistory.recent_job_history(target_date, session)
        before = JobHistory.recent_job_history(before_date, session)
        if not runnable_job(before, cur):
            return

        try:
            cur_job = JobHistory(
                target_date=target_date,
                name="name"
            )
            session.add(cur_job)
            daily.run(target_date.year, target_date.month, target_date.day)
            cur_job.is_finished = 1
        except:
            raise
```
