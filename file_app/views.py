from prometheus_client import Counter

from django.shortcuts import render
from django.http import HttpResponse

c = Counter('health', 'The number of time where health endpint is called')

def health(request):
    html = "<html><body>Healthy</body></html>"    
    c.inc()
    return HttpResponse(html)

def deployment_color(request):
    import os
    t = os.environ.get("DEPLOYMENT_COLOR")
    if not t:
        t = "Not a colored deployment."
    return HttpResponse(t, content_type="text/plain")
