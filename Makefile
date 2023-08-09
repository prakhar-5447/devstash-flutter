server:
	cd ./backend/ && \
	go run main.go

app:
	cd ./devstash/ && \
	flutter run --debug

.PHONY: server app