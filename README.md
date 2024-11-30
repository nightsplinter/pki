# Praktikum Künstliche Intelligenz (PKI)

Dieses Projekt wurde im Rahmen des Praktikums Künstliche Intelligenz (PKI) an der Technischen Hochschule Mittelhessen (THM) erstellt. Ziel ist es, ein Modell zu entwickeln, das anhand von einer Husten-Audioaufnahme eine Covid-19 Diagnose durchführt.

## Mögliche Datensätze

- [COUGHVID](https://c4science.ch/diffusion/10770/)
- [Virufy](https://github.com/virufy/virufy-data)
- [Coswara](https://www.kaggle.com/datasets/sarabhian/coswara-dataset-heavy-cough)
- [Cambridge University](https://www.covid-19-sounds.org/en/blog/neurips_dataset.html)

## Projekt starten

1. Projekt klonen

```bash
git clone https://git.thm.de/pswl33/pki.git
```

## Projektstruktur

- [code](/code): Code des Projekts
- [code/data](code/data): Datensätze des Projekts
- [doc](/doc): Report des Projekts
- [journal](/journal): Laborjournal des Projekts

## Report

Im Verzeichnis [doc](/doc) befindet sich der Report des Projekts, der die Ergebnisse und den Verlauf des Projekts dokumentiert. Der aktuelle Stand ist in der Datei [report.pdf](/doc/report.pdf) zu finden. Der Report wurde mit [typst](https://typst.app) erstellt.

## Laborjournal

Das Laborjournal des Projekts befindet sich im Verzeichnis [journal](/journal) und stellt eine formlose Dokumentation des Projektverlaufs dar. Der aktuelle Stand ist in der Datei [journal.pdf](/journal/journal.pdf) zu finden. Das Laborjournal wurde mit [typst](https://typst.app) erstellt.

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
