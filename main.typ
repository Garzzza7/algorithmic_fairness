#import "@preview/typslides:1.3.4": *


#show: typslides.with(
  ratio: "16-9",
  theme: "bluey",
  font: "Libertinus Serif",
  font-size: 19pt,
  link-style: "color",
  show-page-numbers: true,
  show-progress: true,
)

#set text(lang: "pl")

#let accent = rgb("#3059AB")
#let soft = rgb("#EEF3FA")
#let warm = rgb("#C4853D")
#let red = rgb("#BF3D3D")
#let green = rgb("#28842F")
#let ink = rgb("#1F2937")
#let muted = rgb("#6B7280")

#let s(title, body) = slide(
  title: title,
  margin: (x: 1.5cm, top: 2.3cm, bottom: 1.0cm),
  body,
)
#let ss(body) = slide(body)

#let card(title, body, color: accent, fill: soft) = block(
  width: 100%,
  fill: fill,
  stroke: (left: 3pt + color),
  inset: (x: 0.4cm, y: 0.28cm),
  radius: 0.12cm,
  above: 0.15cm,
  below: 0.15cm,
)[
  #text(weight: "bold", fill: color)[#title]
  #v(0.08cm)
  #body
]

#let badge(body, color: accent) = box(
  fill: color,
  inset: (x: 0.22cm, y: 0.05cm),
  radius: 2pt,
  text(fill: white, weight: "bold", size: 0.72em)[#body],
)

#let source(body) = align(right)[#text(size: 9pt, fill: muted)[#body]]

#let theorem(title, body) = block(
  width: 100%,
  fill: white,
  stroke: 1pt + accent,
  inset: (x: 0.45cm, y: 0.25cm),
  radius: 0.12cm,
  above: 0.1cm,
  below: 0.1cm,
)[
  #text(weight: "bold", fill: accent)[#title]
  #v(0.05cm)
  #body
]

#let callout(body, color: accent, fill: soft) = block(
  width: 100%,
  fill: fill,
  stroke: (left: 4pt + color),
  inset: (x: 0.45cm, y: 0.3cm),
  radius: 0.12cm,
  above: 0.25cm,
  below: 0.1cm,
)[#body]


#front-slide(
  title: "Decyzje algorytmiczne i sprawiedliwość.",
  subtitle: [Kiedy decyzja jest *fair* - i dlaczego nie da się być fair pod każdym względem],
  authors: [M. Wiśniewski, P. Czapla],
  info: [na podstawie prac D. Pessach & E. Shmueli oraz J. W. Patty & E. M. Penn],
)


#s("Algorytm nie jest neutralny - trzy przykłady")[
  #set text(size: 15pt)
  #cols(columns: (1fr, 1fr, 1fr), gutter: 0.35cm)[
    #card("COMPAS", [
      #badge("wymiar sprawiedliwości", color: red)
      #v(0.15cm)
      #text(size: 2em, weight: "bold", fill: red)[2×]
      #linebreak()
      Czarnoskórzy oskarżeni *ok. 2× częściej* byli błędnie oznaczani jako wysokiego ryzyka. Biali - *ok. 2× częściej* jako niskiego.
    ], color: red, fill: rgb("#FDF0EF"))
  ][
    #card("Amazon Hiring", [
      #badge("rekrutacja", color: warm)
      #v(0.15cm)
      #text(size: 2em, weight: "bold", fill: warm)[CV]
      #linebreak()
      Model trenowany na danych zdominowanych przez mężczyzn obniżał oceny CV z sygnałami kobiecymi. Firma wycofała narzędzie.
    ], color: warm, fill: rgb("#FBF4EA"))
  ][
    #card("Chicago", [
      #badge("egzekwowanie prawa", color: accent)
      #v(0.15cm)
      #text(size: 2em, weight: "bold", fill: accent)[3×]
      #linebreak()
      W 2020 r. gospodarstwa w kodach ZIP z większością czarnoskórą dostawały *ponad 3× więcej mandatów* niż w obszarach z większością białą.
    ], color: accent, fill: soft)
  ]

  #v(0.2cm)
  #callout(color: ink, fill: rgb("#F3F4F6"))[
    W każdym przypadku algorytm „działał poprawnie” - a skutki były nierówne. *Neutralność techniczna nie wystarcza.*
  ]
  #source[Źródła: ProPublica (2016, 2020); Reuters (2018); Patty & Penn (2023).]
]


