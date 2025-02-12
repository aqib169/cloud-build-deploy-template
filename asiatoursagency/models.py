from django.db import models

# Create your models here.
class Tour(models.Model):
    #we need a origin country, destination country, number of nights, price, and a description
    origin_country = models.CharField(max_length=100)
    destination_country = models.CharField(max_length=100)
    number_of_nights = models.IntegerField()
    price = models.IntegerField()

    #this is string represntation of the tours
    def __str__(self):
        return (f"ID: {self.id}: From {self.origin_country} to {self.destination_country}, {self.number_of_nights} nights cost of {self.price}")
        #return (f"ID: {self.id}: From {self.origin_country} to {self.destination_country},
         #        {self.number_of_nights} nights cost of {self.price}")

        # from asiatoursagency.models import Tour
        # to1 = Tour(origin_country="Pakistan", destination_country="France", number_of_nights=10, price=200000)