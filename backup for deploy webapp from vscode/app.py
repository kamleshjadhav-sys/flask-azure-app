# from flask import Flask
# app = Flask(__name__)

# @app.route('/')
# def home():
#     return 'This is a sample python webapp.'

# if __name__ == '__main__':
#     app.run(host='0.0.0.0',port=80)

#####################################################
from flask import Flask
# import platform
import sys
app = Flask(__name__)

@app.route('/')
def home():
    return f"Python version: {sys.version}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
