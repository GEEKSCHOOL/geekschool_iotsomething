__author__ = 'yanu'

from flask import Flask, render_template
from flask_bootstrap import Bootstrap
import RPi.GPIO as GPIO
import datetime

OUTPUT_PIN = 4

app = Flask(__name__)
Bootstrap(app)

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(OUTPUT_PIN, GPIO.OUT)


@app.route("/")
def show_top_page():
    now = datetime.datetime.now()
    time_string = now.strftime("%Y-%m-%d %H:%M")
    template_data = {
        'title': 'Sample Top Page',
        'time': time_string
    }
    return render_template('top.html', **template_data)


@app.route("/light/on")
def light_on():
    GPIO.output(OUTPUT_PIN, GPIO.HIGH)
    return '{"result":"ok"}'


@app.route("/light/off")
def light_off():
    GPIO.output(OUTPUT_PIN, GPIO.LOW)
    return '{"result":"ok"}'


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True)
