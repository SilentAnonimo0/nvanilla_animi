#!/bin/bash
cd /home/container

nvidia-smi

mkdir -p models
cd models

if [ ! -f mistral-7b-instruct-v0.2.Q4_K_M.gguf ]; then
    wget https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q4_K_M.gguf
fi

MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# mark installation complete
touch /home/container/models/.done

${MODIFIED_STARTUP}
