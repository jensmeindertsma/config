from datetime import datetime
import json

now = datetime.now().strftime("%A %B %-d %Y")

print(json.dumps({"text": now}))