#s("Skąd biorą się błędy poznawcze? Cztery mechanizmy")[
  #set text(size: 15pt)
  #grid(
    columns: (1fr, 1fr),
    gutter: 0.35cm,
    row-gutter: 0.25cm,
    card("01  Dane historyczne", [
      Model uczy się wcześniejszych decyzji - wraz z ich uprzedzeniami. Dane staje się „prawdą” o świecie.
    ], color: red, fill: rgb("#FDF0EF")),
    card("02  Brakujące dane", [
      Braki, selekcja i niereprezentatywna próba. Grupa, której nie ma w danych, znika z modelu.
    ], color: warm, fill: rgb("#FBF4EA")),
    card("03  Funkcja celu", [
      Minimalizacja *błędu średniego* faworyzuje większość. Mniejszość może być „opłacalna” do pominięcia.
    ], color: accent, fill: soft),
    card("04  Proxy", [
      Kod pocztowy, szkoła, wzorce zatrudnienia - cechy pozornie neutralne, które *kodują* atrybut wrażliwy.
    ], color: green, fill: rgb("#EDF7EE")),
  )

#align(center)[
  #image("img/sat.png", 
    height: 80%,
  )
]
#v(0.2cm)

#callout[
    *Przykład SAT:* ten sam wynik może znaczyć co innego. Uczeń z 1400 pkt i uczeń z 1100 pkt, który miał trudniejszy dostęp do przygotowania, mogą mieć podobny potencjał. Usunięcie rasy z modelu *nie usuwa* tej różnicy.
  ]
  #source[Pessach & Shmueli (2022), sekcja 2.]
]


#s("Formalnie: cztery obiekty i jedna macierz")[
  #set text(size: 16pt)
  #cols(columns: (1fr, 1.15fr), gutter: 0.55cm)[
    *Osoba $i$* ma:
    #v(0.1cm)
    - $x_i$ - cechy *dozwolone*: wykształcenie, test, historia;
    - $a_i$ - *atrybut wrażliwy*: płeć, rasa, wiek;
    - $y_i in {0,1}$ - *rzeczywisty wynik*: czy osoba jest kwalifikowana?
    - $delta_i in {0,1}$ - *decyzja*: zatrudnić? przyznać kredyt?

    #v(0.2cm)
    #text(size: 14pt, fill: muted)[$y_i$ często nie jest obserwowane. Algorytm widzi $x_i, a_i$ i przewiduje $y_i$.]
  ][
    #align(center)[
      #table(
        columns: (auto, 1fr, 1fr),
        stroke: 0.5pt + luma(180),
        inset: 6pt,
        align: center + horizon,
        [ ],
        [decyzja $1$],
        [decyzja $0$],
        [wynik $1$],
        table.cell(fill: rgb("#E8F5E9"))[*TP*],
        table.cell(fill: rgb("#FDECEA"))[*FN*],
        [wynik $0$],
        table.cell(fill: rgb("#FDECEA"))[*FP*],
        table.cell(fill: rgb("#E8F5E9"))[*TN*],
      )
    ]
    #v(0.25cm)
    #text(size: 14pt)[
      $"TPR" = frac("TP", "TP" + "FN")$ - czułość
      #linebreak()
      $"FPR" = frac("FP", "FP" + "TN")$ - fałszywy alarm
      #linebreak()
      $"PPV" = frac("TP", "TP" + "FP")$ - precyzja
    ]
  ]

  #v(0.2cm)
  #callout[
    Większość metryk fairness to *różne sposoby porównywania tych samych liczb* między grupami. Dlatego wybór metryki jest wyborem politycznym.
  ]
]

