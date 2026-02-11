ARG CUDA_IMAGE="13.1.1-devel-ubuntu24.04"
FROM nvidia/cuda:${CUDA_IMAGE}

ENV HOST=0.0.0.0

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    python3 python3-pip python3.12-venv gcc wget \
    ocl-icd-opencl-dev opencl-headers clinfo \
    libclblast-dev libopenblas-dev \
    && mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

RUN useradd -m -d /home/container -s /bin/bash container

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY . .

ENV CUDA_DOCKER_ARCH=all
ENV GGML_CUDA=1

RUN python3 -m pip install --upgrade pip pytest cmake scikit-build setuptools fastapi uvicorn sse-starlette pydantic-settings starlette-context

RUN CMAKE_ARGS="-DGGML_CUDA=on" pip install llama-cpp-python

RUN chown -R container:container /home/container /opt/venv
WORKDIR /home/container

USER container
ENV USER=container HOME=/home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
