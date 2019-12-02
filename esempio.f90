program fpu
implicit none

! Il modello è N particelle di m=1 collegate contigue a molle con k=1.
! C'è anche un accoppiamento alpha/3 (u_{i+1} - u_i)^3 fra contigui

integer, parameter :: N=32 ! # oscillatori
real*8, parameter :: alpha = 0.25d0 ! costante nonlineare
real*8, parameter :: PI = 4.d0*Datan(1.d0) ! costante nonlineare
!integer, parameter :: nmis = 1000 ! numero di misure
!integer, parameter :: DT = 20 ! tempo fra una misura e l'altra
integer, parameter :: iterazioni = 4500 ! temporaneamente, numero di iterazioni
real*8, parameter :: dt = 0.01d0 ! intervallo di tempo fra uno step e il seguente
real*8 chain(N) ! catena di particelle, registro i displacement
real*8 chainD(N) ! catena di particelle, registro le velocità
real*8 support(3) ! serve per registrare i displacement per calcolare lo step successivo
integer iter,i
real*8 k


! breve cenno teorico
! se ho N palline su un cerchio attaccate con molle
! gli automodi sono u_j = A sin(k_{n,N} * j - omega * t)
! dove k_{n,N} = 2pi n/N

k = 2.d0*PI/N

! setup del lattice
do i=1,N
	chain(i) = sin(2.d0*k*i)
enddo
chainD = 0.d0

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
		chainD(i) = chainD(i) - dt * (2.d0*support(2)-support(1)-support(3))
		!salva la posizione del centrale attuale come quello a sinistra del passo dopo
		support(1) = chain(i)
		!ricalcola x usando la p già aggiornata
		chain(i) = chain(i) + dt * chainD(i)
	enddo
	! ultima particella a mano, per non fare casino con chain(N+1) che non esiste
	!ricalcola p
	chainD(N) = chainD(N) - dt * (2.d0*chain(N)-chain(N-1)-chain(1))
	!ricalcola x usando la p già aggiornata
	chain(N) = chain(N) + dt * chainD(N)
	! fine aggiornamento reticolo
	if (modulo(iter, 50) == 0) then
		! visivamente con questa riga si stampa due volte lo stesso punto ai due estremi.
		! studiando i modi normali senza questa, l'estremo destro era un nodo, quello sinistro era solo vicino a un nodo
		write(iter/50 + 6,*) chain(N)
		!stampa normalmente. il +6 viene dal tumore di fortran a cui non piace write(5/6,*)
		do i=1, N
			write(iter/50 + 6,*) chain(i)
		enddo
	endif
enddo

end program fpu
