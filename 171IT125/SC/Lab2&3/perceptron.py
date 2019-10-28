#Single Layer Perceptron

from random import randrange
from csv import reader
from sklearn.metrics import confusion_matrix

def perceptron(train, test, l_rate, n_epoch,threshold):
	predictions = list()
	weights = train_weights(train, l_rate, n_epoch)
	for row in test:
		prediction = predict(row, weights,threshold)
		predictions.append(prediction)
	return(predictions)

def crossvalidate(dataset, n_folds):
	dataset_split = list()
	dataset_copy = list(dataset)
	fold_size = int(len(dataset) / n_folds)
	for i in range(n_folds):
		fold = list()
		while len(fold) < fold_size:
			index = randrange(len(dataset_copy))
			fold.append(dataset_copy.pop(index))
		dataset_split.append(fold)
	return dataset_split


def solve(dataset, algorithm, n_folds, *args):
	folds = crossvalidate(dataset, n_folds)
	scores = list()
	ps=[]
	rs=[]
	i=1
	for fold in folds:
		train_set = list(folds)
		train_set.remove(fold)
		train_set = sum(train_set, [])
		test_set = list()
		for row in fold:
			row_copy = list(row)
			test_set.append(row_copy)
			row_copy[-1] = None
		predicted = algorithm(train_set, test_set, *args)
		actual = [row[-1] for row in fold]
		tn, fp, fn, tp = confusion_matrix(actual,predicted).ravel()
		precision=tp/(tp+fp)
		recall=tp/(tp+fn)
		accuracy=(tp+tn)/(tp+tn+fp+fn)
		print("...............................................")
		print("\n\n\t\tfold number : ",i)
		i+=1
		print("\naccuracy ------ ",accuracy)
		print("\nprecision ------ ",precision)
		print("\nrecall ------ ",recall)
		
		print("...............................................")
		scores.append(accuracy)
		ps.append(precision)
		rs.append(recall)
	return scores,ps,rs

def predict(row, weights,threshold):
	activation = weights[0]
	for i in range(len(row)-1):
		activation += weights[i + 1] * row[i]
	return 1.0 if activation >= threshold else 0.0


def train_weights(train, l_rate, n_epoch):
	weights = [0.0 for i in range(len(train[0]))]
	patience=20
	error_so_far=0
	error_sum=0
	for epoch in range(n_epoch):
		if(patience==0):
			break
		if(epoch > 20):
			if(error_so_far>error_sum):
				patience-=1
			else:
				patience=20
		error_so_far=error_sum
		for row in train:
			prediction = predict(row, weights,threshold)
			error = row[-1] - prediction
			error_sum+=error
			weights[0] = weights[0] + l_rate * error
			for i in range(len(row)-1):
				weights[i + 1] = weights[i + 1] + l_rate * error * row[i]
	return weights
 
# filename = 'SPECTF.csv'
filename = 'SPECTF.csv'
# filename = 'IRIS.csv'

dataset = list()
with open(filename, 'r') as file:
	csv_reader = reader(file)
	for row in csv_reader:
		if not row:
			continue
		dataset.append(row)

for j in range(len(dataset[0])):
	for i in range(len(dataset)):
		dataset[i][j]=float(dataset[i][j])
	
#----------------------HYPERPARAMETERS---------------------	
n_folds = 10
l_rate = 0.2
n_epoch = 500
threshold= 0.5
#---------------------

scores,precision,recall = solve(dataset, perceptron, n_folds, l_rate, n_epoch,threshold)

print("\n\n\t\t---------FINAL--------")
print('recall ------ %.3f%%' % (sum(recall)*100.0/float(len(recall))))
print('precision ------ %.3f%%' % (sum(precision)*100.0/float(len(precision))))
print('accuracy ------- %.3f%%' % (sum(scores)*100.0/float(len(scores))))
