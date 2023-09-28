Escribir un programa que, utilizando el puerto_ PA del
PIO, reciba una cadena de 5 caracteres desde un
dispositivo genėrico, Este dispositivo envia la cadena de
a un caracter a la vez. Los caracteres se deben recibir
desde el dispositivo uno por uno, esperando10
segundos entre cada recepción. El programa debe
finalizar cuando se han recibido todos los caracteres de
la cadena, o cuando se presiona la tecla F10
NO USAR STROBE

            IMR EQU 21H
            CONT EQU 10H
            COMP EQU 11H
            PA EQU 30H
            EOI EQU 20H

            ORG 1000H
            CADENA  DB ?

            ORG 1005
            FIN     DB ?

            ORG 3000H
 SUB_TIMER: PUSH AX
            IN AL, PA       ;LEE EL CARACTER QUE TRE EL DISPOSITIVO GENÉRICO
            MOV [BX], AL    ;ALMACENA EL CARACTER EN LA CADENA
            INC BX          ;INCREMENTA EL INDICE DE LA CADENA PARA ALMACENAR EL SIGUIENTE CARACTER
            DEC CL          ;DECREMENTA EL CONTADOR DE CARACTERES
            CMP CL, 0       ;COMPARA EL CONTADOR CON 0
            JNZ ALGUNOS     ;SI EL CONTADOR ES DIFERENTE DE 0, SALTA A ALGUNOS
            IN AL, IMR      ;PONE EN AL EL VALOR DEL REGISTRO IMR EN AL
            OR AL, 3        ;OR CON 3 PARA HABILITAR LAS INTERRUPCIONES DEL TIMER, EN BINARIO 00000011
            OUT IMR, AL     ;PONE EN EL REGISTRO IMR EL VALOR DE AL, HABILITANDO LAS INTERRUPCIONES DEL TIMER 
            MOV CH,1        ;PONE EN CH EL VALOR 1 
      ALGO: MOV AL, 0       ;PONE EN AL EL VALOR 0
            OUT CONT, AL    ;PONE EN EL REGISTRO CONT EL VALOR DE AL, PARA QUE EL TIMER CUENTE HASTA 0
            MOV AL, 20H     ;PONE EN AL EL VALOR 20H    
            OUT EOI, AL     ;PONE EN EL REGISTRO EOI EL VALOR DE AL, PARA QUE AVISAR QUE TERMINE LA INTERRUPCIÓN
            POP AX
            IRET

            ORG 2000H
            MOV CL,5        ;PONE EN CL EL VALOR 5, QUE ES EL NUMERO DE CARACTERES QUE SE DEBEN RECIBIR
            CALL 
            INT 0
            END
