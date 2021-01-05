from djangoprod.settings import *

DEBUG = False

STATICFILES_LOCATION = 'static'
STATICFILES_STORAGE = 'custom_storages.StaticStorage' # To allow django-admin collectstatic to automatically put your static files in your bucket

MEDIAFILES_LOCATION = ''
DEFAULT_FILE_STORAGE = 'custom_storages.MediaStorage' # To upload your media files to S3

AWS_ACCESS_KEY_ID = os.environ['AWS_ACCESS_KEY_ID']
AWS_SECRET_ACCESS_KEY = os.environ['AWS_SECRET_ACCESS_KEY']
AWS_STORAGE_BUCKET_NAME = os.environ['AWS_STORAGE_BUCKET_NAME']
AWS_DEFAULT_ACL = None
AWS_S3_REGION_NAME = os.environ['AWS_S3_REGION_NAME']
