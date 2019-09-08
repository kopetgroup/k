from sanic import Sanic
from sanic import response
import json
import urllib3

app = Sanic()
http = urllib3.PoolManager()

@app.route('/')
async def test(request):
    return response.json({'hello': 'world'})

@app.route('/<w>/<h>/<path>')
def ateat(request, w, h, path):
    
    r = http.request('GET', 'http://159.69.114.113:8000/get/img:' + path)
    t = json.loads(r.data)

    t = 'https://i2.wp.com/' + t.replace('https://', '').replace('http://', '')
    t = str(str(t) + '?resize=' + w + ',' + h)

    body = http.request('GET', t).data
    headers = {
        'Content-Type': 'image/jpeg',
    }
    content_type = 'image/jpeg'
    return response.raw(body=body, headers=headers, content_type=content_type, status=200)


@app.route('/<path>')
def teat(request, path):
    w = '500'
    h = '500'
    r = http.request('GET', 'http://159.69.114.113:8000/get/img:' + path)
    t = json.loads(r.data)

    t = 'https://i2.wp.com/' + t.replace('https://', '').replace('http://', '')
    t = str(str(t) + '?resize=' + w + ',' + h)

    body = http.request('GET', t).data
    headers = {
        'Content-Type': 'image/jpeg',
    }
    content_type = 'image/jpeg'
    return response.raw(body=body, headers=headers, content_type=content_type, status=200)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
