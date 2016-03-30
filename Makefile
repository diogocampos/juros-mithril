build: node_modules/ clean
	./node_modules/.bin/brunch build --env production

watch: node_modules/ clean
	./node_modules/.bin/brunch watch --server

clean:
	rm -f public/*.{css,html,js}


node_modules/: package.json
	npm install


.PHONY: build watch clean
