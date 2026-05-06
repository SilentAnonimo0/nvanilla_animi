ARG CUDA_IMAGE="13.1.2-devel-ubuntu24.04"
FROM nvidia/cuda:${CUDA_IMAGE}

ENV HOST=0.0.0.0
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    python3 python3-pip python3.12-venv gcc wget \
    ocl-icd-opencl-dev opencl-headers clinfo \
    libclblast-dev libopenblas-dev \
    && rm -rf /var/lib/apt/lists/*


RUN useradd -m -d /home/container -s /bin/bash container

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --upgrade pip setuptools fastapi uvicorn pydantic

ENV CUDA_DOCKER_ARCH=all
ENV GGML_CUDA=1
RUN CMAKE_ARGS="-DGGML_CUDA=on" pip install llama-cpp-python

WORKDIR /home/container
COPY . .
RUN chown -R container:container /home/container /opt/venv

USER container
ENV USER=container HOME=/home/container


COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
