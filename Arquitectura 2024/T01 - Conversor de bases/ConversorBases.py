def base(numero, bS, bD):
    decimal = 0
    potencia = 0
    result = ''
    for digito in reversed(str(numero)):
        decimal += int(digito) * (bS ** potencia)
        potencia += 1
    while decimal > 0:
        result = str(decimal % bD) + result
        decimal //= bD
    return int(result) if result else 0

while True:
    print('--- Menu ---\n1. Convertir un número\n2. Salir')
    opcion = int(input('Ingrese una de las opciones: '))

    if opcion == 1:
        number = int(input('Ingresa un número'))
        number_base = int(input('Ingrese la base numérica actual: '))
        new_base = int(input('Ingrese la base numérica nueva: '))
        convertion = base(number, number_base, new_base)
        print('El resultado de la conversion es: ', convertion)

    elif opcion == 2:
        break