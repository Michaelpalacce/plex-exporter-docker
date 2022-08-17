VERSION=$(curl -s -XGET https://api.github.com/repos/othalla/plex_exporter/tags | grep name -m 1 | awk '{print $2}' | cut -d'"' -f2)

docker buildx build --platform linux/amd64,linux/arm64 \
-f Dockerfile \
-t stefangenov/plex_exporter:latest \
-t stefangenov/plex_exporter:"${VERSION}" \
--build-arg VERSION="${VERSION}" \
--cpu-quota="400000" \
--memory=16g \
--push .
