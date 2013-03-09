from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.template import Context

from users.util import is_valid_username, is_valid_email

def index_context(request):
	if request.user.is_authenticated():
		user_list = User.objects.all()
		context = Context({
			'user_list': User.objects.all(),
		})
	else:
		context = COntext({
			'not_logged_in': True
		})

	return context

def exist_context(username, email):
	user_exists = False;
	email_exists = False;

	user_list = User.objects.all()

	if username:
		user_exists = user_list.filter(username=username).exists()
	if email:
		email_exists = user_list.filter(email=email).exists()

	context = Context({
		'username': username,
		'email': email,
		'user_exists': user_exists,
		'email_exists': email_exists,
	})

	return context

def register_context(username, password, email):
	success = False
	error = ""
	if is_valid_username(username) and is_valid_email(email):
		new_user = User.objects.create_user(username, email, password)
		try:			
			new_user.save()
			success = True
		except:
			error = "Database error while attempting to save user"
	else:
		error = "Invalid username or email"
	return Context({
		"success": success,
		"error": error
	})

def login_context(username, password):
	success = False
	user = authenticate(username=username, password=password)
	if user is not None:
		login(request, user)
		success = True
	return Context({'success': success})

def logout_context(request):
	logout(request)

def profile_context(request):
	if request.user.is_authenticated():
		curr_user = request.user
		return Context({
			"logged_in": True,
			"username": curr_user.get_username(),
			"email": curr_user.email,
			"joined": curr_user.date_joined,
			"last_seen": curr_user.last_login,
		})
	else:
		return Context({
			"logged_in": False
		})

