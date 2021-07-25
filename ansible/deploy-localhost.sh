sudo true
if [[ -z "$*" ]] ; then
	ARGS=playbooks/*.yml
else
	ARGS="$@"
fi
ansible-playbook \
	-c local --inventory ./inventory.yml \
	--limit "$(hostname -f)" \
	-vv \
	$ARGS
