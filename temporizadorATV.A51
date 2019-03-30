;ALUNOS: CLAUBER MARTINS PINTO, LUIZ EUGÊNIO HOFFMANN LOPES E MATHEUS PEREIRA DA SILVA

; --- Vetor de RESET ---
        org             0000h           ;origem no endereço 00h de memória
        ajmp            principal       ;desvia das rotinas de interrupção

; --- Rotinas de Interrupção ---
        org             000Bh           ;a interrupção do Timer0 aponta para este endereço
        reti                            ;retorna da interrupção

; --- Programa Principal ---

principal:
        mov             a,#0FEh         ;move a constante 11111110b para acc
        mov             P2,a            ;configurando P2.0 como saída
        mov             TCON,#50h       ;habilita contagem do Timer0 e Timer1
        mov             TMOD,#11h       ;Configura o Timer0 e Timer1 para incrementar com o ciclo de máquina
                                        ;Configura o Timer0 e Timer1 no modo 1 (16bits)

;T0 inicia em 64686 (TH = 0FCh e TL = 0AEh), para estourar em 850us, 65536 - 64686 = 850us
;T1 inicia em 63736 (TH = 0F8h e TL = 0F8h), para estourar em 950us, 65536 - 63736 = 850 + 950us

        mov             TH0,#0FCh       ;Inicializa TH0 em B1h         
        mov             TL0,#0AEh       ;Inicializa TL0 em E0h

        mov             TH1,#0F8h       ;Inicializa TH1 em 0F8h         
        mov             TL1,#0F8h       ;Inicializa TL1 em 0F8h

loopON:
        jnb             TF0,loopON      ;TF0 igual a 1? Não, descia para loop
        cpl             P2.0            ;Inverte o estado de P2.0

loopOFF:
        jnb             TF1,loopOFF     ;TF1 igual a 1? Não, descia para loop
        clr             TF1             ;Sim, Limpa a flag
        cpl             P2.0            ;Inverteo estado de P2.0
        mov             TH1,#0F8h       ;Inicializa TH1 em 0F8h         
        mov             TL1,#0F8h       ;Inicializa TL1 em 0F8h
        clr             TF0             ;Sim, Limpa a flag de TF0
        mov             TH0,#0FCh       ;Inicializa TH0 em B1h         
        mov             TL0,#0AEh       ;Inicializa TL0 em E0h

        sjmp            loopON          ;loop infinito        

        end                             ;Fim do programa

;/eltonssilva/delay.git
