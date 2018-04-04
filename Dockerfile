FROM ubuntu:16.04

WORKDIR work

# mecab
RUN apt-get update && apt-get install -y curl \
    make \
    gcc \
    build-essential \
    git \
    libmecab2 \
    libmecab-dev \
    mecab \
    mecab-ipadic \
    mecab-ipadic-utf8 \
    mecab-utils \
    python \
    python3 \
    python-dev

# cabocha
RUN curl -L -o CRF++-0.58.tar.gz 'https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7QVR6VXJ5dWExSTQ' \
    && tar zxf CRF++-0.58.tar.gz
WORKDIR CRF++-0.58
RUN ./configure \
    && make \
    && make install \
    && ldconfig
WORKDIR ../
RUN curl -c  cabocha-0.69.tar.bz2 -s -L "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7SDd1Q1dUQkZQaUU" |grep confirm |  sed -e "s/^.*confirm=\(.*\)&amp;id=.*$/\1/" | xargs -I{} \
    curl -b  cabocha-0.69.tar.bz2 -L -o cabocha-0.69.tar.bz2 "https://drive.google.com/uc?confirm={}&export=download&id=0B4y35FiV1wh7SDd1Q1dUQkZQaUU"
RUN tar xjf cabocha-0.69.tar.bz2
WORKDIR cabocha-0.69
RUN ./configure --with-mecab-config='which mecab-config' --with-charset=UTF8 \
    && make \
    && make install \
    && ldconfig \
    && cd python \
    && python setup.py install

# juman++
WORKDIR ../
RUN apt-get install -y libboost-all-dev
RUN curl -L -o jumanpp-1.02.tar.xz 'http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-1.02.tar.xz'
RUN tar xJvf jumanpp-1.02.tar.xz \
    && cd jumanpp-1.02\
    && ./configure \
    && make \
    && make install

# other
RUN curl -L -o get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
    && python get-pip.py \
    && python3 get-pip.py
RUN python3 -m pip -V
RUN pip freeze
WORKDIR ../
RUN rm -rf work
