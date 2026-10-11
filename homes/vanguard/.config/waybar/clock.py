from datetime import datetime
import json

now = datetime.now().strftime("%H:%M")
colored = now.replace(":", '<span foreground="#56A3CF">:</span>')

print(json.dumps({"text": colored}))
