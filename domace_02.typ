#import "@preview/minitoc:0.1.0": *

= 2. domača naloga

Tokratna domača naloga je sestavljena iz dveh delov. V prvem delu morate
implementirati program za računanje vrednosti dane funkcije $f lr((x))$.
V drugem delu pa izračunati eno samo številko. Obe nalogi rešite na
#strong[10 decimalk] \(z relativno natančnostjo $bold(10^(- 10))$)
Uporabite lahko le osnovne operacije, vgrajene osnovne matematične
funkcije `exp`, `sin`, `cos`, …, osnovne operacije z matrikami in
razcepe matrik. Vse ostale algoritme morate implementirati sami.

Namen te naloge ni, da na internetu poiščete optimalen algoritem in ga
implementirate, ampak da uporabite znanje, ki smo ga pridobilili pri tem
predmetu, čeprav na koncu rešitev morda ne bo optimalna. Uporabite lahko
interpolacijo ali aproksimacijo s polinomi, integracijske formule,
Taylorjevo vrsto, zamenjave spremenljivk, itd. Kljub temu pazite na
#strong[časovno in prostorsko zahtevnost], saj bo od tega odvisna tudi
ocena.

Izberite #strong[eno] izmed nalog. Domačo nalogo lahko delate skupaj s
kolegi, vendar morate v tem primeru rešiti toliko različnih nalog, kot
je študentov v skupini.

Če uporabljate drug programski jezik, ravno tako kodi dodajte osnovno
dokumentacijo, teste in demo.

#minitoc(title: [Naloge], target: heading.where(depth: 2), depth:4)

== Naloge s funkcijami
<naloge-s-funkcijami>

Implementacija funkcije naj zadošča naslednjim zahtevam:
- relativna napaka je manjša od $5 dot 10^(-11)$ za vse argumente in
- časovna zahtevnost je omejena s konstanto, ki je neodvisna od argumenta.

#minitoc(title: [Naloge], target: heading.where(depth: 3))


=== Fresnelov integral \(težja)
<fresnelov-integral-težja>
Napišite učinkovito funkcijo, ki izračuna vrednosti Fresnelovega
kosinusa

$ C(x) = integral_0^x cos((pi t^2)/2) d t. $

#strong[Namig]: Uporabite pomožni funkciji

$ f(z) &= 1/(pi sqrt(2)) integral_0^oo e^(- (pi z^2 t)/2) /(sqrt(t)(t^2 + 1)) d t\ 
  g(z) &= 1/(pi sqrt(2)) integral_0^oo (sqrt(t) e^(- (pi z^2 t)/2)) /(t^2 + 1) d t,
$
kot je opisano v @dlmf7.

=== Funkcija kvantilov za $N(0 , 1)$
<funkcija-kvantilov-za-n01>
Napišite učinkovito funkcijo, ki izračuna funkcijo kvantilov za standardno normalno
porazdeljeno slučajno spremenljivko. Funkcija kvantilov je inverzna
funkcija $Phi^(-1)(x)$ porazdelitvene funkcije:
$
  Phi(x) = 1/(sqrt(2pi)) integral_(-infinity)^x e^(-t^2/2) d t.
$

Poskrbite, da bo relativna napaka za vrednosti blizu $0$ in $1$ dovolj majhna in da je
časovna zahtevnost omejena z isto konstanto na celem intervalu $(0, 1)$.

=== Integralski sinus \(težja)
<integralski-sinus-težja>
Napišite učinkovito funkcijo, ki izračuna integralski sinus

$ "Si"(x) = integral_0^x frac(sin(t), t) d t. $

Uporabite pomožni funkciji
$ 
  f(z) &= integral_0^oo sin(t)/(t + z) = integral_0^oo e^(-z t)/(t^2 + 1) d t\
  g(z) &= integral_0^oo cos(t)/(t + z) = integral_0^oo (t e^(-z t))/(t^2 + 1) d t\
  "Si"(z) &= pi/2 - f(z)cos(z) - g(z) sin(z),  
$
kot je opisano v @dlmf6.

=== Naravni parameter \(težja)
<besselova-funkcija-težja>

Napišite učinkovito funkcijo, ki izračuna #link("https://en.wikipedia.org/wiki/Differentiable_curve#Length_and_natural_parametrization")[naravni parameter]:

$ s(t) = integral_0^t sqrt(dot(x)(tau)^2 + dot(y)(tau)^2) d tau $

za parametrično krivuljo

$
  (x(t), y(t)) = (t^3 - t, t^2 - 1).
$

Za velike vrednosti argumenta $t$ aproksimirajte funkcijo $s(1/t)^(-1)$ s polinomom.

== Naloge s števili
<naloge-s-števili>

#minitoc(title: [Naloge], target: heading.where(depth: 3))

=== Sila težnosti
<sila-težnosti>
Izračunajte velikost sile težnosti med dvema vzporedno postavljenima
enotskima homogenima kockama na razdalji 1. Predpostavite, da so vse
fizikalne konstante, ki nastopajo v problemu, enake 1. Sila med dvema
telesoma $T_1 , T_2 subset bb(R)^3$ je enaka

$ bold(F) = integral_(T_1) integral_(T_2) frac(bold(r)_1 - bold(r_2), ∥bold(r)_1 - bold(r_2)∥^2) d bold(r)_1 d bold(r)_2 dot.basic $

