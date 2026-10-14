from datetime import datetime
import json

now = datetime.now().strftime("%H:%M")
colored = now.replace(":", '<span foreground="#ff6d0f">:</span>')

print(json.dumps({"text": colored}))