// ---------------------------------------------------------------------------
// Prawo
// ---------------------------------------------------------------------------
#s("Dwie prawne twarze dyskryminacji")[
  #set text(size: 15pt)
  #cols(columns: (1fr, 1fr), gutter: 0.45cm)[
    #card("Dyskryminacja bezpośrednia", [
      *Disparate treatment:* świadome różnicowanie ze względu na atrybut wrażliwy. W wielu systemach prawnych - zakazane.
      #v(0.15cm)
      #text(size: 13pt, fill: muted)[Np. „kobiety zatrudniamy na innych zasadach niż mężczyzn”.]
    ], color: red, fill: rgb("#FDF0EF"))
  ][
    #card("Dyskryminacja pośrednia", [
      *Disparate impact:* pozornie neutralna reguła, która systematycznie gorzej traktuje jedną grupę. *Nie wymaga intencji.*
      #v(0.15cm)
      #text(size: 13pt, fill: muted)[Np. test sprawnościowy, który nie jest potrzebny do pracy, ale odsiewa jedną grupę.]
    ], color: warm, fill: rgb("#FBF4EA"))
  ]

  #v(0.2cm)
  #framed(title: "Ricci v. DeStefano (2009)")[
    #set text(size: 14pt)
    Egzamin na strażaków w New Haven. Zdało 19 białych i 1 Latynos; *żaden czarnoskóry*. Miasto unieważniło wyniki, obawiając się pozwu o disparate impact. Sąd Najwyższy uznał to za *disparate treatment* wobec zdających.
  ]

  #callout[
    *Anti-classification* - „nie używaj atrybutu wrażliwego” - nie gwarantuje braku *disparate impact*. Minimalizowanie jednej formy może zwiększać drugą.
  ]
]

