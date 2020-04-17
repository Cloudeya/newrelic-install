import os
import logging
from waitress import serve
from flask import Flask, request, jsonify, render_template, make_response, redirect, url_for, flash, sessions, session, get_flashed_messages
from hubspot import subscribe_form, workshop_forms, partnership_forms, therapist_forms

# Change the format of messages logged to Stackdriver
logging.basicConfig(format='%(message)s', level=logging.INFO)

app = Flask(__name__)

app.secret_key = "abcdefgh"

@app.route('/', methods=["GET", "POST"])
def index():
    if request.method=="POST":
        if request.form['subscribe_btn']=='subscribe_btn':
            sub_email = request.form['sub_email']
        else:
            sub_email = request.form['sub_email1']
        flag = subscribe_form(sub_email)
    return render_template('index.html')

@app.route('/contact', methods=["GET", "POST"])
def contact_us():
    if request.method=="POST":
        email = request.form['email']
        fname = request.form['fname']
        lname = request.form['lname']
        company = request.form['company']
        message = request.form['comment']
        flag = workshop_forms(email, fname, lname, company, message)

    return render_template('contact.html')

@app.route('/partnerships', methods=["GET", "POST"])
def partnerships():
    return render_template('partnership.html')

@app.route('/therapists', methods=["GET", "POST"])
def therapists():
    return render_template('therapists.html')

@app.route('/therapists/therapists-form', methods=["GET", "POST"])
def therapists_form():
    if request.method=="POST":
        fname = request.form['fname']
        lname = request.form['lname']
        email = request.form['email']
        company = request.form['company']
        message = request.form['comment']
        flag = therapist_forms(email, fname, lname, company, message)
    return render_template('form_therapists.html')

@app.route('/partnerships/partnership-form', methods=["GET", "POST"])
def partnership_form():
    if request.method=="POST":
        fname = request.form['fname']
        lname = request.form['lname']
        email = request.form['email']
        company = request.form['company']
        message = request.form['comment']

        flag = partnership_forms(email, fname, lname, company, message)
    return render_template('form_partnerships.html')

@app.route('/about')
def about():
    return render_template('aboutus.html')

@app.route('/careers')
def careers():
    return render_template('careers.html')

@app.route('/cookie-policy')
def cookie_policy():
    return render_template('cookie_policy.html')

@app.route('/privacy-policy')
def privacy_policy():
    return render_template('privacy_policy.html')

@app.route('/disclaimer')
def disclaimer():
    return render_template('disclaimer.html')

@app.route('/sitemap.xml')
def site_map():
    return render_template('sitemap.xml')

@app.route('/robots.txt')
def robots():
    return render_template('robots.txt')

# Dev, QA, and Staging
# if __name__ == '__main__':
#     app.run(debug=True, host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))

# Production
if __name__ == "__main__":
    serve(app)
