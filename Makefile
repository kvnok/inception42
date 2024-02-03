COMPOSE=docker-compose -f srcs/docker-compose.yml

all: copyenv build up

up: 
	${COMPOSE} up -d

build:
	${COMPOSE} build

down:
	${COMPOSE} down

copyenv:
	cp ${HOME}/idkenv.txt ./srcs/.env

prune:
	docker system prune

clean:
	${COMPOSE} down -v --rmi all

fclean: clean prune

re: fclean all

ok: #for debugging
	sudo rm -rf ~/data/db
	sudo rm -rf ~/data/wp
	mkdir -p ~/data/db
	mkdir -p ~/data/wp

.PHONY: all up build down copyenv prune clean fclean re ok
