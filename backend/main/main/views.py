from django.http import HttpResponse
from django.template import Template, RequestContext

def token(request):
	template = Template("")
	return HttpResponse(template.render(RequestContext(request, {})))
