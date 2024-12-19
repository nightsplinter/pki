#import "template.typ": *

#show: project.with(
  title: "Akustische Covid-Diagnose durch Husten",
  author: "Paula Schwalm (Matrikelnummer: 347488)",
  keywords: (
    "./assets/THM.png",
    "Technische Hochschule Mittelhessen",
    "Praktikum Künstliche Intelligenz (PKI)",
  )
)

#pagebreak()
#set heading(numbering: "1.")
#set page(columns: 2)

= Einleitung
#quote(
  quotes: true,
  block: true,
  attribution: [Brian Subirana \ The way you produce sound changes when you have Covid, even if you're asymptomatic. @orginal])[Die Art des Geräusches ändert sich, wenn Sie Covid haben – selbst wenn Sie noch asymptomatisch sind. @heise
]
Die Infektionskrankheit COVID-19, verursacht durch das SARS-CoV-2-Virus, verbreitet sich seit ihrem Ausbruch im Dezember 2019 @deu weltweit und wurde am 11. März von der Weltgesundheitsorganisation (englisch: Word Health Organization, WHO) als Pandemie eingestuft @tages. Erst im Jahr 2022 konnte die Pandemie durch die Entwicklung eines Impfstoffs eingedämmt @mdr und seitdem die Anzahl der Infektionen deutlich reduziert werden.
Das Virus weist eine hohe Symptomvielfalt auf und kann von milden Erkältungserscheinungen bis hin zu schweren Lungenentzündungen führen, die im schlimmsten Fall zum Tod führen können @infektionsschutz. In einer Studie der WHO wurde festgestellt, dass 67,7 % der 55.924 untersuchten Fälle unter einem trockenen Husten litten. Angesichts der Häufigkeit dieses Symptoms haben verschiedene Forscherinnen und Forscher untersucht, ob ein neuronales Netzwerk entwickelt werden kann, das in der Lage ist, eine Audioklassifizierung (COVID-19 positive oder negativ) anhand eines Hustengeräusches durchzuführen. Durch Arbeiten wie "Cough Audio Analysis for COVID-19 Diagnosis" @cough oder "COVID-19 detection using cough sound analysis and deep learning algorithms" @sound konnte gezeigt werden, dass ein solches Verfahren möglich ist und vielversprechende Ergebnisse liefert. Ein solches Verfahren bietet eine kostengünstige, nicht-invasive und schnelle Alternative zu herkömmlichen Testverfahren und zeigt, wie Deep Learning Technologien künftig in der Medizin zur Diagnose von Krankheiten eingesetzt werden könnten.
\
Ziel dieser Arbeit ist die Entwicklung von neuronalen Netzwerken für die vorgestellte Problemstellung, wobei der Fokus auf der Betrachtung von unterschiedlichen Lösungsansätzen liegt. Die Arbeit, die im Rahmen des Moduls "Praktikum Künstliche Intelligenz" (PKI) an der Technischen Hochschule Mittelhessen (THM) im Wintersemester 2024/2025 entstanden ist, verfolgt dabei nicht das Ziel, den optimalen Ansatz zu ermitteln, sondern vielmehr unterschiedliche mögliche Lösungsansätze zu untersuchen. Um möglichst realitätsnahe Ergebnisse zu erzielen, wird darauf geachtet, die Daten nicht vorzuverarbeiten, d. h. es werden keine Hintergrundgeräusche herausgefiltert oder ähnliche Verfahren angewendet.

= Forschungsstand
Eine der ersten Forschungsergebnisse zur Erkennung von COVID-19 durch die Analyse von Hustengeräuschen wurde von Wissenschaftler:innen des Massachusetts Institute of Technology veröffentlicht @orginal. Zur Erkennung entwickelten Sie ein Künstliche Intelligenz (KI) Sprachverarbeitungsframework, das akustische Biomarker-Funktionsextraktoren nutzt und auf einem Convolutional Neural Network (CNN) basiert. Dadurch konnten Sie eine Erkennungsquote von 98,5 % bei nachweislich infizierten Personen erreichen und 100 % bei symptomfreien Probanden @mit, wobei das Modell an 4256 Probanden getestet worden ist.
Aufgrund der vielversprechenden Ergebnisse wurden insbesondere im Zeitraum der Covid-19 Pandemie weitere Forschungsergebnisse veröffentlicht, die sich mit verschiedenen Ansätzen zur Audioklassifizierung von COVID-19 Hustengeräuschen beschäftigen. Beispielsweise wurde in dem Paper "Cough Audio Analysis for COVID-19 Diagnosis" @paper eine Wettbewerbsanalyse von vier verschiedenen Modellen: Multilayer Perceptron (MLP), Convolutional Neural Networks (CNN), Recurrent Neural Networks with Long Short-Term Memory und VGG-19 with Support Vector Machines durchgeführt, wobei das beste Ergebnis mit dem MLP-Modell erzielt wurden konnte.
\
\
Die Literaturrecherche ergab, dass es verschiedene Ansätze zur Audioklassifizierung von COVID-19 Hustengeräuschen gibt, die sich vielen Faktoren wie der Vorverarbeitung der Daten, der Wahl und Komplexität des Modells und der Wahl des Datensatzes unterscheiden. Diese Faktoren beeinflussen die Genauigkeit der Modelle und zeigen, dass es keine allgemeingültige Lösung gibt.
Aufgrund des Endes der Pandemie und der damit verbundenen sinkenden Relevanz von COVID-19 ist die Forschung in diesem speziellen Anwendungsfall rückläufig oder wird nicht mehr weiterverfolgt. Forschende und Unternehmen konzentrieren sich derzeit auf andere medizinische Anwendungsfälle, wie die Erkennung von Tuberkulose oder anderen Krankheiten durch KI-Modelle. So arbeitet Google beispielsweise an einem bioakustischen Model, das Krankheiten, wie Tuberkulose, anhand von Geräuschen erkennen kann, um so eine Frühdiagnostik zu ermöglichen FIXME.

