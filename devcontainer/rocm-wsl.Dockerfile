FROM aerialdreamxl/dev-toolbox:ubuntu-cn
RUN /bin/bash -c "mkdir --parents --mode=0755 /etc/apt/keyrings && \
    apt update && apt upgrade -y && apt install -y gnupg && \
    wget https://repo.amd.com/rocm/packages-multi-arch/gpg/rocm.gpg -O - | gpg --dearmor | tee /etc/apt/keyrings/amdrocm.gpg > /dev/null && \
    echo \"deb [arch=amd64 signed-by=/etc/apt/keyrings/amdrocm.gpg] https://repo.amd.com/rocm/packages-multi-arch/ubuntu2604 stable main\" > /etc/apt/sources.list.d/rocm.list && \
    apt update && apt upgrade -y && apt install -y libatomic1 libquadmath0 gcc g++ cmake python3-pip python3-wheel python3-argcomplete && \
    wget https://ghfast.top/https://github.com/ROCm/librocdxg/releases/download/v1.2.2/rocdxg-roct_1.2.2_amd64.deb && \
    wget https://ghfast.top/https://github.com/ROCm/librocdxg/releases/download/v1.2.1/rocdxg-amd-smi-lib_1.2.1_amd64.deb && \
    apt install ./rocdxg-roct_1.2.2_amd64.deb ./rocdxg-amd-smi-lib_1.2.1_amd64.deb && rm ./rocdxg-roct_1.2.2_amd64.deb ./rocdxg-amd-smi-lib_1.2.1_amd64.deb && \
    source /etc/profile.d/rocdxg-amd-smi-lib.sh && \
    ln -s /usr/lib/wsl/lib/libdxcore.so /usr/lib/libdxcore.so && ln -s /usr/lib/wsl/lib/libd3d12.so /usr/lib/libd3d12.so && ln -s /usr/lib/wsl/lib/libd3d12core.so /usr/lib/libd3d12core.so && \
    apt clean && rm -rf /var/lib/apt/lists/*"