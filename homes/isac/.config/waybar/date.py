from datetime import datetime

now = datetime.now()

print(f"{now:%B} {now:%-d} ({now:%A})".lower())
