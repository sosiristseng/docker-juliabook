FROM ghcr.io/sosiristseng/docker-jupyterbook:0.13.0.1

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Julia
ENV JULIA_PATH /usr/local/julia/
ENV PATH $JULIA_PATH/bin:$PATH
COPY --from=julia:1.8.0-rc3 ${JULIA_PATH} /usr/local/

# Julia dependencies
COPY setup.jl .
RUN julia --threads=auto --color=yes setup.jl

CMD ["jupyter-book"]
