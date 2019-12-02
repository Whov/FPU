Compila e esegui esempio.f90. Si ottengono i file fort.i, 7 le i le 96 (write odia fort5 e fort6, pd).
Questi file contengono ciascuno lo stato dei displacement (tutti e 32) nel tempo (i).
Lo script di gnuplot (che si lancia con gnuplot gnuscript) stampa i grafici in .png.
Eseguire poi convert -delay 25 *.png ANI.gif per stampare ANI.gif, che mette tutto in fila.
Nota bene: i file .png sono stati paddati con zeri davanti fino a lunghezza 2 (%02i in gnuscript). Poiché convert va in ordine lessicografico, se si passano le 99 png assicurarsi di paddare con più zeri.

Ora viene stampato un modo normale (il secondo più lungo). E'possibile calcolare il periodo di tale modo come si vede in gif.
Avendo messo omega=1 ci si può calcolare la frequenza di questo modo
(trovare autovalori di matrice
2 -1  0  0 .. -1
-1 2 -1  0 ..  0
0 -1  2 -1 ..  0
..
-1 ..     0 -1 2
con mathematica e questo viene 0.152241)

Nel tempo "macchina" 50dt=0.5 scatto una foto, che fisicamente (avendo usato -delay 25) vuol dire 0.25s.
Dunque T_macchina = 2pi/omega e T_gif = (T_macchina/0.5) * 0.25 secondi. Viene T_gif_teorico = 8.05s, mentre prendendo 11 misure
con la gif si ottiene in media T_gif_sperimentale = 8.07s.
