# -*- coding: utf-8 -*-
# Author: haoyu

from sanic import Sanic
from sanic.response import json


app = Sanic()

@app.route('/')
async def test(request):
    return json({'msg': 'hello, i am listening on port 8080'})

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8080, debug=True)
