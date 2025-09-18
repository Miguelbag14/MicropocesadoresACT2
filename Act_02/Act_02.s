
; Definición de registros
f_n  rn r0     ; número límite (n)
count   rn r1     ; índice de ciclo (i)
temp    rn r2     ;puntero a memoria
fprim rn r3 ; Primer factor del algoritmo
fsec rn r4 ; Segundo factor del algoritmo
;area de variables
;-------------------------
			area variables, data, readwrite
			align
result		dcd		0x20000000	;reserva espacio en memoria, para el resultado 	

; Área de programa
; ----------------
        area    Actividad2_fibonacci, code, readonly
        entry
        export  __main
;inicio del programa
;-------------------

__main
        
        ldr     temp, =result     ; Cargar dirección inicial de SRAM

        
        mov     f_n, #10 ; n numero que pone limite al la serie de fibonacci

         
        mov     fprim, #0 ; Condicion cuando La serie de fibonacci es n=0
        str     fprim, [temp], #4  ; Guardar n(0) = 0 en memoria sram y darle un espacio de 4 bytes para el siguiente dato
        
        
        cmp     f_n, #0      ; Comprobar si n = 0, 
        beq     fin             ; Si n es 0, solo ejecutara lo anterior y el programa acabara 

    
	mov     fprim, #1          ;Condicion cuando la serie de fibonacci es n=1
        str     fprim, [temp], #4  ; Guardar n(1) = 1 y darle su respectivo espacio 

        
        cmp     f_n, #1      ; Comprobar si n = 1. Solo ejecutara cuando f(0) y f(1)
        beq     fin             ; como es n=1 el programa terminara
        

        mov     count, #2

ciclo
        ; Cargar F(i-1)
        ldr    fprim, [temp, #-4]

        ; Cargar F(i-2)
        ldr     fsec, [temp, #-8]

        
        add     fprim, fprim, fsec ;Algoritmo de fibonacci F(i) = F(i-1) + F(i-2)

        
        str     fprim, [temp], #4 ; Guardar F(i) en la memoria correspondiente y darle su separacion de 4 bytes 

        ; Incrementar índice
        add     count, count, #1
        cmp     count, f_n
        ble     ciclo           

fin
        b       fin             ; Bucle infinito para detener la ejecución
        end