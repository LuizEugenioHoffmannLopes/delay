;ALUNOS: CLAUBER MARTINS PINTO, LUIZ EUG�NIO HOFFMANN LOPES E MATHEUS PEREIRA DA SILVA

; --- Vetor de RESET ---
        org             0000h           ;origem no endere�o 00h de mem�ria

; --- Programa Principal ---

principal:
        mov             P2,a            ;1 ;move o valor de acc para o port 3
        cpl             a               ;1 ;complementa o acumulador (acc = not acc)
        mov             P2,a            ;1 ;move o valor de acc para o port P2
        acall           delay850us      ;2 ;chama a rotina de temporiza��o
        ajmp            principal       ;loop infinito

delay850us:
        mov             R1,#032h        ;1                      |ciclo de m�quina do mnem�nico call
                                        ;                       |move o valor 50 decimal para o registrador      

aux1:
        mov             R2,#04h         ;1 x 50                 |move o valor 5 decimal para o registrador      
        nop                             ;1 x 50
        nop                             ;1 x 50

aux2:
        nop                             ;1 x 50 x 4 = 250

        djnz            R2,aux2         ;2 x 50 x 4 = 500       |decrementa o R2 at� chegar a zero
        djnz            R1,aux1         ;2 x 50                 |decrementa o R1 at� chegar a zero

                                        ;----------------------------------------
                                        ;Total = 856 us

delay950us:
        cpl             a               ;1 ;complementa o acumulador (acc = not acc)
        mov             P2,a            ;1 ;move o valor de acc para o port P2
        mov             R3,#32h         ;1             |ciclo de m�quina do mnem�nico call
                                        ;              |move o valor 50 decimal para o registrador      

aux3:
        mov             R4,#04h         ;1 x 50                |move o valor 5 decimal para o registrador      
        nop                             ;1 x 50
        nop                             ;1 x 50
        nop                             ;1 x 50
        nop                             ;1 x 50

aux4:
        nop                             ;1 x 50 x 4 = 200

        djnz            R4,aux4         ;2 x 50 x 4 = 400      |decrementa o R4 at� chegar a zero
        djnz            R3,aux3         ;2 x 50                |decrementa o R3 at� chegar a zero

        ret                             ;2                              |retorna para a fun��o main
                                        ;----------------------------------------
                                        ;Total = 955 us

        end                             ;Fim do programa