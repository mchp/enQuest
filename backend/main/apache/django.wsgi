import os
import sys
 
sys.path.append('/home/nwadams/enQuest/backend/main')
sys.path.append('/home/nwadams/enQuest/backend/main/main')
 
os.environ['DJANGO_SETTINGS_MODULE'] = 'main.settings'
 
import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()
