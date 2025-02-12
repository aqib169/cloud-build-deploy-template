from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _

class User(AbstractUser):
    email = models.EmailField(
        _('email'),
        unique=True,
        null=False,
        blank=False
    )
    password = models.CharField(
        _("password"), max_length=128, null=True, blank=True)
    

