from django.contrib import admin
from file_app.models import File

class FileAdmin(admin.ModelAdmin):
    pass
admin.site.register(File, FileAdmin)