if [ ! -f /home/ubuntu/.jupyter/jupyter_lab_config.py ]; then
    echo "Generating Jupyter configuration..."
    gosu ubuntu:ubuntu /bin/bash -c "jupyter lab --generate-config"

    gosu ubuntu:ubuntu /bin/bash -c "python3 -c \"
from jupyter_server.auth import passwd
import os
password_hash = passwd('${DEVELOPER_PASSWORD}')
config_file = '/home/ubuntu/.jupyter/jupyter_lab_config.py'
config_content = ''
if os.path.exists(config_file):
    with open(config_file, 'r') as f:
        lines = f.readlines()
    lines = [line for line in lines if not line.strip().startswith('c.ServerApp.password')]
    config_content = ''.join(lines)
config_content += f'''
c.ServerApp.password = '{password_hash}'
c.ServerApp.allow_root = False
c.ServerApp.allow_remote_access = True
c.ServerApp.terminado_settings = {{\'shell_command\': [\'/bin/bash\', \'-l\']}}
'''
with open(config_file, 'w') as f:
    f.write(config_content)
\""
fi