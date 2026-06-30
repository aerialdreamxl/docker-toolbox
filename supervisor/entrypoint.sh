source /etc/toolbox/.env

if [[ ! -e /etc/toolbox/.run-once-done && $TOOLBOX_RUN_ONCE == 1 && -n $(ls -A "/etc/toolbox/scripts/run-once/" 2>/dev/null) ]]; then
    echo "Running first-startup configurations"
    for script in /etc/toolbox/scripts/run-once/*.sh; do
        echo "Running: $script"
        bash $script
    done
    touch /etc/toolbox/.run-once-done
fi

if [[ $TOOLBOX_RUN_PER_STARTUP == 1 && -n $(ls -A "/etc/toolbox/scripts/per-startup/" 2>/dev/null) ]]; then
    echo "Running per-startup scripts"
    for script in /etc/toolbox/scripts/per-startup/*.sh; do
        echo "Running: $script"
        bash $script
    done
fi

#source /etc/toolbox/venvs/default/bin/activate

echo "Now Firing supervisord..."
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf