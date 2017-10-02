#! /usr/bin/python

import sys
import csv
import random
def random_pick(some_list, probabilities):
    x = random.uniform(0, 1)
    #print x
    cumulative_probability = 0.0
    for count in range(len(probabilities)):
        cumulative_probability = cumulative_probability + float(probabilities[count])
        #print cumulative_probability, probabilities[count]
        if x < cumulative_probability: 
	    #print count
	    break
    #print count
    return some_list[count]

filename = sys.argv[1]
with open(filename, 'r') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    counts = []
    words = []
    total_count = 0
    for row in reader:
	counts.append(int(row[0]))
        total_count = total_count + int(row[0])
	words.append(row[1])
    #print counts
    #print words
    #print total_count
    probabilities = []
    for num in range(len(counts)):
	probabilities.append(format(counts[num]/(total_count * 1.0),'.4f'))
    #print probabilities

    word = random_pick(words, probabilities)
    print word
	
