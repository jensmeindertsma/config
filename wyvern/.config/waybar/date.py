from datetime import datetime

date = datetime.now()
output = date.strftime("%d/%m/%Y").lower()
print(output)
