from django.http import HttpResponse

def is_valid_username(username):
	return True

def is_valid_email(email):
	return True

def empty_json():
	return HttpResponse("{}")
