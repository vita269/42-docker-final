
FROM golang:1.24.3

WORKDIR  /app

COPY . .

COPY go.mod go.sum ./
RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main main.go


CMD ["/main"]
