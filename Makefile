all:
	@echo Changing permissions to library and bundling into build/adv.tar ; \
	mkdir -p ./build ; \
	chmod 055 ./path_to_adventure/world/castle/library ; \
	sudo -E tar -cpf build/adv.tar ./path_to_adventure/. ; \
	sudo -E chown ${USER}:${USER} build/adv.tar ; \
	chmod 755 ./path_to_adventure/world/castle/library

clean:
	@echo Cleaning build directory ; \
	sudo rm -rf build/*

test: clean all
	cd build ; \
	tar -xf adv.tar ; \
	cd path_to_adventure ; \
	./start