// ---------------------------------------------------------------------------
// Metryki grupowe
// ---------------------------------------------------------------------------
#s("Metryki grupowe: co właściwie wyrównujemy?")[
  #set text(size: 14pt)
  #table(
    columns: (1.15fr, 2.5fr, 1.9fr),
    stroke: 0.4pt + luma(190),
    inset: (x: 0.22cm, y: 0.16cm),
    align: (left + horizon, left + horizon, left + horizon),
    table.header(
      table.cell(fill: accent)[#text(fill: white, weight: "bold")[Metryka]],
      table.cell(fill: accent)[#text(fill: white, weight: "bold")[Co wymaga?]],
      table.cell(fill: accent)[#text(fill: white, weight: "bold")[Co pomija?]],
    ),
    [*Parytet demograficzny* #linebreak() $P(delta=1|A=0) = P(delta=1|A=1)$],
    [Równe wskaźniki pozytywnych decyzji w grupach.],
    [Różne potrzeby i różne *base rates*; może wymagać odwrotnej dyskryminacji.],
    [*Disparate impact* #linebreak() $frac(P(delta=1|A=0), P(delta=1|A=1)) >= 0.8$],
    [Reguła 80%: wskaźnik grupy upośledzonej nie może być niższy niż 80% wskaźnika grupy uprzywilejowanej.],
    [Próg 0,8 jest arbitralny; zależy od kontekstu prawnego.],
    [*Równe szanse* #linebreak() $"TPR"_0 = "TPR"_1$],
    [Osoby *faktycznie kwalifikowane* mają taką samą szansę na pozytywną decyzję.],
    [Nie kontroluje fałszywych alarmów; może pogorszyć FPR w jednej grupie.],
    [*Wyrównane odds* #linebreak() $"TPR"_0 = "TPR"_1$ i $"FPR"_0 = "FPR"_1$],
    [Zarówno true positive, jak i false positive są wyrównane między grupami.],
    [Trudne do spełnienia przy różnych base rates; silne ograniczenie.],
  )

  #v(0.15cm)
  #callout[
    Wszystkie te metryki są *grupowe*: mówią o grupach, nie o konkretnych osobach. To nie jest wada - to wybór poziomu analizy.
  ]
]

// ---------------------------------------------------------------------------
// Parytet predykcyjny, kalibracja, indywidualna
// ---------------------------------------------------------------------------
#s("Parytet predykcyjny, kalibracja, sprawiedliwość indywidualna")[
  #set text(size: 14pt)
  #cols(columns: (1fr, 1fr, 1fr), gutter: 0.35cm)[
    #card("Parytet predykcyjny", [
      $"PPV"_0 = "PPV"_1$ #linebreak()
      Wśród osób z *pozytywną decyzją* odsetek faktycznie kwalifikowanych jest podobny w grupach.
      #v(0.1cm)
      #text(size: 12.5pt, fill: muted)[Odpowiada na pytanie pracodawcy: „czy zatrudnieni są dobrzy?”]
    ], color: accent, fill: soft)
  ][
    #card("Kalibracja", [
      Przewidywane ryzyko zgadza się z *obserwowaną częstością* w grupach.
      #v(0.1cm)
      #text(size: 12.5pt, fill: muted)[Dobre narzędzie audytu, ale samo nie rozstrzyga, czy decyzja jest sprawiedliwa.]
    ], color: warm, fill: rgb("#FBF4EA"))
  ][
    #card("Sprawiedliwość indywidualna", [
      Podobne osoby powinny dostawać podobne decyzje.
      #v(0.1cm)
      #text(size: 12.5pt, fill: muted)[Problem: jak zdefiniować „podobne”? Metryka podobieństwa też jest wyborem wartości.]
    ], color: green, fill: rgb("#EDF7EE"))
  ]

  #v(0.2cm)
  #framed(title: "Paradoks COMPAS")[
    #set text(size: 14pt)
    Narzędzie miało *zbliżony PPV* w obu grupach, ale *różne FPR*. Dlatego obrońcy mogli mówić „jest sprawiedliwe”, a krytycy „jest niesprawiedliwe” - i obie strony miały rację według swojej metryki.
  ]

  #callout[
    *Metryka to wybór wartości.* Nie ma „obiektywnej” metryki, która rozstrzyga spór bez założenia, kogo i przed czym chronimy.
  ]
]

// ---------------------------------------------------------------------------
// Niemożliwość
// ---------------------------------------------------------------------------
#s("Nie da się mieć wszystkiego naraz")[
  #set text(size: 15pt)
  #theorem("Twierdzenie (Kleinberg, Mullainathan & Raghavan, 2016)")[
    #set text(size: 14.5pt)
    Parytet predykcyjny *i* wyrównane odds można spełnić jednocześnie *tylko wtedy*, gdy model jest *perfect predictor* *albo* grupy mają *równe base rates*.
  ]

  #v(0.15cm)
  #cols(columns: (1.05fr, 1fr), gutter: 0.45cm)[
    #card("Co to znaczy w praktyce", [
      - Jeśli grupy różnią się częstością wyniku, *każdy nietrywialny klasyfikator* będzie „niesprawiedliwy” według którejś metryki.
      - Nie jest to wada implementacji ani „leniwego” modelu.
      - To *arytmetyka* warunkowych prawdopodobieństw.
    ], color: accent, fill: soft)
  ][
    #card("Chouldechova (2017)", [
      Parytet predykcyjny (PPV) i wyrównane odds są niezgodne, *chyba że* base rates są równe albo model nie dopuszcza fałszywych alarmów.
      #v(0.1cm)
      #text(size: 13pt, fill: muted)[Niezależny dowód - ten sam wniosek, inna droga.]
    ], color: warm, fill: rgb("#FBF4EA"))
  ]

  #v(0.15cm)
  #callout(color: red, fill: rgb("#FDF0EF"))[
    *Wniosek:* spór o fairness nie jest sporem o to, „czy algorytm jest dobry”. Jest sporem o to, *które błędy akceptujemy i kogo chronimy*.
  ]
]

