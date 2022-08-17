FROM golang AS builder

ARG TARGETARCH
ARG VERSION

RUN apt update
RUN apt install -y git
RUN git clone -b ${VERSION} --depth 1 https://github.com/othalla/plex_exporter.git /source
WORKDIR /source
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -o plex_exporter -v

FROM alpine
COPY --from=build /source/plex_exporter /plex_exporter
ENTRYPOINT ["/plex_exporter"]