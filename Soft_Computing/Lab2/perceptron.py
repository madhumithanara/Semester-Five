import random

samples = 4
input_features = [[0,0],[0,1],[1,0],[1,1]]
actual_values = [0,1,1,1]
num_input_features = 2
# weights = [1 for i in range(num_input_features)]
weights = [0.1,0.3]
bias = -0.5
learning_rate = 0.2
iterations = 5

def predict_y(input_features_sample):
	sum_weights = bias
	for i in range(num_input_features):
		sum_weights += input_features_sample[i]*weights[i]
	'''Implement necessary prediction conversion'''
	if sum_weights > 0:
		prediction = 1
	else:
		prediction = 0
	return prediction

def update_weights(prediction,actual_value,input_features_sample):
	error = actual_value - prediction
	for i in range(num_input_features):
		dw = learning_rate*error*input_features_sample[i]
		weights[i] = weights[i] + dw

def predict():
	predictions = []
	for i in range(samples):
		prediction = predict_y(input_features[i])
		predictions.append(prediction)
		update_weights(prediction,actual_values[i],input_features[i])
	return predictions


def accuracy(predicted):
	correct = 0
	for i in range(len(predicted)):
		if predicted[i] == actual_values[i]:
			correct+=1
	return (correct/samples)*100


for i in range(iterations):
	predictions = predict()
	print("accuracy: ",accuracy(predictions))