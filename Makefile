server:
	cd ./backend/ && \
	go run main.go

app:
	cd ./devstash/ && \
	flutter run --debug

script:
	cd ./scripts/ && \
	python .\utility_script.py

.PHONY: server app script