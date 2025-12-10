FROM golang:1.21-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download || true

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o aanchal-frogfly .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/aanchal-frogfly .

ENTRYPOINT ["./aanchal-frogfly"]
