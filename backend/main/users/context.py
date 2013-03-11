from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.template import Context, RequestContext

from users.util import is_valid_username, is_valid_email, get_callback

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

def exist_context(request):

	username = request.GET.get('u',False)
	email = request.GET.get('e', False)
	user_exists = False;
	email_exists = False;
	callback = get_callback(request)
	
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
		'callback': callback
	})

	return context

def register_context(request):
	username = request.POST.get("username")
	password = request.POST.get("password")
	email = request.POST.get("email")
	callback = get_callback(request)
	success = False
	error = ""

	user_list = User.objects.all()
	
	if user_list.filter(username=username).exists():
		error = "Username already taken"
	elif user_list.filter(email=email).exists():
		error = "Email already taken"
	elif not is_valid_username(username):
		error = "Invalid username"
	elif not is_valid_email(email):
		error = "Invalid email"
	else:
		new_user = User.objects.create_user(username, email, password)
		try:			
			new_user.save()
			success = True
		except:
			error = "Database error while attempting to save user"

	return Context({
		"success": success,
		"error": error,
		"callback": callback
	})

def login_context(request):
	username = request.POST.get("username")
	password = request.POST.get("password")		
	success = False
	callback = get_callback(request)

	user = authenticate(username=username, password=password)
	if user is not None:
		login(request, user)
		success = True

	return Context({'success': success,
			'callback': callback			
			})

def logout_context(request):
	logout(request)

def profile_context(request):
	callback = get_callback(request)
	if request.user.is_authenticated():
		curr_user = request.user
		return Context({
			"logged_in": True,
			"username": curr_user.get_username(),
			"email": curr_user.email,
			"joined": curr_user.date_joined,
			"last_seen": curr_user.last_login,
			"callback": callback
		})
	else:
		return Context({
			"logged_in": False,
			"callback": callback
		})

def test_context(request):
	curr_user = "Anonymous"
	if request.user.is_authenticated():
		curr_user = request.user.get_username()
	return RequestContext(request, {
		"curr_user": curr_user
	})
