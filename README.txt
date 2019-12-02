Compila e esegui esempio.f90. Si ottengono i file fort.i, 7 le i le 96 (write odia fort5 e fort6, pd).
Questi file contengono ciascuno lo stato dei displacement (tutti e 32) nel tempo (i).
Lo script di gnuplot (che si lancia con gnuplot gnuscript) stampa i grafici in .png.
Eseguire poi convert -delay 25 *.png ANI.gif per stampare ANI.gif, che mette tutto in fila.
Nota bene: i file .png sono stati paddati con zeri davanti fino a lunghezza 2 (%02i in gnuscript). Poiché convert va in ordine lessicografico, se si passano le 99 png assicurarsi di paddare con più zeri.
