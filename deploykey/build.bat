docker build -t deploykey .
docker run -it -e REPO='djherbis/' --name createdeploykey deploykey
docker cp createdeploykey:/repo/travis_key.enc ./keys
docker cp createdeploykey:/repo/travis_key.pub ./keys
docker cp createdeploykey:/repo/.travis.yml ./keys
docker stop createdeploykey
docker container rm createdeploykey