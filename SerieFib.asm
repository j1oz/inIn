# Calcular la serie de Fibonacci

.data
    	mensaje: .asciiz "Ingrese el número de términos de la serie: "	# mensaje para pedir el número de terminos de la serie
    	res: 	 .asciiz "La serie de Fibonacci es: "			# mensaje para mostrar el resultado
    	coma: 	 .asciiz ", "						# mensaje para mostrar una coma + espacio

.text
main:
	# Solicita al usuario la cantidad de términos
    	li $v0, 4	# Carga el código de servicio 4 (imprimir cadena) en $v0
    	la $a0, mensaje # Carga mensaje en el argumento $a0
    	syscall		# Llama al sistema operativo e imprime por consola el mensaje guardado en $a0
    	li $v0, 5	# Carga el código de servicio 5 (leer entero) en $v0
    	syscall		# Llama al sistema operativo para leer por consola
    	move $t0, $v0 	# Guarda el número leído en $t0

    	# Inicializa los primeros dos términos de la serie
    	li $t1, 0	# Guarda el número 0 en $t1 (que será el número actual)
    	li $t2, 1	# Guarda el número 1 en $t2 (que será el número siguiente)
    	   	
    	# Muestra el mensaje
    	li $v0, 4	# Carga el código de servicio 4 (imprimir cadena) en $v0
    	la $a0, res	# Carga res en el argumento $a0
    	syscall		# Llama al sistema operativo e imprime por consola el mensaje guardado en $a0
    	
    	#Comprueba si el termino es o no cero
    	bgt $t0, 0, bucle	#Si $t0 > 0 entonces pasa al bucle
    	li $v0, 1		# Carga el código de servicio 1 (imprimir entero) en $v0
       	move $a0, $t0		# Carga el término actual $t0 en $a0
        syscall			# Llama al sistema operativo e imprime por consola el mensaje guardado en $a0
    	j terminar		# Salta a la Etiqueta terminar

    	# bucle para la serie de Fibonacci
    	bucle:
        	# Imprime el término actual $t1
        	li $v0, 1	# Carga el código de servicio 1 (imprimir entero) en $v0
        	move $a0, $t1	# Carga el término actual $t1 en $a0
        	syscall		# Llama al sistema operativo e imprime por consola el mensaje guardado en $a0
        
		# Luego de imprimir el numero actual $t1, imprime coma (una coma y un espacio)
    		li $v0, 4	# Carga el código de servicio 4 (imprimir cadena) en $v0
    		la $a0, coma	# Carga coma en el argumento $a0
    		syscall		# Llama al sistema operativo e imprime por consola el mensaje guardado en $a0
  	
        	# Calcular el siguiente término
        	add $t3, $t1, $t2	# Suma el número actual más el número sguiente y lo almacena en $t3
        	move $t1, $t2		# Ahora mueve número siguiente $t2 a el número actual $t1
        	move $t2, $t3		# Y luego mueve el resultado de la suma que esta en $t3 a el número siguiente $t2
        	
        	subi $t0, $t0, 1	# Se resta inmediatamente 1 de la cantidad de términos que estan en $t0 y se guarda en $t0
        	
        	bnez $t0, bucle		# Si el número de terminos $t0 != 0, continua nuevamente desde el inicio del bucle, cuando sea 0 pasa a la siguiente linea
		j terminar		# Si no se cumple la condición anterior salta a la etiqueta terminar
		
    	terminar: 	# Etiqueta para finalizar el programa
		li $v0, 10 	# Carga el código de servicio 10 (terminar programa) en v0 
		syscall 	# Llama al sistema operativo y finaliza el programa
