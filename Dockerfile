FROM jupyter/tensorflow-notebook:d113a601dbb8

WORKDIR /home/work
ENV HOME /home/work

USER jovyan

COPY requirements.txt ./requirements.txt
RUN pip install -U pip && \
    pip install --no-cache-dir -r ./requirements.txt

USER root

#mecab
RUN apt-get -y update && \
    apt-get -y install \
    curl \
    file \
    mecab \
    libmecab-dev \
    mecab-ipadic \    
    mecab-ipadic-utf8 && \
    git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    cd mecab-ipadic-neologd &&\
    ./bin/install-mecab-ipadic-neologd -n -y && \
    rm -r ${HOME}/mecab-ipadic-neologd

RUN rm requirements.txt

CMD start.sh jupyter notebook --NotebookApp.token=''

