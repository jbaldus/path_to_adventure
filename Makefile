all:
	chmod 055 ./path_to_adventure/cottage/leave_home/castle/library ; \
	sudo -E tar -cpf adv.tar ./path_to_adventure/* ; \
	sudo -E chown ${USER}:${USER} adv.tar ; \
	chmod 755 ./path_to_adventure/cottage/leave_home/castle/library

clean:
	rm adv.tar