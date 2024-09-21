import re

with open("log.txt", "r") as f:
    text = f.readlines()

text = "".join(text)

# Use a regex pattern to find both Offset() and "null" values
matches = re.findall(r'Offset\(([^)]+)\)', text)

# Print the results in the order they appear
for match in matches:
    if match:  # This will be the offsets
        print(f"Offset({match}),")
    else:  # This is where "null" occurs
        print("null,")

