import urllib
import requests
import json


class ElasticSearch():
    def __init__(self):
        self.base_url = 'http://localhost:9200/'

    def put_data(self, url, data):
        url = self.base_url + url
        result = requests.put(url, data=json.dumps(data))
        return result

    def get_data(self, url, data):
        url = self.base_url + url + '_search?q=' + urllib.urlencode(data)
        result = requests.get(url)
        return result

    def search_data(self, url, query):
        url = self.base_url + url + '_search/'
        result = requests.get(url, data=urllib.urlencode(query))   
        return result


if __name__ == '__main__':
    ElasticSearch()