// ---------------------------------------------------------------------------
// Trade-off
// ---------------------------------------------------------------------------
#s("Kompromis fairness–accuracy - i brak uniwersalnego zwycięzcy")[
  #set text(size: 15pt)
  #cols(columns: (1fr, 1.1fr), gutter: 0.5cm)[
    #card("Klasyczny kompromis", [
      #text(size: 2em, weight: "bold", fill: accent)[fairness ↑]
      #linebreak()
      #text(size: 2em, weight: "bold", fill: red)[accuracy ↓]
      #v(0.15cm)
      Często więcej fairness oznacza gorszy wynik predykcyjny - ale *nie zawsze*.
    ], color: accent, fill: soft)

    #v(0.15cm)
    #card("Kiedy da się poprawić oba?", [
      Lepsze dane, lepszy model i lepsza definicja celu mogą zmniejszyć bias *bez* utraty accuracy. To nie jest prawo fizyki - to zależy od przypadku.
    ], color: green, fill: rgb("#EDF7EE"))
  ][
    *Co mówią benchmarki?*
    #v(0.1cm)
    - Wyniki zależą od *metryki*, *datasetu* i *podziału train/test*.
    - *Nie ma jednej metody*, która dominuje we wszystkich przypadkach.
    - Koszt fairness trzeba nazwać: *kto płaci* i *czyja decyzja się zmienia*.
    #v(0.2cm)
    #callout[
      Pytanie nie brzmi „fair czy accurate?”. Brzmi: *jaka fairness, jakim kosztem i dla kogo?*
    ]
  ]
]

// ---------------------------------------------------------------------------
// Interwencje
// ---------------------------------------------------------------------------
#s("Trzy miejsca interwencji")[
  #set text(size: 13.5pt)
  #cols(columns: (1fr, 1fr, 1fr), gutter: 0.35cm)[
    #card("Pre-process", [
      *Zmieniamy dane przed uczeniem.*
      #v(0.1cm)
      - reweighting, relabeling;
      - fair representation learning;
      - usuwanie proxy.
      #v(0.15cm)
      #text(fill: green)[*+*] działa z każdym modelem #linebreak()
      #text(fill: red)[*−*] gorsza wyjaśnialność; niepewny accuracy
    ], color: accent, fill: soft)
  ][
    #card("In-process", [
      *Zmieniamy uczenie.*
      #v(0.1cm)
      - regularyzacja;
      - ograniczenia w funkcji celu;
      - adversarial learning.
      #v(0.15cm)
      #text(fill: green)[*+*] jawny trade-off fairness–accuracy #linebreak()
      #text(fill: red)[*−*] związana z konkretnym modelem
    ], color: warm, fill: rgb("#FBF4EA"))
  ][
    #card("Post-process", [
      *Zmieniamy wynik gotowego modelu.*
      #v(0.1cm)
      - progi per grupa;
      - flipping decisions;
      - decoupled classifiers.
      #v(0.15cm)
      #text(fill: green)[*+*] działa z gotowym modelem #linebreak()
      #text(fill: red)[*−*] późno, często gorsze wyniki; wymaga atrybutu w test time
    ], color: green, fill: rgb("#EDF7EE"))
  ]

  #v(0.2cm)
  #callout[
    *Nie ma uniwersalnie najlepszej metody.* Kolejność myślenia: *dane → model → decyzja*. Wybór zależy od tego, czy masz etykiety, atrybuty w test time i jaką metrykę chcesz spełnić.
  ]
]

