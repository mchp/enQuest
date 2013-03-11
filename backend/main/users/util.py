from django.http import HttpResponse

def is_valid_username(username):
	#we should do more checking
	return len(username)>1

def is_valid_email(email):
	#we should do more checking
	return email.find("@") > -1

def empty_json():
	return HttpResponse("{}")

def get_callback(request):
	callback = False
	if request.method == 'GET':
		callback = request.GET.get("callback", False)
	elif request.method == 'POST':
		callback = request.POST.get("callback", False)

	return callback;
