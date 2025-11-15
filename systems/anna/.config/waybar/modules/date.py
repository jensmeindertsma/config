from datetime import datetime
import json

now = datetime.now()

day_name = now.strftime("%A")
month_name = now.strftime("%B")
day_number = now.strftime("%d").lstrip("0")

output = {
    "text": f"{day_name} {month_name} {day_number}"
}

print(json.dumps(output))
