import csv
import random
import os
import sys

NUM_ROWS = 50

# Тематика: животные в зоопарке
COLUMNS = ["animal", "weight_kg", "age", "zone"]

def generate_row():
    animals = ["Лев", "Тигр", "Медведь", "Зебра", "Жираф", "Обезьяна", "Пингвин", "Слон"]

    return {
        "animal": random.choice(animals),
        "weight_kg": round(random.uniform(5, 5000), 1),
        "age": random.randint(1, 30),
        "zone": random.choice(["A", "B", "C"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)
