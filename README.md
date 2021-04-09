Instruction to run the simulations:

Unzip the file "BIOGRID-ORGANISM-Homo_sapiens-3.5.168.tab2.txt.zip".

The analysis can be reproduced with the open-source software R.
All required additional packages needed for the analysis are installed automatically within the analysis.
In addition, further required data is stored in the demo folder.
Therefore, this "Demo" folder should be opened in R before starting the analysis, e.g.:
setwd("~/Desktop/Demo")
If the Demo folder is located on the Desktop.


*Analysis for power law distribution:
The analysis to check for power law distribution can be started by:
source("Demo_PowerLaw.R")
Output:
trying URL 'https://cran.rstudio.com/bin/macosx/el-capitan/contrib/3.5/poweRlaw_0.70.2.tgz'
Content type 'application/x-gzip' length 3189825 bytes (3.0 MB)
==================================================
downloaded 3.0 MB


The downloaded binary packages are in
	/var/folders/h5/q20dqx7x1kn_t8cg_wsdv8rw0000gn/T//Rtmpdw9scs/downloaded_packages
Expected total run time for 100 sims, using 4 threads is 0.854 seconds.
Warning message:
package ‘poweRlaw’ was built under R version 3.5.2 

Result:
$bootstrap
$p
[1] 0.89

$gof
[1] 0.05216334

$bootstraps
           gof xmin      pars ntail
1   0.20066938    3  2.508456    21
2   0.12180822    7  5.827312     9
3   0.11644634    7  7.293424     6
4   0.03126605    7 10.254086    10
5   0.12406409    3  2.679859    20
6   0.16061067    3  2.877474    22
7   0.12830694    4  4.117383    18
8   0.04725416    4  3.887269    15
9   0.06258490    8  9.315955     5
10  0.10265697    7  8.607742     9
11  0.22150206    3  2.344792    22
12  0.14220584    3  2.802980    23
13  0.04381827    7 11.221520     9
14  0.04669896    7 10.640498     8
15  0.13143157    5  4.041670    12
16  0.10974258    3  2.929806    22
17  0.14220584    3  2.802980    23
18  0.11925878    3  3.299729    22
19  0.17660052    3  2.599279    21
20  0.04914509    7  9.952444     7
21  0.12761518    4  3.829410    17
22  0.14833089    7  6.898891     7
23  0.09540370    3  3.036455    23
24  0.12229437    7  5.446620     7
25  0.09479824    3  3.142267    22
26  0.18168965    3  2.714075    21
27  0.12547036    3  2.749928    22
28  0.05104241    4  4.481278    12
29  0.11731210    4  4.454351    15
30  0.08794315    7  7.656488     9
31  0.15167532    4  3.353517    18
32  0.11870333    4  4.014164    18
33  0.17666980    3  2.877248    23
34  0.10047813    4  3.762082    14
35  0.03126953    7 10.253786    10
36  0.18333197    4  3.589994    18
37  0.06410631    4  4.743206    12
38  0.09392065    3  3.014437    23
39  0.11625682    4  3.499928    15
40  0.05894858    4  4.367592    16
41  0.18209594    3  2.636240    21
42  0.07551922    4  4.240648    14
43  0.05744637    4  5.993595    17
44  0.15933543    4  4.076911    16
45  0.09345659    3  3.586051    21
46  0.04697032    7 10.653811     8
47  0.11816852    3  2.673964    23
48  0.11444096    3  3.268048    22
49  0.17293920    3  2.618755    22
50  0.10730979    4  4.048121    19
51  0.11803321    3  2.974474    22
52  0.15750465    7  6.369709     8
53  0.08085315    3  2.949707    23
54  0.10497518    3  2.927893    23
55  0.08224517    7  9.409752     8
56  0.12073377    3  2.928645    23
57  0.11806567    7  7.812488     6
58  0.11998048    3  2.999547    22
59  0.16220424    3  2.663869    22
60  0.06865705    7  7.928558     9
61  0.12648738    3  2.792464    22
62  0.19689083    3  2.646646    22
63  0.04322803    3  3.399747    22
64  0.13468874    3  4.724049    23
65  0.13538334    3  2.663997    21
66  0.06501831    5  4.993397    10
67  0.08855603    7  8.765833     7
68  0.13561920    3  3.018381    21
69  0.13105300    4  4.176827    16
70  0.11819139    4  4.128465    15
71  0.16363558    3  2.670180    22
72  0.17722275    3  2.690306    21
73  0.13813751    7  7.177643     9
74  0.14234449    3  2.848272    22
75  0.04049542    7  9.717479     9
76  0.16587090    3  2.758837    22
77  0.16045091    3  2.729136    22
78  0.10274937    4  5.907436    13
79  0.13656647    4  3.847340    16
80  0.12146282    3  2.523895    22
81  0.09888255    7  5.812566     5
82  0.12703995    3  2.958613    21
83  0.11546474    4  3.819456    17
84  0.15984492    3  2.984393    22
85  0.08738039    7  7.082493     7
86  0.10623822    3  2.986361    23
87  0.11773407    4  3.923928    14
88  0.10790851    3  2.924441    21
89  0.09526581    7  6.486052     9
90  0.10863810    4  4.209900    16
91  0.09467582    7  7.503823    11
92  0.05215434    7  9.186106     6
93  0.08186307    7  8.505282     7
94  0.11625922    3  2.736030    22
95  0.23938516    3  2.631802    22
96  0.15898526    3  2.721156    22
97  0.16694054    4  3.755269    17
98  0.12617527    4  3.211912    16
99  0.08428413    6  7.488971     7
100 0.06289785    7  8.499031    10

