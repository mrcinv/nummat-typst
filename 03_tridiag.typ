#import "admonitions.typ": opomba
#import "julia.typ": jlfb, jl, pkg, code_box, repl, out

= Tridiagonalni sistemi
<tridiagonalni-sistemi>

== Naloga
<naloga>

- Ustvari podatkovni tip za tri diagonalno matriko in implementiraj operacije množenja `*` z vektorjem in reševanja sistema  $A x=b$ `\`.   
- Za slučajni sprehod v eni dimenziji izračunaj povprečno število korakov, ki jih potrebujemo, da se od izhodišča oddaljimo za $k$ korakov.
  - Zapiši fundamentalno matriko za #link("https://en.wikipedia.org/wiki/Markov_chain")[Markovsko verigo], ki modelira slučajni sprehod za prvih $k$ korakov.
  - Reši sistem s fundamentalno matriko in vektorjem enic.   

== Tridiagonalne matrike

Matrika je #emph[tridiagonalna], če ima neničelne elemente le na glavni diagonali in dveh najbližjih diagonalah. Primer $5 times 5$ tridiagonalne matrike

$
  mat(
    1, 2, 0, 0, 0;
    3, 4, 5, 0, 0;
    0, 6, 7, 6, 0;
    0, 0, 5, 4, 3;
    0, 0, 0, 2, 1
  )
$

Elementi tridiagonalne matrike, za katere se indeksa razlikujeta za več kot 1, so vsi
enaki 0: 
$ |i-j| > 1 => a_(i j) = 0. $

Z implementacijo posebnega tipa za tridiagonalno matriko lahko prihranimo na prostoru, kot tudi časovni zahtevnosti algoritmov, ki delujejo na tridiagonalnih matrikah.

Preden se lotimo naloge, ustvarimo nov paket `Vaja03`, kamor bomo postavili kodo:

#code_box[
  #pkg("generate Vaja03", none, env: "nummat")
  #pkg("develop Vaja03/", none, env: "nummat")
]

Podatkovni tip za tridiagonalne matrike imenujemo `Tridiag` in vsebuje tri polja z elementi na posameznih diagonalah. Definicijo postavimo v `Vaja03/src/Vaja03.jl`:

#code_box[
  #jlfb("Vaja03/src/Vaja03.jl", "# Tridiagonalna")
]

Zgornja definicija omogoča, da ustvarimo nove objekte tipa `Tridiag`

#code_box[
  #repl("using Vaja03", none)
  #repl("Tridiag([3, 6, 5, 2], [1, 4, 7, 4, 1], [2, 5, 6, 3])", none)
]

#opomba(naslov: [Preverjanje skladnosti polj v objektu])[
V zgornji definiciji `Tridiag` smo poleg deklaracije polj dodali tudi 
#link("https://docs.julialang.org/en/v1/manual/constructors/#man-inner-constructor-methods")[notranji konstruktor]
v obliki funkcije `Tridiag`. Vemo, da mora biti dolžina vektorjev `sd` in `zd` za ena 
manjša kot dolžina vektorja `d`. Zato je pogoj najbolje preveriti, ko ustvarimo objekt in
se nam s tem v nadaljevanju ni več treba ukvarjati. Z notranjim konstruktorjem lahko te 
pogoje uveljavimo ob nastanku objekta in preprečimo, da je sploh mogoče ustvariti objekte, 
ki imajo nekonsistentne podatke.
]

Želimo, da se matrike tipa `Tridiag` obnašajo podobno kot generične matrike vgrajenega tipa `Matrix`. Zato funkcijam, ki delajo z matrikami, dodamo specifične metode za podatkovni tip `Tridiag` (več informacij o
#link("https://docs.julialang.org/en/v1/manual/types/")[tipih] in
#link("https://docs.julialang.org/en/v1/manual/interfaces/")[vmesnikih]). Implementiraj metode za naslednje funkcije:

- #jl("size(T::Tridiag)"), ki vrne dimenzije matrike,
- #jl("getindex(T::Tridiag, i, j)"), ki vrne element `T[i,j]`,
- #jl("*(T::Tridiag, x::Vector)"), ki vrne produkt matrike `T` z vektorjem `x`. Za tridiagonalne matrike je časovna zahtevnost množenja matrike z vektorjem bistveno manjša kot v splošnem ($cal(O)(n)$ namesto $cal(O)(n^2)$).

Preden nadaljujemo, preverimo ali so funkcije pravilno implementirane. Napišemo avtomatske teste, ki jih lahko kadarkoli poženemo. V projektu `Vaja03` ustvarimo datoteko `Vaja03/test/runtests.jl` in vanjo zapišemo kodo, ki preveri pravilnost zgoraj definiranih funkcij.   

#code_box[
  #jlfb("Vaja03/test/runtests.jl", "# glava")
]

V paket `Vaja03` moramo dodati še paket `Test`. 

#code_box[
  #pkg("activate Vaja03", none, env: "nummat")
  #pkg("add Test", none, env: "Vaja03")
  #pkg("activate .", none, env: "Vaja03")
]

Teste poženemo v paketnem načinu z ukazom `test Vaja03`:

#code_box[
  #pkg("test Vaja03",
  "...
     Testing Running tests...
Test Summary: | Pass  Total  Time
Velikost      |    1      1  0.0s"
  , env: "nummat")
]

Dopolni teste in testiraj še ostale funkcije!

== Reševanje tridiagonalnega sistema

Poiskali bomo rešitev sistema linearnih enačb $T x = b$, kjer je matrika sistema
tridiagonalna. Sistem lahko rešimo z Gaussovo eliminacijo in obratnim vstavljanjem. Ker 
je v tridiagonalni matriki bistveno manj elementov, se število potrebnih operacij tako za za Gaussovo eliminacijo, kot tudi za obratno vstavljanje bistveno zmanjša. Dodatno predpostavimo, da med eliminacijo ni treba delati delnega pivotiranja.  V nasprotnem primeru se tridiagonalna oblika matrike med Gaussovo eliminacijo podre in se algoritem nekoliko zakomplicira. Na primer za diagonalno dominantne matrike po stolpcih pri Gaussovi eliminaciji pivotiranje ni potrebno.

Časovna zahtevnost Gaussove eliminacije brez pivotiranja za tridiagonalni sistema $T x = b$ je tako linearna ($cal(O)(n)$) namesto kubična ($cal(O)(n^3)$) za splošen sistem. Za obratno vstavljanje pa se časovna zahtevnost z kvadratne ($cal(0)(n^2)$) zmanjša na linearno ($cal(O)(n)$).

Priredite splošna algoritma Gaussove eleminacije in obratnega vstavljanja, da bosta upoštevala lastnosti tridiagonalnih matrik. Napišite funkcijo(operator) 

#code_box[ #jl("function \(T::Tridiagonal, b::Vector)")]

ki poišče rešitev sistema $T x = b$. V datoteko `Vaja03/test/runtests.jl` dodajte test, ki na primeru preveri pravilnost funkcije `\`.  

== Slučajni sprehod
<slučajni-sprehod>
Metode za reševanje tridiagonalnega sistema bomo uporabili na primeru
#link("https://en.wikipedia.org/wiki/Random_walk")[slučajnega sprehoda]
v eni dimenziji. Slučajni sprehod je vrsta
#link("https://en.wikipedia.org/wiki/Stochastic_process")[stohastičnega procesa],
ki ga lahko opišemo z
#link("https://en.wikipedia.org/wiki/Markov_chain")[Markovsko verigo] z
množico stanj, ki je enako množici celih števil $ZZ$. Če se na nekem koraku slučajni sprehod nahaja v stanju $n$, se lahko v naslednjem koraku z verjetnostjo $p in [0, 1]$ premaknemo v stanje $n - 1$ ali z verjetnostjo $q = 1 - p$ v stanje $n + 1$. Prehodne verjetnosti slučajnega sprehoda so enake:

$
  P(X_(i+1) = n + 1 | X_i = n) &= p\
  P(X_(i+1) = n - 1 | X_i = n) &= 1-p.
$

#opomba(naslov: [Definicija Markovske verige])[
Markovska veriga je zaporedje slučajnih spremenljivk
$ X_1, X_2, X_3, dots $
z vrednostmi v množici stanj ($ZZ$ za slučajni sprehod), za katere velja Markovska lastnost

$ 
 P(X_(i+1) = x | X_1 = x_1, X_2 = x_2 dots X_i = x_i) = P(X_(i+1) = x | X_i = x_i),
$

ki pove, da je verjetnost za prehod v naslednje stanje odvisna le od prejšnjega stanja
in ne od starejše zgodovine stanj. V Markovski verigi tako zgodovina, kako je proces prišel v neko stanje ne odloča o naslednjem stanju, ampak odloča le stanje v katerem se trenutno nahaja proces.

Verjetnosti $P(X_(i+1) = x | X_i = x_i)$ imenujemo #emph[prehodne verjetnosti] Markovske verige. V nadaljevanju bomo privzeli, da so prehodne verjetnosti enake za vse korake $k$:
$
 P(X_(k+1) = x | X_k = y) = P(X_2 = x | X_1 = y).
$
]

Simulirajmo prvih 100 korakov slučajnega sprehoda

#jlfb(
  "scripts/03_tridiag.jl",
  "# sprehod"
  )

#figure(
  image("img/03a_sprehod.svg", width: 80%),
  caption: [Simulacija slučajnega sprehoda]
)

#opomba(naslov: [Prehodna matrika Markovske verige])[
Za Markovsko verigo s končno množico stanj ${x_1, x_2, dots x_n}$, lahko prehodne verjetnosti zložimo v matriko. Brez škode lahko stanja ${x_1, x_2, dots x_n}$ nadomestimo z naravnimi števili ${1, 2, dots n}$. Matriko $P$, katere elementi so prehodne verjetnosti prehodov med stanji Markovske verige
$
p_(i j) = P(X_n = j| X_(n-1) = i)
$
imenujemo #link("https://sl.wikipedia.org/wiki/Stohasti%C4%8Dna_matrika")[prehodna matrika]
Markovske verige. Za prehodno matriko velja, da vsi elementi ležijo na $[0,1]$
in je vsota elementov po vrsticah enaka 1
$
sum_(j=1)^n p_(i j) = 1,
$
kar pomeni, da je vektor samih enic $bold(1)=[1, 1, dots, 1]^T$ lastni vektor matrike $P$ za lastno vrednost $1$:

$
P bold(1) = bold(1).
$

Prehodna matrika povsem opiše porazdelitev Markovske verige. Potence prehodne matrike $P^k$
na primer določajo prehodne verjetnosti po $k$ korakih:
$
P(X_k=j|X_1=i).
$
]

== Pričakovano število korakov

Stanje, iz katerega se veriga ne premakne več, imenujemo #emph[absorbirajoče stanje]. Za  absorbirajoče stanje $k$ je diagonalni element prehodne matrike enak $1$, vsi ostali elementi v vrstici pa $0$: 
$
p_(k k) & = P(X_(i+1)=k | X_i = k) = 1\
p_(k l) & = P(X_(i+1)=l | X_i = k) = 0.
$ 

Stanje, ki ni absorbirajoče imenujemo #emph[prehodno stanje]. Markovske verige, ki vsebujejo vsaj eno absorbirajoče stanje imenujemo
#link("https://en.wikipedia.org/wiki/Absorbing_Markov_chain")[absorbirajoča Markovska veriga].

Predpostavimo lahko, da je začetno stanje enako $0$. Iščemo pričakovano število korakov, ko se slučajni sprehod prvič pojavi v stanju $k$ ali $-k$. Zanemarimo stanja, ki so dlje kot $k$ oddaljena od izhodišča in stanji $k$ in $-k$ spremenimo v absorbirajoči stanji. Obravnavamo absorbirajočo verigo z $2k+1$ stanji, pri kateri sta stanji $-k$ in $k$ absorbirajoči, ostala stanja pa ne. Iščemo pričakovano število korakov, da iz začetnega stanja pridemo v eno od absorbirajočih stanj.

Za izračun iskane pričakovane vrednosti uporabimo #link("https://en.wikipedia.org/wiki/Absorbing_Markov_chain#Canonical_form")[kanonično obliko prehodne matrike].

#opomba(naslov: [Kanonična forma prehodne matrike])[

Če ima Markovska veriga absorbirajoča stanja, lahko prehodno matriko
zapišemo v bločni obliki
$
P  = mat(
  Q, T;
  0, I),
$
kjer vrstice $[Q, T]$ ustrezajo prehodnim stanjem, med tem ko vrstice
$[0, I]$ ustrezajo absorbirajočim stanjem. Matrika $Q$ opiše prehodne verjetnosti
za sprehod med prehodnimi stanji, matrika $Q^k$ pa prehodne
verjetnosti po $k$ korakih, če se sprehajamo le po prehodnih stanjih. 

Vsoto vseh potenc matrike $Q$
$
N = sum_(k=0)^infinity Q^k = (I-Q)^(-1)
$

imenujemo #emph[fundamentalna matrika] absorbirajoče markovske verige. Element
$n_(i j)$ predstavlja pričakovano število obiskov stanja $j$, če začnemo
v stanju $i$.
]

Pričakovano število korakov, da dosežemo absorbirajoče stanje iz
začetnega stanja $i$ je $i$-ta komponenta produkta fundamentalne matrike
$N$ z vektorjem samih enic:

$ bold(k) = N bold(1) = (I - Q)^(- 1) bold(1). $

Če želimo poiskati pričakovano število korakov, moramo rešiti sistem
linearnih enačb

$ (I - Q) bold(k) = bold(1). $


Če nas zanima le, kdaj bo sprehod za $k$ oddaljen od izhodišča, lahko
začnemo v $0$ in stanji $k$ in $-k$ proglasimo za absorpcijska
stanja. Prehodna matrika, ki jo dobimo je tridiagonalna z 0 na
diagonali. Matrika $I - Q$ je prav tako tridiagonalna z $1$ na
diagonali in z negativnimi verjetnostmi $-p$ na prvi pod-diagonali
in $-q = p - 1$ na prvi nad-diagonali:

$ I - Q = mat(delim: "(", 1, - q, 0, dots.h, 0; - p, 1, - q, dots.h, 0; dots.v, dots.down, dots.down, dots.down, dots.v; 0, dots.h, - p, 1, - q; 0, dots.h, 0, - p, 1) $

Matrika $I - Q$ je tridiagonalna in po stolpcih diagonalno dominantna. Zato lahko 
uporabimo Gaussovo eliminacijo brez pivotiranja. Najprej napišemo funkcijo, ki zgradi 
matriko $I - Q$:

#code_box[
  #jlfb("scripts/03_tridiag.jl", "# matrika_sprehod")
]

Pričakovano število korakov izračunamo kot rešitev sistema $(I-Q) bold(k) = bold(1)$.
Uporabimo operator `\` za tridiagonalno matriko:

#code_box[
  #jlfb("scripts/03_tridiag.jl", "# koraki")
]

Komponente vektorja $bold(k)$ predstavljajo pričakovano število korakov, ki jih 
slučajni sprehod potrebuje, da prvič doseže stanji $0$ ali $2k$, če začnemo v stanju $i$.

#code_box[
  #jlfb("scripts/03_tridiag.jl", "# koraki slika")
]

#figure(
  image("img/03a_koraki.svg", width:60%),
  caption: [Pričakovano število korakov, ko slučajni sprehod prvič doseže stanji $-10$ ali $10$, v odvisnosti od začetnega stanja $i in {-9, -8 dots -1, 0, 1 dots 8, 9}$.]
)

Za konec se prepričajmo še s 
#link("https://sl.wikipedia.org/wiki/Metoda_Monte_Carlo")[simulacijo Monte Carlo], da so 
rešitve, ki jih dobimo kot rešitev sistem res prave. Slučajni sprehod simuliramo z generatorjem naključnih števil in izračunamo #link("https://en.wikipedia.org/wiki/Sample_mean_and_covariance")[vzorčno povprečje] za število korakov. 

#code_box[
  #jlfb("scripts/03_tridiag.jl", "# simulacija")
]

Za $k = 10$ je pričakovano število korakov enako $100$. Poglejmo, kako se rezultat ujema z vzorčnim povprečjem po velikem številu sprehodov.

#code_box[
  #jlfb("scripts/03_tridiag.jl", "# vzorčno povprečje")
]

#code_box[
  #jlfb("scripts/03_tridiag.jl", "# poskus")
  #out("out/03_tridiag_1.out")
]

== Rešitve

Funkcije definirane v `Vaja03/src/Vaja03.jl`. Metoda `size` vrne dimenzije matrike:

#code_box(
  jlfb("Vaja03/src/Vaja03.jl", "# size")
)

Z metodo `getindex` lahko dostopamo do elementov matrike s sintakso `T[i,j]`:

#code_box(
  jlfb("Vaja03/src/Vaja03.jl", "# getindex")
)

Z metodo `setindex!` lahko spreminjamo elemente matrike:

#code_box(
  jlfb("Vaja03/src/Vaja03.jl", "# setindex")
)

Množenje tridiagonalne matrike z vektorjem:

#code_box(
  jlfb("Vaja03/src/Vaja03.jl", "# množenje")
)

Reševanje tridiagonalnega sistema linearnih enačb:

#code_box(
  jlfb("Vaja03/src/Vaja03.jl", "# deljenje")
)

=== Testi

V nadaljevanju so navedeni primeri testne kode v `Vaja03/test/runtests.jl`, ki preverjajo
pravilnost metod za podatkovni tip `Tridiag`. 

#code_box(
  jlfb("Vaja03/test/runtests.jl", "# getindex")
)

#code_box(
  jlfb("Vaja03/test/runtests.jl", "# setindex")
)

#code_box(
  jlfb("Vaja03/test/runtests.jl", "# množenje")
)

#code_box(
  jlfb("Vaja03/test/runtests.jl", "# deljenje")
)