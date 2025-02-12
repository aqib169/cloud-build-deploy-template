from django.urls import path
from . import views

#Define the URL patterns for the AsiaToursAgency app
urlpatterns = [
    path('', views.index, name='index'),
]