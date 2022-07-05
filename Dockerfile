FROM ghcr.io/sosiristseng/docker-jupyterbook:0.13.0.1

WORKDIR /usr/src/app

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Julia
ENV JULIA_PATH /usr/local/julia/
ENV PATH $JULIA_PATH/bin:$PATH
COPY --from=julia:1.7.3 ${JULIA_PATH} /usr/local/

# Julia dependencies
COPY setup.jl .
RUN julia --threads=auto --color=yes --project="" setup.jl

CMD ["jupyter-book"]
