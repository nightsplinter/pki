"""Merkmalsextraktion.

Dieses Modul konvertiert die Audio-Dateien in MFCC.
"""

from pathlib import Path
import csv
import os

import librosa
import numpy as np
import tensorflow as tf

TARGET_SHAPE = (128, 128)
"""
Die Zielgröße (128x128 Pixel) des MFCC.
"""


def get_valid_coswara_folder_names() -> tuple:
    """Gibt die gültigen Namen der Ordner zurück.

    :return: Liste der gültigen Dateinamen
    """
    path = Path.resolve(Path("../../datasets/Coswara-Data/combined_data.csv"))

    if not Path.exists(Path(path)):
        error = """Please unpack the dataset."""
        raise FileNotFoundError(error)

    status = []
    positive_folder_names = []
    negative_folder_names = []
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
                positive_folder_names.append(filename)
            elif covid_status in negative_labels:
                negative_folder_names.append(filename)

    # Ausgabe der Anzahl
    # print(count(status))
    return positive_folder_names, negative_folder_names


def get_mfccs_from_virufy_audio_files(*, is_positive: bool) -> tuple:
    """Konvertiert die Audio-Dateien von Virufy in MFCCs.

    :param is_positive: True, wenn die Audio-Datei Covid-19 positiv ist
    return MFCCS und Labels
    """
    path = Path.resolve(Path("../../datasets/virufy-data/clinical/original/"))

    status = "pos" if is_positive else "neg"
    converted_files = []
    labels = []
    current_label = 1 if is_positive else 0

    filename_path = path / status
    filenames = os.listdir(filename_path)

    for filename in filenames:
        if is_positive:
            pos_path = path / "pos" / filename
            file_path = Path(pos_path)
        else:
            neg_path = path / "neg" / filename
            file_path = Path(neg_path)

        converted = convert_audio_file_to_mfcc(file_path)
        if converted is not None:
            converted_files.append(converted)
            labels.append(current_label)

    return np.array(converted_files, dtype=np.float32), np.array(
        labels, dtype=np.int32
    )


def get_mfccs_from_coswara_audio_files(
    folder_names: str, *, is_positive: bool
) -> tuple:
    """Konvertiert die Audio-Dateien von Coswara in MFCCs.

    :param folder_names: Liste der Ordner-Namen
    :param is_positive: True, wenn die Audio-Datei Covid-19 positiv ist
    :return: MFCCs und Labels
    """
    converted_files = []
    labels = []
    current_label = 1 if is_positive else 0
    path = Path.resolve(Path("../../datasets/coswara-data/Extracted_data/"))

    for main_folde_name in os.listdir(path):
        sub_folder_path = path / main_folde_name
        sub_folder_list = os.listdir(sub_folder_path)

        for sub_folder_name in sub_folder_list:
            if sub_folder_name in folder_names:
                file_path = sub_folder_path / sub_folder_name

                for file in os.listdir(file_path):
                    if "cough" in file:
                        full_file_path = file_path / file
                        p_full_file_path = Path(full_file_path)

                        if not Path.exists(p_full_file_path):
                            error = "Die Datei existiert nicht unter: " + file
                            print(error)

                        converted = convert_audio_file_to_mfcc(p_full_file_path)
                        if converted is not None:
                            converted_files.append(converted)
                            labels.append(current_label)

    return np.array(converted_files, dtype=np.float32), np.array(
        labels, dtype=np.int32
    )


def get_mfccs_from_coughvid_audio_files(
    folder_names: str, *, is_positive: bool
) -> tuple:
    """Konvertiert die Audio-Dateien von Coughvid in MFCCs.

    :param folder_names: Liste der Ordner-Namen
    :param is_positive: True, wenn die Audio-Datei Covid-19 positiv ist
    :return: MFCCs und Labels
    """
    converted_files = []
    labels = []
    current_label = 1 if is_positive else 0
    path = Path.resolve(Path("../../datasets/Coughvid/converted/"))
    main_folder_path = path / folder_names

    for file in os.listdir(main_folder_path):
        full_file_path = main_folder_path / file
        p_full_file_path = Path(full_file_path)

        if not Path.exists(p_full_file_path):
            error = "Die Datei existiert nicht unter: " + file
            print(error)

        converted = convert_audio_file_to_mfcc(p_full_file_path)
        if converted is not None:
            converted_files.append(converted)
            labels.append(current_label)

    return np.array(converted_files, dtype=np.float32), np.array(
        labels, dtype=np.int32
    )


