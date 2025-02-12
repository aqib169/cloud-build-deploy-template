from django.conf import settings
from django.core.management import BaseCommand, call_command
from django.contrib.auth import get_user_model

User = get_user_model()

class Command(BaseCommand):
    help = "Load fixed data"

    def handle(self, *args, **options):
        user = User.objects.filter(is_superuser=True, username=settings.ADMIN_USERNAME)
        if not user:
            superuser = User.objects.create_superuser(
                username=settings.ADMIN_USERNAME, password=settings.ADMIN_PASSWORD, email=settings.ADMIN_EMAIL
            )
            superuser.save()
            print(f"Superuser with username \t{superuser.username} is created.")
        else:
            print("Superuser already exists!")