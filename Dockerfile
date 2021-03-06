FROM python:2.7
MAINTAINER Alex Kern <alex@pavlovml.com>

# deps
RUN apt-get update && \
    apt-get install -y libopenblas-dev gfortran && \
    pip install numpy && \
    pip install scipy && \
    pip install scikit-image cairosvg elasticsearch flask gunicorn && \
    pip install git+https://github.com/ascribe/image-match.git@0.2.1

# install
RUN mkdir -p /app
WORKDIR /app
COPY src .

# run
EXPOSE 80
ENV PORT 80
CMD gunicorn -w ${WORKER_COUNT:-4} wsgi:app
