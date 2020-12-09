from random import randint


f = open('o', 'w')

sequences = ["0001010101"]
for i in range(15):
    while True:
        sequence = ""
        one_counter = 0
        for j in range(10):
            if one_counter == 4:
                n = 0
            else:
                n = randint(0, 1)
            sequence += str(n)
            if n == 1:
                one_counter += 1
        if not sequences.__contains__(sequence):
            sequences.append(sequence)
            break

output = ""
for i, sequence in enumerate(sequences):
    output += str(i).rjust(2, '0') + " => \"" + sequence + "\",\n"

output = output[:-2] + ");"

f.write(output)
