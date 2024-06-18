@echo off
start cmd /k "cd server && npm install && npm run dev"
start cmd /k "flutter pub get && flutter run"

