from django.db import models
from django.conf import settings


# Create your models here.
class File(models.Model):
    name = models.CharField(max_length=30)
    upload = models.FileField(upload_to=settings.MEDIA_BASE_PATH) # This means that all the files will be uploaded in the folder media of the root project