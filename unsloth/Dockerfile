FROM 192.168.3.111:4000/aerialdreamxl/docker-toolbox:jupyterlab-noble
RUN mkdir ~/.venv/ && cd ~/.venv/ && uv venv -p 3.13 --seed unsloth && echo "source /home/jupyteruser/.venv/unsloth/bin/activate" > /home/jupyteruser/sys-env.sh && \
    /bin/bash -c "source /home/jupyteruser/.venv/unsloth/bin/activate && \
    pip install tqdm ipywidgets ipykernel setuptools setuptools-scm modelscope && python -m ipykernel install --user --name=unsloth_venv --display-name \"Python 3.13 (Unsloth)\" && \
    pip install --no-deps git+https://gh-proxy.com/https://github.com/unslothai/unsloth-zoo.git && \
    pip install unsloth[cu128-torch280]@git+https://gh-proxy.com/https://github.com/unslothai/unsloth.git --no-build-isolation && \
    pip install https://gh-proxy.com/https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.3/flash_attn-2.8.3+cu12torch2.8cxx11abiTRUE-cp313-cp313-linux_x86_64.whl"
