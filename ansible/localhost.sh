set -ex
sudo true
if [[ -z "$*" ]] ; then
	ARGS=playbooks/*.yml
else
	ARGS="$@"
fi
ansible-playbook \
	-c local --inventory ./inventory.yml --diff \
	--become \
	--limit "$(hostname -f)" \
	-vv \
	$ARGS
