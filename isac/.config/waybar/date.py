from datetime import datetime

date = datetime.now()
output = date.strftime("%a %d/%m/%Y").lower()
print(output)
