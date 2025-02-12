from django.contrib.auth import get_user_model
import random

User = get_user_model()

def generate_unique_username():
    prefix = "sg-"
    existing_usernames = set(User.objects.values_list('username', flat=True))

    while True:
        # Generate an 8-digit random number
        random_number = random.randint(10000000, 99999999)
        username = f"{prefix}{random_number}"
        if username not in existing_usernames:
            return username
