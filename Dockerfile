FROM python:3.10-slim

WORKDIR /usr/src/app

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Sys package
RUN apt-get update && apt-get install -y build-essential git gzip brotli parallel ffmpeg --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Julia
ENV JULIA_PATH /usr/local/julia/
ENV PATH $JULIA_PATH/bin:$PATH
COPY --from=julia:1.7.3 ${JULIA_PATH} /usr/local/

# Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -U pip wheel setuptools \
    && pip install --no-cache-dir -r requirements.txt

# Julia dependencies
COPY setup.jl .
RUN julia --threads=auto --color=yes --project="" setup.jl

CMD ["jupyter-book"]
