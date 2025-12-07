from datetime import datetime
import json

now = datetime.now()

date = now.strftime("%a %b %-d")

output = {
    "text": f'{date}',
}

print(json.dumps(output))
