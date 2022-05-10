from flask import request, Flask

app1 = Flask(__name__)

@app1.route('/')
def index():
    return '<h1>Hello from App1!</h1>'
  
if __name__ == '__main__':
  app1.run(debug=True, host='0.0.0.0')