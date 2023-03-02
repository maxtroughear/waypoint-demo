FROM golang:1.19-alpine AS builder

WORKDIR /app-src

COPY go.mod ./

RUN go mod download

COPY . ./

RUN GOOS=linux GOARCH=amd64 go build -tags netgo -ldflags="-w -s" -o /tmp/app

#--------------------------------------------------------------------
# final image
#--------------------------------------------------------------------

FROM scratch

COPY --from=builder /tmp/app /app

CMD [ "/app" ]
