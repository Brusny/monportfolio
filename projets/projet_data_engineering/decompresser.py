import os
import gzip
import shutil

DOWNLOAD_FOLDER = "OPEN_DAMIR_05_2015_2025"

for file in os.listdir(DOWNLOAD_FOLDER):
    if file.endswith(".csv.gz"):
        gz_path = os.path.join(DOWNLOAD_FOLDER, file)
        csv_path = os.path.join(DOWNLOAD_FOLDER, file.replace(".gz", ""))

        if os.path.exists(csv_path):
            print(f"Déjà décompressé : {csv_path}")
            continue

        print(f"Décompression : {file}")

        with gzip.open(gz_path, "rb") as f_in:
            with open(csv_path, "wb") as f_out:
                shutil.copyfileobj(f_in, f_out)

        print(f"Terminé : {csv_path}")

print("Décompression terminée.")