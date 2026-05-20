import os
import requests

BASE_URL = "https://open-data-assurance-maladie.ameli.fr/depenses/download_file.php?token=97986d586484287771acfe1a08bc25f5&file=Open_DAMIR/"

START_YEAR = 2015
END_YEAR = 2025
MONTH = "05"  # Mai

DOWNLOAD_FOLDER = "OPEN_DAMIR_05_2015_2025"
os.makedirs(DOWNLOAD_FOLDER, exist_ok=True)

for year in range(START_YEAR, END_YEAR + 1):
    file_name = f"A{year}{MONTH}.csv.gz"
    
    file_url = BASE_URL + file_name
    file_path = os.path.join(DOWNLOAD_FOLDER, file_name)

    if os.path.exists(file_path):
        print(f"Déjà téléchargé : {file_name}")
        continue

    print(f"Téléchargement : {file_name}")

    try:
        with requests.get(file_url, stream=True) as r:
            r.raise_for_status()
            with open(file_path, "wb") as f:
                for chunk in r.iter_content(chunk_size=8192):
                    f.write(chunk)
        print(f"Terminé : {file_name}")
        
    except requests.exceptions.HTTPError:
        print(f"Fichier non disponible : {file_name}")

print("Téléchargements terminés.")