$sim_time
[1] 0.06965631

$seed
NULL

$package_version
[1] ‘0.70.2’

$distance
[1] "ks"

attr(,"class")
[1] "bs_p_xmin"

$degrees
         out inp loop total Z (out) Z (total)
Wnt        0   6    1     7   -1.89      1.19
axin       2   1    0     3   -0.25     -0.87
GSK3b      3   4    0     7    0.57      1.19
DC         2   1    0     3   -0.25     -0.87
bcatenin   1   2    0     3   -1.07     -0.87
TCF        3   0    0     3    0.57     -0.87
FoxO       2   1    0     3   -0.25     -0.87
Rho        5   4    0     9    2.21      2.22
Rac        4   3    0     7    1.39      1.19
MEKK1      2   1    0     3   -0.25     -0.87
JNK        2   2    0     4   -0.25     -0.36
PKC        3   2    0     5    0.57      0.16
IGF        0   2    1     3   -1.89     -0.87
IRS        3   1    0     4    0.57     -0.36
PI3K       3   4    0     7    0.57      1.19
Akt        2   4    0     6   -0.25      0.67
TSC2       3   2    0     5    0.57      0.16
mTORC1     1   1    0     2   -1.07     -1.39
S6K        2   2    0     4   -0.25     -0.36
Ras        2   2    0     4   -0.25     -0.36
Raf        3   1    0     4    0.57     -0.36
ERK        1   3    0     4   -1.07     -0.36
mTORC2     4   4    0     8    1.39      1.70

*Network reduction - removal of superfluous nodes:
Superfluoes nodes from the exemplary network (Siegle et al. 2018 IGF/Wnt crosstalk) can be removed by:
source("Demo_RemovalSuperflousNodes.R")
The simulation will show you the reduced Boolean functions for the exemplary network. 

Result:
[1] "Genes:  Wnt, axin, GSK3b, DC, bcatenin, TCF, FoxO, Rho, Rac, MEKK1, JNK, PKC, IGF, IRS, PI3K, Akt, TSC2, mTORC1, S6K, Ras, Raf, ERK, mTORC2"
[1] 6
[1] 6 7
[1] 5 6 7
[1] 4 5 6 7
[1] 2 4 5 6 7
   targets                               factors
1      Wnt                                   Wnt
3    GSK3b                    !(Wnt | ERK | Akt)
8      Rho  (Wnt | PI3K | mTORC2) & !(Rac | PKC)
9      Rac          (Wnt | PI3K | mTORC2) & !Rho
10   MEKK1                             Rac | Rho
11     JNK                           MEKK1 | Rac
12     PKC                    Rho | Wnt | mTORC2
13     IGF                                   IGF
14     IRS                   IGF & !(S6K & JNK) 
15    PI3K                   (IRS | Ras ) & !Rho
16     Akt                         PI3K | mTORC2
17    TSC2                  !(Akt | ERK) | GSK3b
18  mTORC1                                 !TSC2
19     S6K                        mTORC1 | GSK3b
20     Ras                             IGF | Wnt
21     Raf                    (Ras | PKC) & !Akt
22     ERK                                   Raf
23  mTORC2        !(S6K | GSK3b) & (PI3K | TSC2)