// ---------------------------------------------------------------------------
// Datasety i wybór metody
// ---------------------------------------------------------------------------
#s("Na czym się to bada - i jak wybrać metodę?")[
  #set text(size: 13pt)
  #cols(columns: (1.25fr, 1fr), gutter: 0.5cm)[
    #table(
      columns: (1.05fr, 1.25fr, 1.15fr),
      stroke: 0.4pt + luma(190),
      inset: (x: 0.18cm, y: 0.12cm),
      align: (left + horizon, left + horizon, left + horizon),
      table.header(
        table.cell(fill: accent)[#text(fill: white, weight: "bold")[Dataset]],
        table.cell(fill: accent)[#text(fill: white, weight: "bold")[Domena]],
        table.cell(fill: accent)[#text(fill: white, weight: "bold")[Atrybut wrażliwy]],
      ),
      [COMPAS / ProPublica], [wymiar sprawiedliwości], [rasa; płeć],
      [Adult], [dochody], [wiek; płeć],
      [German Credit], [kredyty], [płeć; wiek],
      [Ricci], [awans], [rasa],
      [College Admissions], [edukacja], [płeć; rasa],
      [Dutch Census], [census], [płeć],
    )
  ][
    *Jak wybrać metodę?*
    #v(0.1cm)
    - masz etykiety i atrybuty? → *in-process*;
    - masz tylko gotowy model? → *post-process*;
    - chcesz niezależności od modelu? → *pre-process*;
    - brak atrybutów? → audyt proxy, ale pomiar fairness jest ograniczony.
  ]

  #v(0.2cm)
  #callout[
    Benchmarki są użyteczne, ale często *małe, amerykańskie i nieprzenośne*. Wynik na COMPAS nie dowodzi, że metoda zadziała w polskim banku.
  ]
  #source[Pessach & Shmueli (2022), sekcja 5.]
]

// ---------------------------------------------------------------------------
// AF vs SD
// ---------------------------------------------------------------------------
#s("Dwie tradycje: algorithmic fairness vs statistical discrimination")[
  #set text(size: 14pt)
  #cols(columns: (1fr, 1fr), gutter: 0.45cm)[
    #card("Algorithmic Fairness (AF)", [
      *Pytanie:* jak zaprojektować sprawiedliwy algorytm?
      #v(0.1cm)
      - cechy i wyniki traktowane jako *egzogeniczne*;
      - optymalizacja przewidywania + ograniczenie fairness;
      - perspektywa: *osoba oceniana* i jej grupa.
    ], color: accent, fill: soft)
  ][
    #card("Statistical Discrimination (SD)", [
      *Pytanie:* dlaczego nierówność powstaje?
      #v(0.1cm)
      - decyzje *strategiczne*, wyniki *endogeniczne*;
      - równowagi, bodźce, self-fulfilling beliefs;
      - perspektywa: *decydent* i mechanizm rynku.
    ], color: warm, fill: rgb("#FBF4EA"))
  ]

  #v(0.2cm)
  #callout[
    *Chicago:* AF pyta „jak uczynić egzekwowanie mandatów fair?”. SD pyta „dlaczego Chicago wybrało system, który tak działa - i kto na tym zyskuje?”.
  ]
  #source[Patty & Penn (2023), sekcje 1–2.]
]

