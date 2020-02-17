FROM conda/miniconda3:latest

ENV MLFLOW_HOME /opt/mlflow
ENV ARTIFACT_STORE ${MLFLOW_HOME}/artifactStore

RUN mkdir -p ${MLFLOW_HOME}/scripts && \
    mkdir -p ${ARTIFACT_STORE}

WORKDIR ${MLFLOW_HOME}

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN echo "export LC_ALL=$LC_ALL" >> /etc/profile.d/locale.sh
RUN echo "export LANG=$LANG" >> /etc/profile.d/locale.sh

RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libpq-dev

RUN pip install -U pip && \
    pip install psycopg2 mlflow

COPY ./start.sh ./start.sh
RUN chmod +x ./start.sh

EXPOSE 80
EXPOSE 443

CMD ["./start.sh"]
