from djangoprod.settings import *

DEBUG = False

AWS_QUERYSTRING_AUTH = False # To hide credentials in the aws urls for static and media files (django-storage)

DEFAULT_FILE_STORAGE = 'custom_storages.MediaStorage' # To upload your media files to S3 (django-storage)

STATICFILES_LOCATION = 'static' # save all the static files in the static folder ini aws for collectstatic (django-storage)
STATICFILES_STORAGE = 'custom_storages.StaticStorage' # To allow django-admin collectstatic to automatically put your static files in your bucket (django-storage)