# Praktikum Künstliche Intelligenz (PKI)

Dieses Projekt wurde im Rahmen des Praktikums Künstliche Intelligenz (PKI) an der Technischen Hochschule Mittelhessen (THM) erstellt. Ziel ist es, Modelle zu entwickeln, die anhand von Husten-Audioaufnahme eine Covid-19 Diagnose durchführen können.

## Verwendete Datensätze

- [Virufy](https://github.com/virufy/virufy-data)
- [Coswara](https://github.com/iiscleap/Coswara-Data)
- [COUGHVID Kaggle Dataset](https://www.kaggle.com/datasets/andrewmvd/covid19-cough-audio-classification)

## Projekt starten

1. Projekt klonen

```bash
git clone https://git.thm.de/pswl33/pki.git
```

2. Abhängigkeiten installieren

```bash
cd code && pip install -r requirements.txt
```

3. Coswara-Datensatz entpacken

[extract_data.py](./datasets/Coswara-Data/extract_data.py) ausführen, um den Coswara-Datensatz zu entpacken.

Im Verzeichnis [datasets/Coswara-Data](./datasets/Coswara-Data) sollte sich nun der Ordner `Extracted_data` mit den entpackten Dateien befinden.

4. COUGHVID-Datensatz umwandeln

[convert_data.py](./code/convert_audio_files.ipynb) ausführen, um den COUGHVID-Datensatz umzuwandeln.

Im Verzeichnis [datasets/Coughvid/converted](datasets/Coughvid/) sollte sich nun der Ordner `converted` mit den umgewandelten Dateien befinden.

## Projektstruktur

- [code](/code): Code des Projekts
- [datasets](datasets): Datensätze des Projekts
- [doc](/doc): Report des Projekts

## Report

Im Verzeichnis [doc](/doc) befindet sich der Report des Projekts, der die Ergebnisse und den Verlauf des Projekts dokumentiert. Der aktuelle Stand ist in der Datei [report.pdf](/doc/report.pdf) zu finden. Der Report wurde mit [typst](https://typst.app) erstellt.


### PDF-Datei erstellen (VsCode)

1. Installiere die Extension [typst-lsp]( https://marketplace.visualstudio.com/items?itemName=nvarner.typst-lsp)
2. Typst-Datei öffnen
3. Datei speichern (Strg + S oder Cmd + S)
4. PDF-Datei wird automatisch erstellt und im Ordner `doc` abgelegt

## Pre-Commit einrichten

1. Der folgende Befehl installiert den Pre-Commit-Hook

```bash
cd code && pip install -r requirements-dev.txt && cd .. && pre-commit install
```

Durch den Pre-Commit-Hook werden automatisch Formatierungen, Linting-Regeln vor jedem Commit ausgeführt.
Die Konfiguration befindet sich in der Datei [.pre-commit-config.yaml](/.pre-commit-config.yaml) und die
Regeln von [Ruff](https://docs.astral.sh/ruff/) für den Linter und Formatter in der Datei [code/.ruff.toml](code/ruff.toml).

# Checkstyle Commands

1. Linting-Regeln überprüfen
```bash
	cd code && ruff check
```

2. Linting-Regeln überprüfen und automatisch beheben
```bash
	cd code && ruff check --fix
```

3. Code formatieren
```bash
	cd code && ruff format
```
