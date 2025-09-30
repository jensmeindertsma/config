from datetime import datetime
import json

date = datetime.now()

current_date = date.strftime("%d/%m/%Y").lower()
day = date.strftime("%A").lower()

output = {
    "text": f'{current_date} ({day})',
}

print(json.dumps(output))

