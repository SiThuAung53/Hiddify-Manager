cd /opt/hiddify-manager/hiddify-panel

source /opt/hiddify-manager/common/utils.sh
activate_python_venv

hiddify-panel-cli downgrade
if [ ! -f hiddifypanel.db ] && [ -f hiddifypanel.db.old ]; then
    mv hiddifypanel.db.old hiddifypanel.db
fi
cd ..


pip install hiddifypanel==$(get_release_version hiddify-panel)
cd /opt/hiddify-manager
if [ -d ".git" ]; then
    git remote set-url origin https://github.com/SiThuAung53/Hiddify-Manager.git 2>/dev/null || true
    git fetch origin && git reset --hard origin/main
else
    tmp_dir=$(mktemp -d)
    git clone --branch main --depth 1 https://github.com/SiThuAung53/Hiddify-Manager.git "$tmp_dir"
    cp -a "$tmp_dir"/. /opt/hiddify-manager/
    rm -rf "$tmp_dir"
fi
ln -sf /opt/hiddify-manager /opt/hiddify-config
bash install.sh
