Compila diagonal.f90. Se si esegue a.out si ottengono i file fort.i, 7 le i le 1606 (write odia fort5 e fort6, pd).
Questi file contengono sulla prima colonna l'ampiezza del modo i (alla riga i) e sulla seconda colonna l'energia senza le interazioni anarmoniche.
Eseguire ./converter.sh compie:
esegue a.out
lancia lo script di gnuplot che stampa i grafici in .png;
a gruppi di 100 raccoglie i png in gif e converte la gif in video;
mergia i video.

Di default le cose "intermedie" vengono cancellare e viene outputtato solo output.mp4.

L'energia ignora le parti di interazione fra i modi e manca di un fattore N.

Ora stiamo mettendo l'accoppiamento fra i modi e stiamo andando a 9000*50 passi.
