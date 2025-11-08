from django.http import HttpResponse
from django.shortcuts import render
from visits.models import PageVisit

def home_page_view(request, *args, **kwargs):
    queryset = PageVisit.objects.all()
    context = {
        "title": "Home Page",
        "content": "Welcome to the Home Page",
        "page_visits": queryset,
        "page_visits_count": queryset.count(),
    }
    PageVisit.objects.create(path=request.path)
    return render(request, "home.html", context=context)