// ---------------------------------------------------------------------------
// Model progu
// ---------------------------------------------------------------------------
#s("Przykład: racjonalny próg może dyskryminować")[
  #set text(size: 13pt)
  #cols(columns: (1fr, 1.1fr), gutter: 0.5cm)[
    #align(center)[
      *Mężczyźni* #v(0.08cm)
      #table(
        columns: (auto, auto, auto),
        stroke: 0.4pt + luma(180),
        inset: 4pt,
        align: center + horizon,
        [], [$x=0$], [$x=1$],
        [$y=0$], [0.4], [0.1],
        [$y=1$], [0.1], [0.4],
      )
      #v(0.2cm)
      *Kobiety* #v(0.08cm)
      #table(
        columns: (auto, auto, auto),
        stroke: 0.4pt + luma(180),
        inset: 4pt,
        align: center + horizon,
        [], [$x=0$], [$x=1$],
        [$y=0$], [0.3], [0.2],
        [$y=1$], [0.2], [0.3],
      )
    ]
  ][
    *Pracodawca:* zysk $B=1$ za zatrudnienie kwalifikowanego, strata $omega=-2$ za niekwalifikowanego.
    #v(0.15cm)
    Próg optymalny:
    $ s = frac(-omega, B - omega) = frac(2,3) $

    #v(0.1cm)
    $ P(y=1 | M, x=1) = frac(0.4, 0.5) = 0.8 > 2/3 $
    $ P(y=1 | F, x=1) = frac(0.3, 0.5) = 0.6 < 2/3 $

    #v(0.1cm)
    Ten sam próg. Brak uprzedzeń. A jednak *mężczyzna z $x=1$ dostaje pracę, kobieta z $x=1$ nie*.
  ]

  #v(0.2cm)
  #callout[
    *Optymalny Bayesowski pracodawca* może naruszać parytet demograficzny i wyrównane odds - bez złych intencji. To nie jest „błąd” modelu; to konsekwencja różnych rozkładów.
  ]
  #source[Patty & Penn (2023), sekcja 6.1, tabele 2–3.]
]

// ---------------------------------------------------------------------------
// Phelps, Arrow, feedback
// ---------------------------------------------------------------------------
#s("Phelps, Arrow i pętla sprzężenia zwrotnego")[
  #set text(size: 13.5pt)
  #cols(columns: (1fr, 1fr), gutter: 0.45cm)[
    #card("Phelpsian: różnice egzogeniczne", [
      Grupy różnią się *base rates* albo *precyzją sygnału*.
      #v(0.1cm)
      - SAT: bogatsi mają tutoring i więcej prób; ten sam wynik ma inną wartość informacyjną;
      - group-blind może łamać PPV, a przy różnej precyzji - także error rate balance;
      - czasem *nie ma* reguły spełniającej obie metryki.
    ], color: accent, fill: soft)
  ][
    #card("Arrovian: wynik endogeniczny", [
      Grupy są *ex ante identyczne*, ale $y$ zależy od *wysiłku i inwestycji*.
      #v(0.1cm)
      - przekonanie pracodawcy → próg → opłacalność wysiłku → kwalifikacje → przekonanie;
      - Coate & Loury (1993): *wiele równowag*;
      - dyskryminacja może być *self-confirming*.
    ], color: warm, fill: rgb("#FBF4EA"))
  ]

  #v(0.25cm)
  #align(center)[
    #box(fill: rgb("#F3F4F6"), inset: (x: 0.5cm, y: 0.3cm), radius: 0.15cm)[
      *przekonanie* → *próg* → *bodziec do inwestycji* → *kwalifikacje* → *przekonanie*
    ]
  ]

  #v(0.15cm)
  #callout[
    *Fairness jest dynamiczna.* Algorytm zmienia zachowanie ludzi, więc „target”, który przewiduje, przesuwa się. Nie można mierzyć fairness tylko na zamrożonym zbiorze danych.
  ]
  #source[Patty & Penn (2023), sekcja 6.2–6.3.]
]

