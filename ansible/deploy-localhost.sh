sudo true
ansible-playbook \
	-c local --inventory ./inventory.yml \
	--limit "$(hostname -f)" \
	-vv \
	playbooks/*.yml
