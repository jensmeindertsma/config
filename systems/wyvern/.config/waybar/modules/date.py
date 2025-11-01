from datetime import datetime
import json

now = datetime.now()

date = now.strftime("%d/%m/%Y").lower()

output = {
    "text": f'{date}',
}

print(json.dumps(output))
