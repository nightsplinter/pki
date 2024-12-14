"""Vorverarbeitung der Audio-Dateien der Datensätze Coswara und Virufy.

Dieses Modul konvertiert die Audio-Dateien in Mel-Spektrogramme oder MFCCs.
"""

from pathlib import Path
import csv
import os

import librosa
import numpy as np
import tensorflow as tf

TARGET_SHAPE = (128, 128)
"""
Die Zielgröße (128x128 Pixel) für die Spektrogramme und MFCCs.
"""


def get_valid_coswara_filenames() -> tuple:
    """Gibt die gültigen Namen der Audio-Dateien zurück.

    :return: Liste der gültigen Dateinamen
    """
    path = (
        "/Users/paula/Documents/thm/pki/datasets/Coswara-Data/combined_data.csv"
    )

    if not Path.exists(Path(path)):
        error = """Please unpack the dataset."""
        raise FileNotFoundError(error)
    status = []
    positive_filenames = []
    negative_filenames = []
    negative_labels = ["recovered_full", "healthy"]
    positive_labels = [
        "positive_mild",
        "positive_asymp",
        "positive_mild",
        "positive_moderate",
    ]

    with Path.open(Path(path)) as file:
        lines = csv.DictReader(file)
        for line in lines:
            covid_status = line["covid_status"]
            filename = line["id"]
            status.append(covid_status)

            if covid_status in positive_labels:
                positive_filenames.append(filename)
            elif covid_status in negative_labels:
                negative_filenames.append(filename)

    # Alle möglichen Status ausgeben mit Anzahl
    # print(count(status))

    return positive_filenames, negative_filenames


def get_converted_virufy_audio_files(
    *, is_positive: bool, convert_to_mel: bool
) -> tuple:
    """Konvertiert die Audio-Dateien (Virufy) in Mel-Spektrogramme oder MFCCs.

    :param is_positive: True, wenn die Audio-Datei Covid-19 positiv ist
    :param convert_to_mel: True, konvertiert die Datei in Mel-Spektrogramme
    :return: Mel-Spektrogramme oder MFCCs und Labels
    """
    main_path = (
        "/Users/paula/Documents/thm/pki/datasets/virufy-data/clinical/original/"
    )
    status = "pos" if is_positive else "neg"
    filenames = os.listdir(main_path + status)

    converted_files = []
    labels = []
    current_label = 1 if is_positive else 0

    for filename in filenames:
        file_path = (
            Path(main_path + "pos/" + filename)
            if is_positive
            else Path(main_path + "neg/" + filename)
        )
        if convert_to_mel:
            converted = convert_audio_file_to_mel_spectrogram(file_path)
        else:
            converted = convert_audio_file_to_mfcc(file_path)
        converted_files.append(converted)
        labels.append(current_label)

    return np.array(converted_files), np.array(labels)


def get_converted_coswara_audio_files(
    filenames: str, *, is_positive: bool, convert_to_mel: bool
) -> tuple:
    """Konvertiert die Audio-Dateien (Coswara) in Mel-Spektrogramme oder MFCCs.

    :param filenames: Liste der Dateinamen
    :param is_positive: True, wenn die Audio-Datei Covid-19 positiv ist
    :param convert_to_mel: True, konvertiert die Audio-Datei in
        Mel-Spektrogramme und False in MFCCs
    :return: Mel-Spektrogramme oder MFCCs und Labels
    """
    converted_files = []
    labels = []
    current_label = 1 if is_positive else 0
    main_path = (
        "/Users/paula/Documents/thm/pki/datasets/coswara-data/Extracted_data/"
    )

    for filename in filenames:
        for folder in os.listdir(main_path):
            if filename in os.listdir(main_path + folder):
                folder_path = main_path + folder + "/" + filename
                for file in os.listdir(folder_path):
                    if "cough" in file:
                        full_file_path = Path(folder_path + "/" + file)
                        if convert_to_mel:
                            converted = convert_audio_file_to_mel_spectrogram(
                                full_file_path
                            )
                        else:
                            converted = convert_audio_file_to_mfcc(
                                full_file_path
                            )
                        converted_files.append(converted)
                        labels.append(current_label)

    return np.array(converted_files), np.array(labels)


# Audio-Datei in Spektrogramm umwandeln
# Spektrogramme sind bildliche Darstellung des zeitlichen Verlaufs
# von Frequenzen in einem Audiosignal.
def convert_audio_file_to_mel_spectrogram(path: Path) -> tuple:
    """Konvertiert die Audio-Dateien in Mel-Spektrogramme.

    :param path: Pfad zu der Audio-Datei
    :return: Mel-Spektrogramme
    """
    # Lade die Audiodatei (Original-Sampling-Rate beibehalten sr=None)
    audio_data, sample_rate = librosa.load(path, sr=None)

    # Berechne das Mel-Spektrogramm
    mel_spectrogram = librosa.feature.melspectrogram(
        y=audio_data, sr=sample_rate
    )

    # Wandle das Spektrogramm in Dezibel um (logarithmische Skala)
    # Notwendig um großen Unterschiede (kleine/größere Werte)
    # in den Spektrogrammen auszugleichen
    mel_spectrogram = librosa.power_to_db(mel_spectrogram, ref=np.max)

    # Füge eine Kanal-Dimension hinzu (Höhe, Breite, Kanal)
    mel_spectrogram = np.expand_dims(mel_spectrogram, axis=-1)

    # Skaliere das Spektrogramm auf die gewünschte Größe (128x128 Pixel)
    mel_spectrogram = tf.image.resize(mel_spectrogram, TARGET_SHAPE)

    # Mel-Spektrogramm anschauen
    # librosa.display.waveshow(audio_data, sr=sample_rate)
    # plt.figure(figsize=(10, 4))

    # Mel-Spektrogramm entlang der Höhe oder Breite mitteln
    # um es in eine 1D-Darstellung zu transformieren
    # Mittelwert entlang der Höhe
    return np.mean(mel_spectrogram, axis=0)


# Audio-Datei in MFCCs umwandeln
# MFCCs (Mel Frequency Cepstral Coefficients) werden für eine kompakten
# Darstellung des Frequenzspektrums eines Audiosignals verwendet.
def convert_audio_file_to_mfcc(path: Path) -> tuple:
    """Konvertiert eine Audio-Datei in MFCCs.

    :param path: Pfad zu der Audio-Datei
    :return: MFCCs und Labels
    """
    # Lade die Audiodatei (Original-Sampling-Rate beibehalten sr=None)
    audio_data, sample_rate = librosa.load(path, sr=None)

    # Berechne die MFCCs
    mfcc = librosa.feature.mfcc(y=audio_data, sr=sample_rate)

    # Füge eine Kanal-Dimension hinzu (Höhe, Breite, Kanal)
    mfcc = np.expand_dims(mfcc, axis=-1)

    # Skaliere die MFCCs auf die gewünschte Größe (128x128 Pixel)
    mfcc = tf.image.resize(mfcc, TARGET_SHAPE)

    # MFCCs entlang der Höhe oder Breite mitteln
    # um es in eine 1D-Darstellung zu transformieren
    # Mittelwert entlang der Höhe
    return np.mean(mfcc, axis=0)
