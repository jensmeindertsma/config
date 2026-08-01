from datetime import datetime

now = datetime.now()

print(f"{now:%A} {now:%B} {now:%-d}".lower())
