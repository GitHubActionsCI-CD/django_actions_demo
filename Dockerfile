FROM python:3
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc
RUN python -m venv /opt/venv 
ENV PATH="/opt/venv/bin:${PATH}"
RUN pip install --upgrade pip 
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN useradd -ms /bin/bash test
USER test
WORKDIR /home/test
ADD . /home/test
COPY myapp/manage.py .
ENV PATH="/home/test/.local/bin:${PATH}"
COPY --chown=test:test . . 
CMD ["python", "manage.py"]
