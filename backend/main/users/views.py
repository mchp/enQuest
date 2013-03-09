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

	username = request.GET.get('u',False)
	email = request.GET.get('e', False)
	
	template = loader.get_template('users/exist')
	context = exist_context(username, email)

	return HttpResponse(template.render(context))

def register(request):	
	if request.method != 'POST':
		return empty_json()
	
	username = request.POST.get("username")
	password = request.POST.get("password")
	email = request.POST.get("email")
		
	template = loader.get_template('user/register')
	context = register_context(username, password, email)

	return HttpResponse(template.render(context))

def login(request):
	if request.method != 'POST':
		return empty_json()
	
	username = request.POST.get("username")
	password = request.POST.get("password")
		
	template = loader.get_template('users/login')
	context = login_context(username, password)

	return HttpResponse(template.render(context))

def logout(request):
	logout_context(request)
	return empty_json()

def profile(request):
	template = loader.get_template('users/profile')
	context = profile_context(request)
	return HttpResponse(template.render(context))
