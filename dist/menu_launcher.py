import os
import subprocess
import sys
import shutil

# Establece un tamaño fijo (por ejemplo, 48 columnas x 25 filas)
os.system("mode con: cols=48 lines=25")

ANCHO = 80  # Debe coincidir con el valor de cols de la ventana

# Carpeta donde está el exe o el script
base_dir = os.path.dirname(os.path.abspath(sys.argv[0]))

bat_file = os.path.join(base_dir, "programs_menu.bat")
programs_file = os.path.join(base_dir, "programs.txt")

# Comprobar existencia
for path, desc in [(bat_file, "archivo BAT"), (programs_file, "archivo TXT")]:
    if not os.path.exists(path):
        print(f"No se encontró {desc}:\n{path}")
        input("Press enter to exit...")
        sys.exit(1)

# Ejecutar BAT
try:
    subprocess.run(["cmd", "/c", bat_file], check=True)
except subprocess.CalledProcessError as e:
    print(f"Error al ejecutar el BAT:\n{e}")
    input("Press enter to exit...")