// ---------------------------------------------------------------------------
// Polityka i wyzwania
// ---------------------------------------------------------------------------
#s("Co z tego wynika - i co pozostaje otwarte")[
  #set text(size: 14pt)
  #cols(columns: (1fr, 1fr), gutter: 0.45cm)[
    #card("Implikacje dla polityki", [
      - *Group-blind ≠ fair*: anti-classification może pogłębiać disparate impact.
      - Polityki informacyjne (np. *ban the box*) mogą pomagać *lub* szkodzić - zależą od równowagi.
      - Trzeba mierzyć *reakcje ludzi*, nie tylko błąd modelu.
      - *Wyjaśnialność* i audyt są warunkiem zaufania i zgodności z prawem.
    ], color: accent, fill: soft)
  ][
    #card("Otwarte wyzwania", [
      - *Dane:* bias, braki, niereprezentatywność.
      - *Metryki:* proliferacja, brak porównywalności.
      - *Benchmarki:* mało, często US-centric.
      - *Endogeniczność:* feedback loops, strategic behavior.
      - *Intersekcjonalność:* wiele atrybutów naraz.
    ], color: warm, fill: rgb("#FBF4EA"))
  ]

  #v(0.2cm)
  #callout(color: red, fill: rgb("#FDF0EF"))[
    Największy problem to nie „który algorytm jest fair?”, ale *„fair wobec kogo, w jakim świecie i w jakim horyzoncie czasu?”*.
  ]
]

// ---------------------------------------------------------------------------
// Wnioski
// ---------------------------------------------------------------------------
#s("Pięć rzeczy, które warto zapamiętać")[
  #set text(size: 16pt)
  #set enum(spacing: 0.55em)
  + *Algorytmy dziedziczą bias* z danych, funkcji celu i proxy. Usunięcie atrybutu wrażliwego nie usuwa problemu.
  + *Fairness nie jest jednym pojęciem* - to rodzina niezgodnych metryk: parity, equal opportunity, equalized odds, PPV, kalibracja.
  + *Niemożliwości są arytmetyką*, nie ideologią. Wybór metryki to wybór, które błędy akceptujemy i kogo chronimy.
  + *Naprawiaj na trzech poziomach*: dane, model, decyzja. Nie ma uniwersalnego zwycięzcy - kontekst rozstrzyga.
  + *Ludzie reagują na algorytmy.* Fairness trzeba modelować dynamicznie, bo algorytm zmienia świat, który przewiduje.

  #v(0.25cm)
  #callout(color: accent, fill: soft)[
    #text(size: 18pt, weight: "bold")[Sprawiedliwość algorytmu to nie własność kodu.] #text(size: 18pt)[To decyzja o tym, jakie błędy akceptujemy i kogo chronimy.]
  ]
]

// ---------------------------------------------------------------------------
// Q&A / referencje
// ---------------------------------------------------------------------------
#s("Dziękuję - pytania?")[
  #set text(size: 14pt)
  #cols(columns: (1fr, 1fr), gutter: 0.5cm)[
    *Główne źródła*
    #v(0.1cm)
    - D. Pessach, E. Shmueli. *Algorithmic Fairness.* arXiv:2001.09784; ACM Computing Surveys, 2022.
    - J. W. Patty, E. M. Penn. *Algorithmic Fairness and Statistical Discrimination.* Philosophy Compass 18(1): e12891, 2023.

    #v(0.2cm)
    *W tle*
    #v(0.1cm)
    - S. Corbett-Davies, S. Goel. *The Measure and Mismeasure of Fairness.* 2018.
    - J. Kleinberg, S. Mullainathan, M. Raghavan. *Inherent Trade-Offs in the Fair Determination of Risk Scores.* 2016.
    - A. Chouldechova. *Fair Prediction with Disparate Impact.* 2017.
  ][
    *Kluczowe liczby*
    #v(0.1cm)
    - COMPAS: *6 167* osób; FPR ok. *2×* wyższy dla czarnoskórych oskarżonych.
    - Chicago: *ponad 3×* więcej mandatów w większościowo czarnoskórych ZIP codes.
    - Ricci: *118* osób, *20* zdało egzamin, *0* czarnoskórych.

    #v(0.2cm)
    #callout[
      *Materiały:* `main.typ` - slajdy; `notatki.typ` - pełny skrypt wystąpienia z timingiem.
    ]
  ]
]
