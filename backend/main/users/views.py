from django.http import HttpResponse
from django.template import loader

from users.context import *
from users.util import empty_json

def index(request):
	template = loader.get_template('users/index.html')
	context = index_context(request)
	return HttpResponse(template.render(context))

def exist(request):
	if request.method != 'GET':
		return empty_json()
	
	template = loader.get_template('users/exist')
	context = exist_context(request)

	return HttpResponse(template.render(context))

def register(request):	
	if request.method != 'POST':
		return empty_json()
	
		
	template = loader.get_template('user/register')
	context = register_context(request)

	return HttpResponse(template.render(context))

def login(request):
	if request.method != 'POST':
		return empty_json()

	template = loader.get_template('users/login')
	context = login_context(request)

	return HttpResponse(template.render(context))

def logout(request):
	logout_context(request)
	return empty_json()

def profile(request):
	template = loader.get_template('users/profile')
	context = profile_context(request)
	return HttpResponse(template.render(context))
