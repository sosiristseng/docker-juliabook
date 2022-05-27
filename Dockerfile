FROM python:3.10-slim

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y build-essential git gzip brotli parallel --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Julia
ENV JULIA_PATH /usr/local/julia
ENV PATH $JULIA_PATH/bin:$PATH
COPY --from=julia:1.7.3 ${JULIA_PATH} /usr/local/

# Python deps (jupyter-book and matplotlib)
COPY requirements.txt .
RUN pip install --no-cache-dir -U pip wheel setuptools \
    && pip install --no-cache-dir -r requirements.txt

CMD ["jupyter-book"]
