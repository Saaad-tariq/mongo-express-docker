#!/bin/bash
set -e

docker run -it --rm \
	--link web_db_1:mongo \
	--name mongo-express-docker \
	-p 30021:30021 \
	mongo-express-docker "$@"
