from django.core.context_processors import csrf
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.template import Context, RequestContext

from social_auth.models import UserSocialAuth
from social_auth.views import complete as social_authenticate
from social_auth.backends.facebook import load_signed_request, FacebookBackend

from users.util import is_valid_username, is_valid_email, is_valid_password, get_callback
from errors.list import Errors

def index_context(request):
	if request.user.is_authenticated():
		user_list = User.objects.all()
		context = Context({
			'user_list': User.objects.all(),
		})
	else:
		context = Context({
			'error_code': Errors['usr_not_logged_in'].code,
			'error_msg': Errors['usr_not_logged_in'].msg
		})

	return context

def exist_context(request):
	callback = get_callback(request)
	if request.method != 'GET':
		return Context({
			'callback': callback,
			'error_code': Errors['unhandled_method'].code,
			'error_msg': Errors['unhandled_method'].msg,
		})

	username = request.GET.get('u',False)
	email = request.GET.get('e', False)

	if not (username or email):
		return Context({
			'callback': callback,
			'error_code': Errors['invalid_params'].code,
			'error_msg': Errors['invalid_params'].msg,
		})
	
	ctx_dict = {'callback': callback}

	user_list = User.objects.all()

	if username:
		ctx_dict['username'] = username
		if user_list.filter(username=username).exists():
			ctx_dict['user_exists'] = 'true'
		else:
			ctx_dict['user_exists'] = 'false'

	if email:
		ctx_dict['email'] = email
		if user_list.filter(email=email).exists():
			ctx_dict['email_exists'] = 'true'
		else:
			ctx_dict['email_exists'] = 'false'

	return Context(ctx_dict)


def register_context(request):
	callback = get_callback(request)
		
	if request.method != 'POST':
		return Context({
			'callback': callback,
			'error_code': Errors['unhandled_method'].code,
			'error_msg': Errors['unhandled_method'].msg,
		})

	ctx_dict = {'callback': callback}
	username = request.POST.get("username", False)
	password = request.POST.get("password", False)
	email = request.POST.get("email", False)
	
	user_list = User.objects.all()
	
	if not (username and password and email):
		ctx_dict['error_code'] = Errors['invalid_params'].code
		ctx_dict['error_msg'] = Errors['invalid_params'].msg
	elif user_list.filter(username=username).exists():
		ctx_dict['error_code'] = Errors['username_taken'].code
		ctx_dict['error_msg'] = Errors['username_taken'].msg
	elif user_list.filter(email=email).exists():
		ctx_dict['error_code'] = Errors['email_taken'].code
		ctx_dict['error_msg'] = Errors['email_taken'].msg
	elif not is_valid_username(username):
		ctx_dict['error_code'] = Errors['invalid_username'].code
		ctx_dict['error_msg'] = Errors['invalid_username'].msg
	elif not is_valid_email(email):
		ctx_dict['error_code'] = Errors['invalid_email'].code
		ctx_dict['error_msg'] = Errors['invalid_email'].msg
	elif not is_valid_password(password):
		ctx_dict['error_code'] = Errors['invalid_password'].code
		ctx_dict['error_msg'] = Errors['invalid_password'].msg		
	else:
		new_user = User.objects.create_user(username, email, password)
		try:			
			new_user.save()
			ctx_dict['success'] = 'true'
		except Exception as e:
			ctx_dict['error_code'] = Errors['database_error'].code
			ctx_dict['error_msg'] = Errors['database_error'].msg
			ctx_dict['error_data'] = e.strerror		

	return RequestContext(request, ctx_dict)

def login_context(request):
	callback = get_callback(request)
		
	if request.method != 'POST':
		return Context({
			'callback': callback,
			'error_code': Errors['unhandled_method'].code,
			'error_msg': Errors['unhandled_method'].msg,
		})

	if request.POST.get("fb"):
		user = social_authenticate(request, FacebookBackend.name)
	else:
		username = request.POST.get("username")
		password = request.POST.get("password")	
		user = authenticate(username=username, password=password)

	success = 'false'

	if user is not None:
		login(request, user)
		success = 'true'

	return RequestContext(request, {'success': success,
			'callback': callback			
			})

def logout_context(request):
	logout(request)

def profile_context(request):
	callback = get_callback(request)

	if request.method != 'GET':
		return Context({
			'callback': callback,
			'error_code': Errors['unhandled_method'].code,
			'error_msg': Errors['unhandled_method'].msg,
		})

	if request.user.is_authenticated():
		curr_user = request.user
		return RequestContext(request,{
			"username": curr_user.get_username(),
			"email": curr_user.email,
			"joined": curr_user.date_joined,
			"last_seen": curr_user.last_login,
			"callback": callback,
		})
	else:
		return RequestContext({
			'error_code': Errors['usr_not_logged_in'].code,
			'error_msg': Errors['usr_not_logged_in'].msg,
			"callback": callback,
		})

def test_context(request):
	curr_user = "Anonymous"
	if request.user.is_authenticated():
		curr_user = request.user.get_username()
	return RequestContext(request, {
		"curr_user": curr_user
	})