# Audio-Datei in MFCCs umwandeln
# MFCCs (Mel Frequency Cepstral Coefficients) werden für eine kompakten
# Darstellung des Frequenzspektrums eines Audiosignals verwendet.
def convert_audio_file_to_mfcc(path: Path) -> np.ndarray:
    """Konvertiert eine Audio-Datei in MFCCs, skaliert auf eine feste Größe.

    :param path: Pfad zu der Audio-Datei
    :return: MFCCs in fester Größe und None (Platzhalter für Labels)
    """
    # Lade die Audiodatei (Original-Sampling-Rate beibehalten sr=None)
    audio_data, sample_rate = librosa.load(path, sr=None)

    # Berechne die MFCCs
    mfcc = librosa.feature.mfcc(y=audio_data, sr=sample_rate)

    if len(audio_data) == 0:
        return None

    # Füge eine Kanal-Dimension hinzu (Höhe, Breite, Kanal)
    mfcc = np.expand_dims(mfcc, axis=-1)

    # Skaliere die MFCCs auf die gewünschte Größe (128x128 Pixel)
    mfcc = tf.image.resize(mfcc, TARGET_SHAPE)

    # MFCCs entlang der Höhe oder Breite mitteln
    # um es in eine 1D-Darstellung zu transformieren
    # Mittelwert entlang der Höhe
    return np.mean(mfcc, axis=0)

    # Der nachfolgende Code war ein Versuch, die Parameter für die MFCCs
    # zu optimieren. Leider konnte ich keine Verbesserung feststellen,
    # weshalb der Code hier nur noch als Nachweis dient.

    # try:
    #     # Lade die Audiodatei (Original-Sampling-Rate beibehalten)
    #     audio_data, sample_rate = librosa.load(path, sr=None)

    #     if len(audio_data) == 0:
    #         # raise ValueError(f"Die Audiodatei ist leer: {path}")
    #         return None

    # Berechne die MFCCs
    # Koeffizienten(n_mfcc): Legt die Anzahl der zu berechnenden MFCCs fest.
    # Framelänge (n_fft): Gibt die Anzahl der Samples pro Frame an und
    # bestimmt die Framelänge.
    # Hop-Länge (hop_length): Gibt an, wie viele Samples zwischen den Frames
    # verschoben werden, was die Schrittweite angibt.
    # Grundlage: https://www.researchgate.net/publication/383120141_Optimising_MFCC_parameters_for_the_automatic_detection_of_respiratory_diseases #noqa: E501
    # mfcc = librosa.feature.mfcc(
    #     y=audio_data, sr=sample_rate, n_mfcc=30, n_fft=25, hop_length=5
    # )

    #     mfcc = librosa.feature.mfcc(
    #         y=audio_data, sr=sample_rate
    #     )

    #     # Füge eine Kanal-Dimension hinzu (1 für Graustufen)
    #     mfcc = np.expand_dims(mfcc, axis=-1)

    #     # Skaliere die MFCCs auf die gewünschte Zielgröße
    #     mfcc = tf.image.resize(mfcc, TARGET_SHAPE)

    #     # Konvertiere die MFCCs in ein Numpy-Array
    #     mfcc = mfcc.numpy().astype(np.float32)

    #     # MFCCs entlang der Höhe oder Breite mitteln
    #     # um es in eine 1D-Darstellung zu transformieren
    #     # Mittelwert entlang der Höhe
    #     return np.mean(mfcc, axis=0)

    # except Exception as e:  # noqa: BLE001
    #     print(f"Fehler beim Verarbeiten der Datei {path}: {e}")
    #     return None
