from numpy import random






def introduce_errors(right_dna_string, error_times, nucleotides=None):
    if error_times == 0:
        return right_dna_string

    if nucleotides is None:
        nucleotides = ["A", "C", "G", "T"]

    while True:
        wrong_dna_string = list(right_dna_string)  # introduce error under most dense.

        for _ in range(error_times):
            wrong_type = random.randint(0, 3)  # the probability of three types of errors is the same.
            error_location = random.randint(1, len(wrong_dna_string) - 1)
            if wrong_type == 0:  # substitution
                nucleotide = random.choice(list(filter(lambda n: n != wrong_dna_string[error_location],
                                                       nucleotides)))
                wrong_dna_string[error_location] = nucleotide
            elif wrong_type == 1:  # insertion
                nucleotide = random.choice(nucleotides)
                wrong_dna_string.insert(error_location, nucleotide)
            else:  # deletion
                del wrong_dna_string[error_location]
        wrong_dna_string = "".join(wrong_dna_string)

        if wrong_dna_string != right_dna_string:
            return wrong_dna_string


right_dna = 'ATGCCCCCCG'
error_time = 1
a = introduce_errors(right_dna, error_time, nucleotides=None)
print(a)
