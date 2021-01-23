from django.shortcuts import render
from django.http import HttpResponse


def health(request):
    html = "<html><body>Healthy</body></html>"
    return HttpResponse(html)

def deployment_color(request):
    import os
    t = os.environ.get("DEPLOYMENT_COLOR")
    if not t:
        t = "Not a colored deployment."
    return HttpResponse(t, content_type="text/plain")
