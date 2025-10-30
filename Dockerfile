# Базовый образ с Go
FROM golang:1.24.3 AS builder 

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем go.mod и go.sum для загрузки зависимостей
COPY go.mod go.sum ./
RUN go mod download

# Копируем весь проект (важно скопировать всю структуру папок)
COPY . .

# Собираем приложение
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /my_app 

# Создаем финальный образ
FROM golang:1.24.3-alpine

WORKDIR /app

# Копируем собранный бинарный файл из этапа сборки
COPY --from=builder /app/my_app

COPY tracker.db /app/tracker.db


CMD ["/my_app"]