In addition, a new .txt file (reduced_Siegle2018.txt) will be created in your Demo folder. This file with reduced Boolean network functions can be used to accelerate especially the exhaustive search analysis.

*Heuristic search:
The Heuristic search to screen for dynamic influencing nodes can be started by:
source("Demo_Heuristic.R")

Result:
trying URL 'https://cran.rstudio.com/bin/macosx/el-capitan/contrib/3.5/combinat_0.0-8.tgz'
Content type 'application/x-gzip' length 40771 bytes (39 KB)
==================================================
downloaded 39 KB


The downloaded binary packages are in
	/var/folders/h5/q20dqx7x1kn_t8cg_wsdv8rw0000gn/T//Rtmpdw9scs/downloaded_packages

Attaching package: ‘combinat’

The following object is masked from ‘package:utils’:

    combn

[1] "Network:  Siegle2018.txt"
[1] "Genes:  Wnt, axin, GSK3b, DC, bcatenin, TCF, FoxO, Rho, Rac, MEKK1, JNK, PKC, IGF, IRS, PI3K, Akt, TSC2, mTORC1, S6K, Ras, Raf, ERK, mTORC2"
[1] "gene  5  propagates gene  4"
[1] "gene  18  propagates gene  17"
[1] "gene  22  propagates gene  21"
[1] "input gene:  1"
[1] "gene  2  propagates gene  21"
[1] "gene  20  propagates gene  13"
[1] "input gene:  13"

-8 -7 -6 -5 -4 -3 -2  3  4  7  8  9 10 11 12 14 15 16 17 19 21 23 
 1  1  1  1  1  1  1  4  2  1  4  3  1  2  2  1  4  4  2  2  3  4 
[1] "max weight node:  3"
[1] "gene  4  propagates gene  21"
[1] "gene  19  propagates gene  17"

-11 -10  -9  -8  -7  -6  -5  -4  -3  -2   7   8   9  10  11  12  14  15 
  1   1   1   1   1   1   1   1   1   1   1   4   3   1   2   2   1   4 
 16  17  21  23 
  3   2   3   4 
[1] "max weight node:  8"
[1] "gene  10  propagates gene  9"
[1] "gene  11  propagates gene  9"
[1] "gene  12  propagates gene  23"
[1] "gene  15  propagates gene  14"

-16 -15 -14 -13 -12 -11 -10  -9  -8  -7  -6  -5  -4  -3  -2   7   9  14 
  1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   2   3 
 16  17  21  23 
  3   2   3   3 
[1] "max weight node:  14"
[1] "gene  9  propagates gene  23"
[1] "gene  16  propagates gene  23"
[1] "gene  21  propagates gene  23"
[1] "gene  7  propagates gene  23"
[1] "gene  6  propagates gene  23"
[1] "gene  17  propagates gene  23"
[1] "input gene:  23"
[1]  1 13  3  8 14 23

The numbers that appear at the end of the analysis correspond to the order of the Boolean functions in the input file (Siegle2018.txt):
Example:
1 13  3  8 14 23 --> Wnt IGF GSK3b Rho IRS mTORC2

*Exhaustive search:
The responding exhaustive control approach can be started by:
source("Demo_Exhaustive.R")

Result:
> selectedSet <- selecteGenesSet(nwFile, nwFile, k=20)
[1] "Genes:  Wnt, axin, GSK3b, DC, bcatenin, TCF, FoxO, Rho, Rac, MEKK1, JNK, PKC, IGF, IRS, PI3K, Akt, TSC2, mTORC1, S6K, Ras, Raf, ERK, mTORC2"
> combSet <- testNetwork(nwFile,nwFile)
[1] "Genes:  Wnt, axin, GSK3b, DC, bcatenin, TCF, FoxO, Rho, Rac, MEKK1, JNK, PKC, IGF, IRS, PI3K, Akt, TSC2, mTORC1, S6K, Ras, Raf, ERK, mTORC2"
[1] "k: 1"
[1] "k: 2"
[1] "k: 3"
[1] "k: 4"
> print(names(combSet))
[1] "Wnt, Rho, IGF, mTORC2"

Please note, that this simulation can take some time (~ 3.5 hours).

*Intervention effect:
Exemplary, the intervention effect was studied for the node IGF.
source("Demo_InterventionScreening.R")

