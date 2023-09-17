@echo off
start cmd /k "cd ./backend/ && go run main.go"
start cmd /k "cd ./devstash/ && flutter run --debug"
start cmd /k "cd ./scripts/ && python utility_script.py"