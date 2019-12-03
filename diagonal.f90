program fpu
implicit none

! Il modello è N particelle di m=1 collegate contigue a molle con k=1.
! C'è anche un accoppiamento alpha/3 (u_{i+1} - u_i)^3 fra contigui

integer, parameter :: N=32 ! # oscillatori
real*8, parameter :: alpha = 0.25d0 ! costante nonlineare
real*8, parameter :: PI = 4.d0*Datan(1.d0) ! costante nonlineare
integer, parameter :: nmis = 9000 ! numero di misure
integer, parameter :: deltaT = 50 ! tempo fra una misura e l'altra
real*8, parameter :: dt = 0.01d0 ! intervallo di tempo fra uno step e il seguente
real*8 A(N) ! ampiezza dei vari modi
real*8 B(N) ! derivata dell'ampiezza
real*8 omega(N-1) ! frequenze
integer iter1, iter2, i, j
real*8 somma1, somma2

do i=1, N-1
	omega(i) = 2.d0 * dsin(PI*i/(2*N))
enddo 

! setup del lattice
A = 0.d0
B = 0.d0

A(1) = 1.d0

!per ogni iterazione
do iter1=1, nmis
	do iter2=1, deltaT
		!aggiorna le ampiezze
		!A_0 e A_N sono fisse a 0
		do i=1, N-1
			! ricalcola B (p)
			! per farlo vanno calcolate due somme
			somma1 = 0.d0
			somma2 = 0.d0
			do j=(-N+1), (N-1-i)
				somma1 = somma1 + A(abs(j)) * A(abs(i+j))
			enddo
			do j=(N-i), (N-1)
				somma2 = somma2 + A(j) * A(2*N-i-j)
			enddo
			B(i) = B(i) - dt * omega(i)*omega(i)*(0.5d0 * A(i) + alpha/3.0d0 * (somma1-somma2) )
			!ricalcola A (x) usando la B (p) già aggiornata
			A(i) = A(i) + dt * B(i)
		enddo
		! fine aggiornamento reticolo
	enddo
	!scrivo l'ampiezza del modo e l'energia del modo (cinetica + potenziale parte armonica. non ci sono le parti di accoppiamento fra modi)
	!il +6 viene dal tumore di fortran a cui non piace write(5/6,*)
	do i=1, N-1
		write(iter1 + 6,*) A(i), A(i)*A(i)
	enddo
	close(iter1+6)
enddo

end program fpu
