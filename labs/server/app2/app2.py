from flask import request, Flask

app2 = Flask(__name__)

@app2.route('/')
def index():
    return '<h1>Hello from App2!</h1>'
  
if __name__ == '__main__':
  app2.run(debug=True, host='0.0.0.0')