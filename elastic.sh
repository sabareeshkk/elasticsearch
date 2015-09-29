curl -XPUT "localhost:9200/testdata/" -d '{
    "mappings": {
        "hello": {
            "properties": {
                "location" : {
                    "type" : "geo_point"
                },
                "name": {
                    "type": "string"
                }
            }
        }
    }
}'

curl -XPUT "localhost:9200/testdata/hello/1" -d '{
  "name":     "Pala Pizza",
  "location": { 
    "lat":     75.722,
    "lon":     64.989
  }
}'
echo "first\n"
curl -XPUT "localhost:9200/testdata/hello/2" -d '{
  "name":     "sabareeshk",
  "location": { 
    "lat":     75.722,
    "lon":     65.989
  }
}'
echo "second\n"
curl -XPUT "localhost:9200/testdata/hello/3" -d '{
  "name":     "sabz",
  "location": { 
    "lat":     75.722,
    "lon":     65.000
  }
}'
echo "third\n"
curl -XPUT "localhost:9200/testdata/hello/4" -d '{
  "name":     "tony jaa",
  "location": { 
    "lat":     75.722,
    "lon":     66.989
  }
}'
echo "four\n"

curl -XGET "localhost:9200/testdata/hello/_search?pretty=true" -d '{
  "query": {
    "filtered": {
      "filter": {
        "geo_distance": {
          "distance": "20km", 
          "location": { 
            "lat":  75.715,
            "lon":  65.988
          }
        }
      }
    }
  }
}'
# curl -XPUT "localhost:9200/salvation/part/1" -d '{
#   "name":     "Chipotle Mexican Grill",
#   "location": "40.715, -74.011" 
# }'

# curl -XPUT "localhost:9200/salvation/doc/2" -d '{
#   "name":     "Pala Pizza",
#   "location": { 
#     "lat":     40.722,
#     "lon":    -73.989
#   }
# }'

# curl -XPUT "localhost:9200/salvation/doc/3" -d '{
#   "name":     "Mini Munchies Pizza",
#   "location": [ -73.983, 40.719 ] 
# }'

# curl -XPUT "localhost:9200/geo-test/doc/1" -d '{ 
#     "title": "abcccc",
#     "price": 3300,
#     "price_per": "task",
#     "location": { "lat": -33.8756, "lon": 151.204 },
#     "description": "asdfasdf"
#  }'

# curl -XPOST "localhost:9200/geo-test/_refresh"

# curl -XPUT "localhost:9200/geo-test/doc/2" -d '{
#   "name":     "Pala Pizza",
#   "location": { 
#     "lat":     40.722,
#     "lon":    -73.989
#   }
# }'

# curl -XPOST "localhost:9200/geo-test/doc/_search?pretty=true" -d '{
#     "query": {
#         "match_all": {}
#     },
#     "script_fields": {
#         "distance": {
#             "script": "doc['\''location'\''].arcDistanceInKm(-27.470,153.021)"
#         }
#     },
#     "fields": ["title", "location"]
# }'