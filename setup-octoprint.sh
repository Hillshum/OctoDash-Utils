rm -rf ~/.octoprint
mkdir -p ~/.octoprint


cp op-config/config.yaml ~/.octoprint/config.yaml
cp op-config/users.yaml ~/.octoprint/users.yaml

sudo systemctl restart octoprint.service