=== Ploščina hipotrohoide
<ploščina-hipotrohoide>
Izračunajte ploščino območja, ki ga omejuje hypotrochoida podana
parametrično z enačbama:

$ x lr((t)) = lr((a plus b)) cos lr((t)) plus b cos lr((frac(a plus b, b) t)) $

$ y lr((t)) = lr((a plus b)) sin lr((t)) plus b sin lr((frac(a plus b, b) t)) $

za parametra $a = 1$ in $b = - 11 / 7$.

#strong[Namig]: Uporabite formulo za
#link("https://sl.wikipedia.org/wiki/Plo%C5%A1%C4%8Dina#Plo%C5%A1%C4%8Dine_krivo%C4%8Drtnih_likov")[ploščino krivočrtnega trikotnika] pod krivuljo:

$ P = 1 / 2 integral_(t_1)^(t_2) lr((x lr((t)) dot(y) lr((t)) - dot(x) lr((t)) y lr((t)))) d t $

=== Povprečna razdalja \(težja)
<povprečna-razdalja-težja>
Izračunajte povprečno razdaljo med dvema točkama znotraj telesa $T$, ki je enako razliki dveh kock:

$ T = ([- 1 , 1])^3 - ([0 , 1])^3. $

Integral na produktu razlike dveh množic
$(A - B) times (A - B)$ lahko izrazimo kot vsoto integralov:

$ integral_(A - B) integral_(A - B) & f(x, y) d x d y = integral_A integral_A f(x, y) d x d y \
& - 2 integral_A integral_B f(x, y) d x d y + integral_B integral_B f(x, y) d x d y $

=== Ploščina Bézierove krivulje
<ploščina-bézierove-krivulje>

Izračunajte ploščino zanke, ki jo omejuje Bézierova krivulja dana s
kontrolnim poligonom:

$ (0 , 0) , (1 , 1) , (2 , 3) , (1 , 4) , (0 , 4) , (- 1 , 3) , (0 , 1) , (1 , 0). $

#strong[Namig]: Uporabite lahko formulo za
#link("https://en.wikipedia.org/wiki/Area#Area_in_calculus")[ploščino krivočrtnega trikotnika] pod krivuljo:

$ P = 1 / 2 integral_(t_1)^(t_2) lr((x(t) dot(y)(t) - dot(x)(t) y(t))) d t. $

== Lažje naloge \(ocena največ 9)
<lažje-naloge-ocena-največ-9>
Naloge so namenjen tistim, ki jih je strah eksperimentiranja ali pa za
to preprosto nimajo interesa ali časa. Rešiti morate eno od nalog:

=== Gradientni spust z iskanjem po premici


=== Interpolacija z baricentrično formulo
<ineterpolacija-z-baricentrično-formulo>
Napišite program, ki za dano funkcijo $f$ na danem intervalu
$lr([a , b])$ izračuna polinomski interpolant, v Čebiševih točkah.
Vrednosti naj računa z #link("https://en.wikipedia.org/wiki/Lagrange_polynomial#Barycentric_form")[baricentrično Lagrangevo interpolacijo,] po
formuli

$ l(x) = cases(delim: "{", frac(sum frac(f lr((x_j)) lambda_j, x - x_j), sum frac(lambda_j, x - x_j)) & quad x eq.not x_j, f lr((x_j)) & quad "sicer") $

Čebiševe točke so podane na intervalu $lr([- 1 , 1])$ s formulo

$ x_k = cos((2k -1)/(2n) pi), quad k = 0,1 med dots med n-1, $

vrednosti uteži $lambda_k$ pa so enake

$ lambda_k = (- 1)^k cases(delim: "{", 1 & quad 0 lt i lt n, 1 / 2 & quad i = 0 , n & quad "sicer".) $

Za interpolacijo na splošnem intervalu $lr([a , b])$ si pomagaj z
linearno preslikavo na interval $lr([- 1 , 1])$. Program uporabi
za tri različne funkcije $e^(- x^2)$ na $lr([- 1 , 1])$,
$frac(sin x, x)$ na $lr([0 , 10])$ in $lr(|x^2 - 2 x|)$ na
$lr([1 , 3])$. Za vsako funkcijo določi stopnjo polinoma, da napaka
ne bo presegla $10^(- 6)$.

=== Gauss-Legendrove kvadrature
<gauss-legendrove-kvadrature>
Izpelji #link("https://en.wikipedia.org/wiki/Gaussian_quadrature#Gauss%E2%80%93Legendre_quadrature")[Gauss-Legendreovo integracijsko pravilo] na dveh točkah

$ integral_0^h f(x) d x = A f(x_1) + B f(x_2) + R_f $

vključno s formulo za napako $R_f$. Izpelji sestavljeno pravilo za
$integral_a^b f lr((x)) d x$ in napiši program, ki to pravilo uporabi za
približno računanje integrala. Oceni, koliko izračunov funkcijske
vrednosti je potrebnih, za izračun približka za

$ integral_0^5 frac(sin x, x) d x $

na 10 decimalk natančno. _Namig_: Najprej izpelji pravilo na intervalu $[-1, 1]$ in ga 
nato prevedi na poljuben interval $[x_i, x_(i+1)]$. Za oceno napake uporabite izračun z dvojnim številom korakov.
