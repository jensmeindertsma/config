from datetime import datetime
import json

date = datetime.now()

text = date.strftime("%d/%m/%Y").lower()
tooltip = date.strftime("%A")

output = {
    "text": text,
    "tooltip": tooltip
}

print(json.dumps(output))

