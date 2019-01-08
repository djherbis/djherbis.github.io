setlocal
set PORT=1313
set HOST=http://%DEV_SERVER%
set SITE_DIR=%DEV_GOPATH%/src/github.com/djherbis/djherbis.github.io/djherbis.com
docker-compose --project-directory .. -f docker-compose.yml build
docker-compose --project-directory .. -f docker-compose.yml up -d --remove-orphans
