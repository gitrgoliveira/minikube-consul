import os
import logging
import random
import string
import json
import requests

from flask import Flask, session
from flask.logging import default_handler
from flask_session import Session


def counter():
    counting_service = os.environ.get("COUNTING_SERVICE_URL",
        "http://localhost:9001")
    color = os.environ.get("BG_COLOR", "white")
    data = ""
    try:
        # do the request.
        r = requests.get(url = counting_service)
        data = r.json()
    except:
        data = "counting service unreachable"

    output = """<body style="background-color: {color};">
<p>&nbsp;</p>
<p>&nbsp;</p>
<div>
<div style="text-align: center;">This is a simple dashboard, rendered server-side</div>
<div style="text-align: center;">&nbsp;</div>
<div style="text-align: center;">
<div>
<div>Kubernetes pod {host}</div>
<div>&nbsp;</div>
<div>
<div>
<h4>Values retrieved from: {count_addr}</h4>
<div>&nbsp;</div>
<div>
<div>
<h1>{count_json}</h1>
</div>
</div>
</div>
</div>
</div>
</div>
</div></body>
    """.format( color=color,
                host=os.environ.get('HOSTNAME'),
                count_addr=counting_service,
                count_json=json.dumps(data, indent=2))

    return output

def create_app():
    app = Flask(__name__)
    app.secret_key = ''.join(random.choice(string.ascii_lowercase) for i in range(256))
    app.config['SESSION_TYPE'] = 'filesystem'
    sess = Session()
    sess.init_app(app)

    @app.route('/')
    def default():
        return counter()

    return app

if __name__ == '__main__':
    create_app().run(host='0.0.0.0')