Result:
[1] "print: intervention target: IGF"
[1] "Missing attractors after interventions:"
[1] "Intervention Attrs Ko: "
[1] 1 1
[1] "Intervention Attrs Oe: "
[1] 3 1 1
[1] "Exh Attrs"
[1] 3 1 1 1 1
[1] "Missing Attrs"
[1] FALSE FALSE FALSE FALSE FALSE
list()
[1] "Additional attractors after knockout:"
[1] "Intervention Attrs Ko: "
[1] 1 1
[1] "Intervention Attrs Oe: "
[1] 3 1 1
[1] "Exh Attrs"
[1] 3 1 1 1 1
[1] "Missing Attrs"
[1] FALSE FALSE
list()
[1] "Additional attractors after overexpression:"
[1] "Intervention Attrs Ko: "
[1] 1 1
[1] "Intervention Attrs Oe: "
[1] 3 1 1
[1] "Exh Attrs"
[1] 3 1 1 1 1
[1] "Missing Attrs"
[1] FALSE FALSE FALSE
list()
[1] "Comparison knockout with overexpression: attractors after overexpression in the set of attractors after knockout"
[1] "Intervention Attrs Ko: "
[1] 1 1
[1] "Intervention Attrs Oe: "
[1] 3 1 1
[1] "Exh Attrs"
[1] 3 1 1 1 1
[1] "Missing Attrs"
[1]  TRUE FALSE  TRUE
[[1]]
  Wnt axin GSK3b DC bcatenin TCF FoxO Rho Rac MEKK1 JNK PKC IGF IRS PI3K Akt
1   0    1     0  0        0   1    0   0   0     0   1   0   1   0    1   0
2   0    1     1  0        1   0    0   1   1     0   0   0   1   1    1   1
3   0    1     0  1        1   1    0   0   0     1   1   1   1   1    0   1
  TSC2 mTORC1 S6K Ras Raf ERK mTORC2
1    0      0   0   1   0   0      0
2    1      1   0   1   1   0      1
3    1      0   1   1   0   1      0

[[2]]
  Wnt axin GSK3b DC bcatenin TCF FoxO Rho Rac MEKK1 JNK PKC IGF IRS PI3K Akt
1   0    1     0  0        1   1    0   0   1     1   1   0   1   0    1   1
  TSC2 mTORC1 S6K Ras Raf ERK mTORC2
1    0      1   1   1   0   0      0

[1] "Comparison overexpression with knockout: attractors after knockout in the set of attractors after overexpression"
[1] "Intervention Attrs Ko: "
[1] 1 1
[1] "Intervention Attrs Oe: "
[1] 3 1 1
[1] "Exh Attrs"
[1] 3 1 1 1 1
[1] "Missing Attrs"
[1] FALSE  TRUE
[[1]]
  Wnt axin GSK3b DC bcatenin TCF FoxO Rho Rac MEKK1 JNK PKC IGF IRS PI3K Akt
1   0    1     1  1        0   0    0   0   0     0   0   0   0   0    0   0
  TSC2 mTORC1 S6K Ras Raf ERK mTORC2
1    1      0   1   0   0   0      0

*Automatic screening in protein interaction database BioGrid:
To screen automatically for the amount of interactions of the biological representatives, we downloaded all interactions from the protein interaction database BioGRID (already included in the Demo folder for humans). Afterwards we included the Entrez IDs of the Boolean network we want to analyse in a string and received the interaction in a csv-table in the Demo folder.
source("Demo_ScreeningProteinDatabases.R")


*Required run time:
The run time depends on the individual networks. The specified run times refer to the Boolean network model of Siegle et al. 2018 and were performed on a Mac Book Pro 2018, 2.2 GHz 6-Core Intel Core i7 with 16 GB Memory.
	***Power law: 1.802 seconds
	***Removal of superfluous nodes: 0.030 seconds
	***Heuristic approach: 23.221 seconds
	***Exhaustive approach: 6060.506 seconds (on 3.4 GHz 8-Core Intel Core i7 with 32 GB Memory)
	***Interaction database screening: 7.192 seconds
	***Intervention screening per node: 0.264 seconds



*Package versions:
R version 3.5.1
poweRlaw version 0.70.2
combinat version 0.0.8
BoolNet version 2.1.4
ggplot2 version 3.2.1
ggpubr version 0.2.4
openxlsx version 4.1.0
RVAideMemoire version 0.9.71
rcompanion version 2.0.10