all:
	chmod 055 ./path_to_adventure/cottage/outside/castle/library ; \
	sudo -E tar -cpf adv.tar ./path_to_adventure/* ; \
	sudo -E chown ${USER}:${USER} adv.tar ; \
	chmod 755 ./path_to_adventure/cottage/outside/castle/library

clean:
	rm adv.tar