= Datensätze
Es konnten verschiedene Open-Source-Datensätze identifiziert werden, die Hustengeräusche von COVID-19-Patienten enthalten. Dazu gehören COUGHVID, Virufy, Coswara und der Datensatz der Cambridge University. Bei der Recherche konnte festgestellt werden, dass die Datensätze sich teilweise stark voneinander unterscheiden. Beispielsweise ist der Datensatz der Cambridge University, der den größten Datensatz (FIXME Daten) darstellt, nur für Forschungszwecke verfügbar. Der Datensatz Virufy enthält im Gegensatz dazu lediglich 16 Aufnahmen.
\
Die beigefügten Metadaten der Datenquellen unterscheiden ebenfalls voneinander. Beispielsweise enthält der Datensatz COUGHVID Informationen über das Alter, Geschlecht und den Gesundheitszustand der Probanden, während der Datensatz Virufy nur Informationen über eine vorliegende Erkrankung erhält. Der Datensatz FIXME differenziert neben dem Gesundheitszustand zusätzlich auch nach dem Schweregrad der Erkrankung. Alleine die Betrachtung der Datensätze zeigt, dass es kein einheitliches Datenschema im Kontext der Problemstellung gibt. Des Weiteren stellt sich die Frage, mit welchen Metadaten ein Modell trainiert werden sollte, um möglichst genaue Ergebnisse zu erzielen, aber auch ob die Metadaten überhaupt notwendig sind, um die Problemstellung mit ähnlichen Ergebnissen zu lösen.

Die Qualität der Hustengeräusche unterscheidet sich ebenfalls voneinander. Da es sich häufig um online gesammelte Daten handelt, die von Freiwilligen gesammelt wurden und von verschiedenen Geräten  in unterschiedlichen Umgebungen aufgenommen wurden, was sich ebenfalls auf die Qualität des Modells auswirken kann. Hustengeräuschen haben jedoch den Vorteil, dass es sich dabei ein eher unwillkürliches.
Geräusch handelt, wodurch Einflussfaktoren wie Akzent oder Dialekte beim Husten weniger ins Gewicht fallen. Darüber hinaus können Hustengeräusche einfach und kostengünstig aufgenommen werden, was die Verwendung von Hustengeräuschen als Datengrundlage für die Entwicklung eines neuronalen Netzwerks attraktiv macht.
\
Alle hier genannten Datensätze bis auf den Datensatz der Cambridge University wurden im Rahmen dieser Arbeit auf ihre Eignung untersucht. Am Ende fiel die Entscheidung auf den Datensatz COUGHVID, da diese die größte Menge an Daten frei zur Verfügung stellt. Um die Datenvielfalt zu erhöhen, wurde ebenfalls der Datensatz Virufy verwendet. Auf die Verwendung der bereitgestellten Metadaten wurde verzichtet, um die Ergebnisse so realitätsnah wie möglich zu halten und die Modelle möglichst wenig zu beeinflussen. Zum einen kann dadurch festgestellt werden, ob ein Modell allein anhand der Audiodateien in der Lage ist, eine Diagnose zu stellen, und zum anderen kann die Datenmenge so in Zukunft einfacher erweitert werden.

Somit liegen für die Entwicklung insgesamt FIXME Audiodaten vor, wobei FIXME Covid-19-posivit und FIXME Covid-19 negativ sind. Im Durschnitt sind die Audopdaten FIXME Sekunden lang, wodurch sich eine Traningsdauer von FIXME pro FIXME ergibt. Die Daten werden insgesamt in 80% Traningsdaten und 20% Validrungsdaten aufgeteilt, da sich sich dabei um eine Empfehlng von FIXMe handelt.

duschnitts Sampling-Rate

Ein Audio-Signal ist eine eindimensionale Sequenz von Amplitudenwerten. CNNs sind jedoch für die Verarbeitung von 2D- oder 3D-Daten (z. B. Bilder oder Videos) optimiert.
Audiodateien können unterschiedlich lang sein. MFCCs standardisieren die Eingabe und ermöglichen eine feste Eingabegröße für das Modell.
Für einfache Aufgaben reicht oft 128x128.


= Literaturverzeichnis
#bibliography("./lib.yml",full: true, title: none, style: "ieee")
