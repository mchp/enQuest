from django.conf.urls import patterns, url
from users import views

urlpatterns=patterns('',
	url(r'^$', views.index, name='index'),
	url(r'^exist/$', views.exist, name='exist'),
	url(r'^register/$', views.register, name='register'),
	url(r'^fb/$', views.register, name='fbregister'),
	url(r'^login/$', views.login, name='login'),
	url(r'^logout/$', views.logout, name='logout'),
	url(r'^profile/$', views.profile, name='logout'),
	url(r'^test/$', views.test, name="test"),
)
