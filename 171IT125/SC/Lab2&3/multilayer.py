from random import randrange
from random import random
from csv import reader
from math import exp
from sklearn.metrics import confusion_matrix

def forward_prop(net,row):
	inputs = row
	for layers in net:
		new_inputs=[]
		for neuron in layers:
			activation = neuron['weights'][-1]
			for i in range(len(neuron['weights'])-1):
				activation += neuron['weights'][i] * inputs[i]
			neuron['output'] = 1.0/(1.0 + exp(-activation))
			new_inputs.append(neuron['output'])
		inputs = new_inputs
	return inputs

def solve(dataset, algo, num_folds, *args):
	dataset_split = list()
	dataset_copy = list(dataset)
	fold_size = int(len(dataset) / num_folds)
	for i in range(num_folds):
		fold = list()
		while len(fold) < fold_size:
			index = randrange(len(dataset_copy))
			fold.append(dataset_copy.pop(index))
		dataset_split.append(fold)
	folds = dataset_split
	scores = list()

	fold_counter=0
	for fold in folds:
		train_set = list(folds)
		train_set.remove(fold)
		train_set = sum(train_set, [])
		test_set = list()
		for row in fold:
			row_copy = list(row)
			test_set.append(row_copy)
			row_copy[-1] = None
		predicted = algo(train_set, test_set, *args)
		actual = [row[-1] for row in fold]
		correct = 0
		tn, fp, fn, tp=confusion_matrix(actual,predicted).ravel()
		precision=tp/(tp+fp)
		recall=tp/(tp+fn)
		accuracy=(tp+tn)/(tp+fp+tn+fn)

		accuracy = [precision,recall,accuracy]
		scores.append(accuracy[2]*100)
		print("\n\n\n\t\tfold ------- ",fold_counter)
		fold_counter+=1
		print("\n\n\n\t\tprecision ------- ",accuracy[0])
		print("\t\trecall ------- ",accuracy[1])
		print("\t\taccuracy ------- ",accuracy[2])
		print("............................................")
	return scores





def back_prop_calculate_error(net, expect):
	for i in reversed(range(len(net))):
		layer = net[i]
		errors = list()
		if i != len(net)-1:
			for j in range(len(layer)):
				error = 0.0
				for neuron in net[i + 1]:
					error += (neuron['weights'][j] * neuron['delta'])
				errors.append(error)
		else:
			for j in range(len(layer)):
				neuron = layer[j]
				errors.append(expect[j] - neuron['output'])
		for j in range(len(layer)):
			neuron = layer[j]
			neuron['delta'] = errors[j] * neuron['output'] * (1.0 - neuron['output'])

def train_net(net, train, l_rate, n_epoch, n_outputs):
	for epoch in range(n_epoch):
		for row in train:
			outputs = forward_prop(net, row)
			expect = [0 for i in range(n_outputs)]
			expect[int(row[-1])] = 1
			back_prop_calculate_error(net, expect)
			# update weights
			for i in range(len(net)):
				inputs = row[:-1]
				if i != 0:
					inputs = [neuron['output'] for neuron in net[i - 1]]
				for neuron in net[i]:
					for j in range(len(inputs)):
						neuron['weights'][j] += l_rate * neuron['delta'] * inputs[j]
					neuron['weights'][-1] += l_rate * neuron['delta']

def initialize_net(n_inputs, n_hidden, n_outputs):
	net = list()
	hidden_layer = [{'weights':[random() for i in range(n_inputs + 1)]} for i in range(n_hidden)]
	net.append(hidden_layer)
	output_layer = [{'weights':[random() for i in range(n_hidden + 1)]} for i in range(n_outputs)]
	net.append(output_layer)
	return net


def back_propagation(train, test, l_rate, n_epoch, n_hidden):
	n_inputs = len(train[0]) - 1
	n_outputs = len(set([row[-1] for row in train]))
	net = initialize_net(n_inputs, n_hidden, n_outputs)
	train_net(net, train, l_rate, n_epoch, n_outputs)
	predictions = list()
	for row in test:
		outputs = forward_prop(net, row)
		prediction = outputs.index(max(outputs))
		predictions.append(prediction)
	return(predictions)

filename = 'IRIS.csv'
dataset = list()
with open(filename, 'r') as file:
	csv_reader = reader(file)
	for row in csv_reader:
		if not row:
			continue
		dataset.append(row)
for i in range(len(dataset[0])):
	for row in dataset:
		row[i] = float(row[i].strip())

num_folds = 10
l_rate = 0.6
n_epoch = 10
n_hidden = 5
scores = solve(dataset, back_propagation, num_folds, l_rate, n_epoch, n_hidden)
print('\n\nfinal accuracy: %.3f%%' % (sum(scores)/float(len(scores))))