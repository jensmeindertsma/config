from datetime import datetime
import json

now = datetime.now()

date = now.strftime("%d/%m/%Y").lower()
day = now.strftime("%A").lower()

output = {
    "text": f'{date} ({day})',
}

print(json.dumps(output))
