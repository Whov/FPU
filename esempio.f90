program fpu
implicit none

! Il modello è N particelle di m=1 collegate contigue a molle con k=1.
! C'è anche un accoppiamento alpha/3 (u_{i+1} - u_i)^3 fra contigui

integer, parameter :: N=32 ! # oscillatori
real*8, parameter :: alpha = 0.25 ! costante nonlineare
!integer, parameter :: nmis = 1000 ! numero di misure
!integer, parameter :: DT = 20 ! tempo fra una misura e l'altra
integer, parameter :: iterazioni = 4500 ! temporaneamente, numero di iterazioni
real*8, parameter :: dt = 0.01 ! intervallo di tempo fra uno step e il seguente
real*8 chain(N) ! catena di particelle, registro i displacement
real*8 chainD(N) ! catena di particelle, registro le velocità
real*8 support(3) ! serve per registrare i displacement per calcolare lo step successivo
integer iter,i


! setup del lattice
chain = 0.
chainD = 0.
chain(16) = 1.0

!per ogni iterazione
do iter=1, iterazioni
	!aggiorna il reticolo
	support(1) = chain(N)
	do i=1, N-1
		!support registra i tre valori precedenti delle posizioni
		!support(1) viene fornito dallo step precedente
		support(2) = chain(i)
		support(3) = chain(i+1)
		!ricalcola p
		chainD(i) = chainD(i) - dt * (2*support(2)-support(1)-support(3))
		!salva la posizione del centrale attuale come quello a sinistra del passo dopo
		support(1) = chain(i)
		!ricalcola x usando la p già aggiornata
		chain(i) = chain(i) + dt * chainD(i)
	enddo
	! ultima particella a mano, per non fare casino con chain(N+1) che non esiste
	!ricalcola p
	chainD(N) = chainD(N) - dt * (2*chain(N)-chain(N-1)-chain(1))
	!ricalcola x usando la p già aggiornata
	chain(N) = chain(N) + dt * chainD(N)
	! fine aggiornamento reticolo
	if (modulo(iter, 50) == 0) then
		write(*,*) "Test", iter
		do i=1, N
			write(iter/50 + 6,*) chain(i)
		enddo
	endif
enddo

end program fpu
