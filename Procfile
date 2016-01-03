web: mix phoenix.server
rethinkdb: docker run --rm -p 28015:28015 -p 29015:29015 -p 8080:8080 -v /docker-volumes/astrologer/rethinkdb:/data --name rethinkdb rethinkdb
elasticsearch: docker run --rm -p 9200:9200 -p 9300:9300 -v /docker-volumes/astrologer/elasticsearch/data:/usr/share/elasticsearch/data --name elasticsearch elasticsearch
