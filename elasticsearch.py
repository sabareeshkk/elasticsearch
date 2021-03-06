import urllib
import requests
import json
import pprint
#used with django serializer of the required model
from serializers import NoteSerializer


class ElasticSearch():
    base_url = 'http://localhost:9200/'
   
    def mappings(self, index_url, schema):
        url = self.base_url + index_url
        result = requests.put(url, data=json.dumps(schema))
        return result

    def post(self, url, data):
        url = self.base_url + url
        #serialize data with django serializer 
        slz = NoteSerializer(data).data
        result = requests.post(url, data=json.dumps(slz))
        return result

    def put(self, url, data):
        url = self.base_url + url
        data = NoteSerializer(data).data
        result = requests.put(url, data=json.dumps(data))
        return result

    # query string search
    def search_uri(self, url, data):
        url = self.base_url + url + '_search?q=' + \
            urllib.urlencode(data).replace('=', ':')
        result = requests.get(url)
        return result

    # body params search
    def search_body(self, url, query):
        url = self.base_url + url + '_search/'
        result = requests.get(url, data=json.dumps(query))
        #pretty printing the resulted output of the query exeuted 
        pprint.pprint(result.json())
        return result

    def delete(self, url):
        url = self.base_url + url
        result = requests.delete(url)
        return result

    def update(self, url, data):
        url = self.base_url + url + '_update'
        data = {'doc': data}
        result = requests.post(url, data=json.dumps(data))
        return result


if __name__ == '__main__':
    ElasticSearch()
