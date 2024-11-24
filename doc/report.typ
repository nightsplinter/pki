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

= Literaturverzeichnis
#bibliography("./lib.yml",full: true, title: none, style: "ieee")
