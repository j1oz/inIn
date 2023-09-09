# Script 1: Encontrar el número menor

.data
	num1: 	.asciiz "Introduce el primer número: " 	# Mensaje para pedir el primer número
        num2: 	.asciiz "Introduce el segundo número: " # Mensaje para pedir el segundo número
        num3: 	.asciiz "Introduce el tercer número: " 	# Mensaje para pedir el tercer número
        res: 	.asciiz "El número menor es: " 		# Mensaje para mostrar el resultado
        igual: 	.asciiz "Los tres números son iguales" 	# Mensaje para mostrar si los números son iguales        
.text
main:
	# Se pide el primer número
        li $v0, 4 	# Carga el código de servicio 4 (imprimir cadena) en $v0
        la $a0, num1 	# Carga num1 en el argumento $a0
        syscall    	# Llama al sistema operativo e imprime por consola el mensaje guardado en $a0
        li $v0, 5 	# Carga el código de servicio 5 (leer entero) en $v0
        syscall   	# Llama al sistema operativo para leer por consola
        move $t0, $v0 	# Guarda el número leído en $t0

        # Se pide el segundo número
        li $v0, 4 	# Carga el código de servicio 4 (imprimir cadena) en $v0
        la $a0, num2 	# Carga num1 en el argumento $a0
        syscall    	# Llama al sistema operativo e imprime por consola el mensaje guardado en $a0
        li $v0, 5 	# Carga el código de servicio 5 (leer entero) en $v0
        syscall   	# Llama al sistema operativo para leer por consola
        move $t1, $v0 	# Guarda el número leído en $t1
    	
    	# Se pide el tercer número
        li $v0, 4 	# Carga el código de servicio 4 (imprimir cadena) en $v0
        la $a0, num3 	# Carga num1 en el argumento $a0
        syscall    	# Llama al sistema operativo e imprime por consola el mensaje guardado en $a0
        li $v0, 5 	# Carga el código de servicio 5 (leer entero) en $v0
        syscall   	# Llama al sistema operativo para leer por consola
        move $t2, $v0 	# Guarda el número leído en $t2
    
    	move $t3, $t0 	# Mueve el valor de $t0 a $t3, asumiendo temporalmente que $t0 es el menor
    
    	beq $t1, $t2 sonIgual 	# si los dos últimos números son iguales, salta a la etiqueta sonIgual, si no, pasa a la siguiente linea
    
    	blt $t1, $t3 paso1 	# si no son iguales y si $t1 < $t3, salta a la etiqueta paso1
    	blt $t2, $t3 paso2 	# si $t1 no es < $t3 y si $t2 < $t3, salta a la etiqueta paso2
    
    	j resultado 		# si no se cumple ninguna condición salta a la etiqueta resultado teniedo el numero almacenado en $t3

	paso1:
    		move $t3, $t1 		# como $t1 < $t3, mueve el valor de $t1 a $t3
    		blt $t2, $t3, paso2 	# si $t2 < $t3, salta a la etiqueta paso2
    		j resultado 		# si no se cumple ninguna condición salta a la etiqueta resultado

	paso2:
    		move $t3, $t2 	# Mueve el valor de t2 a t3
    		j resultado 	# Salta a la etiqueta resultado
    	
	sonIgual: 	# Etiqueta para comprobar si los tres números son iguales
		beq $t1, $t3, iguales 	# como $t1 = $t2, entonces pregunta si $t1 = $t0(que esta almacenado en $t3) entonces salta a la etiqueta iguales
		blt $t1, $t3 paso1 	# si no son iguales, pregunta si $t1 < $t0(que esta almacenado en $t3), entonces salta a paso1
		j resultado		# si no se cumple ninguna condición salta a la etiqueta resultado
	
	resultado:
    		li $v0, 4   	# Carga el código de servicio 4 (imprimir cadena) en v0 
    		la $a0, res 	# Carga la dirección del mensaje en a0 
    		syscall    	# Llama al sistema operativo 
    		li $v0, 1    	# Carga el código de servicio 1 (imprimir entero) en v0 
    		move $a0, $t3 	# Mueve el valor de t3 a a0 
    		syscall    	# Llama al sistema operativo 
    		j terminar   	# Salta a la etiqueta terminar

	iguales: 	# Etiqueta para mostrar un mensaje si los tres números son iguales
		li $v0, 4 	# Carga el código de servicio 4 (imprimir cadena) en v0 
		la $a0, igual 	# Carga la dirección del mensaje en a0 
		syscall 	# Llama al sistema operativo
		j terminar   	# Salta a la etiqueta terminar

	terminar: 	# Etiqueta para finalizar el programa
		li $v0, 10 	# Carga el código de servicio 10 (terminar programa) en v0 
		syscall 	# Llama al sistema operativo y finaliza el programa
