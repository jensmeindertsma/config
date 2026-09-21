from datetime import datetime
import json

now = datetime.now().strftime("%H:%M:%S")
colored = now.replace(":", '<span foreground="#888888">:</span>')

print(json.dumps({"text": colored}))

# from datetime import datetime
# import json

# now = datetime.now().strftime("%H:%M:%S")

# parts = now.split(":")

# colored = (
#     f'<span foreground="#ff6a13">{parts[0]}</span>:'
#     f'<span foreground="#ff6a13">{parts[1]}</span>:'
#     f'<span foreground="#ff6a13">{parts[2]}</span>'
# )

# print(json.dumps({"text": colored}))
