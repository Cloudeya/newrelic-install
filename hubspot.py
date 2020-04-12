import requests
import urllib
import config

headers ={}
headers["Content-Type"]='application/x-www-form-urlencoded'
hubspot_url = 'https://forms.hubspot.com/uploads/form/v2/'

def subscribe_form(email_id):
	endpoint = hubspot_url + config.hubspot_key + '/' + config.subscribe_form_key + '?&'

	#Build your request body
	data = urllib.parse.urlencode({
		'email' : email_id,
		})

	r = requests.post(url=endpoint, data=data, headers=headers)
	response = str(r)[-5:-2]
	if response == "204":
		return 1
	else:
		return 0

def workshop_forms(email_id, first_name, last_name, company_name, message):
	endpoint = hubspot_url + config.hubspot_key + '/' + config.workshop_form_key + '?&'

	# Build your request body
	data = urllib.parse.urlencode({
		'email': email_id,
		'firstname': first_name,
		'lastname': last_name,
		'company': company_name,
		'details': message
	})
	r = requests.post(url=endpoint, data=data, headers=headers)
	response = str(r)[-5:-2]
	if response=="204":
		return 1
	else:
		return 0

def therapist_forms(email_id, first_name, last_name, company_name, message):
	endpoint = hubspot_url + config.hubspot_key + '/' + config.therapist_form_key + '?&'

	# Build your request body
	data = urllib.parse.urlencode({
		'email': email_id,
		'firstname': first_name,
		'lastname': last_name,
		'company': company_name,
		'details': message
	})
	r = requests.post(url=endpoint, data=data, headers=headers)
	response = str(r)[-5:-2]
	if response=="204":
		return 1
	else:
		return 0

def partnership_forms(email_id, first_name, last_name="", company_name="", message = ""):
	endpoint = hubspot_url + config.hubspot_key + '/' + config.partnership_form_key + '?&'

	# Build your request body
	data = urllib.parse.urlencode({
		'email': email_id,
		'firstname': first_name,
		'lastname': last_name,
		'company': company_name,
		'partnerships_details': message
	})
	r = requests.post(url=endpoint, data=data, headers=headers)
	response = str(r)[-5:-2]
	if response == "204":
		return 1
	else:
		return 0
