import csv
import math
import random

def loadCsv(filename):
	lines = csv.reader(open(filename, "r"))
	dataset = list(lines)
	for i in range(len(dataset)):
		for x in range(len(dataset[i])):
			if dataset[i][x] == 'Yes':
				dataset[i][x] = 1.0
			elif dataset[i][x] == "No":
				dataset[i][x]= 0.0
			else:
				dataset[i][x] = float(dataset[i][x])
	return dataset

def Push_Result_To_End():
    for i in range(len(dataset)):
        dataset[i][result_index],dataset[i][-1] = dataset[i][-1],dataset[i][result_index]


#Split dataset into folds
def kfolds(k, dataset):
    folds = []
    random.shuffle(dataset)
    fold_length = len(dataset)//k
    num_folds = k

    for i in range(0,num_folds-1):
        start_index = i*fold_length
        end_index = (i+1)*fold_length
        folds.append(dataset[start_index:end_index])
    folds.append(dataset[end_index:])

    return folds

def probability_of_features(dataset):
    len_dataset = len(dataset)
    prob_features = [] #independent of everything else
    prob_features_given_yes_attribute_true = [] 
    prob_features_given_yes_attribute_false = [] 
    prob_features_given_no_attribute_true = []
    prob_features_given_no_attribute_false = []

    for i in range(num_features):
        positives = 0 #for each attribute
        negatives = 0
        positives_given_yes = 0 #for attribute: true and class is yes
        negatives_given_yes = 0
        positives_given_no = 0
        negatives_given_no = 0
        for j in range(len_dataset):
            if dataset[j][i] == 1:
                positives+=1
                if dataset[j][-1] == 1:
                    positives_given_yes+=1
                else:
                    positives_given_no+=1
            else:
                negatives+=1
                if dataset[j][-1] == 1:
                    negatives_given_yes+=1
                else:
                    negatives_given_no+=1

        prob_features.append(positives/len_dataset)
        prob_features_given_yes_attribute_true.append(positives_given_yes/positives)
        prob_features_given_yes_attribute_false.append(negatives_given_yes/positives)
        prob_features_given_no_attribute_true.append(positives_given_no/negatives)
        prob_features_given_no_attribute_false.append(negatives_given_no/negatives)
    return prob_features,prob_features_given_yes_attribute_true,prob_features_given_yes_attribute_false,prob_features_given_no_attribute_true,prob_features_given_no_attribute_false 

def prob_yes_or_no(dataset):
    len_dataset = len(dataset)
    num_yes = 0
    num_no = 0
    for i in range(len_dataset):
        if dataset[i][-1] == 1:
            num_yes += 1
        else:
            num_no += 1
    return [num_yes/len_dataset,num_no/len_dataset]

def test(dataset):
    accuracy = 0
    for case in dataset:
        probability_yes = 0
        probability_no = 0
        sum_prob_features = 1
        sum_prob_features_if_yes = 1
        sum_prob_features_if_no = 1

        for i in range(num_features):
            condition_of_attribute = case[i]
            if condition_of_attribute == 1:
                sum_prob_features *= prob_features[i]
                sum_prob_features_if_yes *= prob_features_given_yes_attribute_true[i]
                sum_prob_features_if_no *= prob_features_given_no_attribute_true[i]
            else:
                sum_prob_features *= 1 - prob_features[i]
                sum_prob_features_if_yes *= 1 - prob_features_given_yes_attribute_false[i]
                sum_prob_features_if_no *= 1 - prob_features_given_no_attribute_false[i]

        probability_yes = (sum_prob_features_if_yes * prob_result[0])/sum_prob_features
        probability_no = (sum_prob_features_if_no * prob_result[1])/sum_prob_features

        if probability_yes > probability_no:
            prediction =  1
        else:
            prediction =  0

        if prediction == case[-1]:
            accuracy+=1
    print("Accuracy is: ",(accuracy/len(dataset))*100)
    return accuracy/len(dataset)

def split_data(split_Ratio):
    random.shuffle(dataset)
    len_training_set = int(split_Ratio*len(dataset))
    training_set = dataset[0:len_training_set]
    test_set = dataset[len_training_set:]
    return training_set, test_set


        
FILENAME = "SPECT.csv"
num_folds = 10
result_index = 0
dataset = loadCsv(FILENAME)
Push_Result_To_End()
folds = kfolds(num_folds, dataset)
num_features = len(folds[0][0])-1
accuracy = []

print("\n\n\nDATASET USED: ",FILENAME)
print("\n\n\n\n")
for i in range(len(folds)):
    print("FOLD ",i)
    training_set = []
    test_set = []
    for fold_num in range(len(folds)):
        if fold_num != i:
            if len(training_set) == 0:
                training_set = folds[fold_num]
            else:
                training_set += folds[fold_num]
        else:
            test_set = folds[fold_num]

    prob_features,prob_features_given_yes_attribute_true,prob_features_given_yes_attribute_false,prob_features_given_no_attribute_true,prob_features_given_no_attribute_false = probability_of_features(training_set)
    prob_result = prob_yes_or_no(training_set)
    fold_accuracy = test(test_set)
    accuracy.append(fold_accuracy)
# split_Ratio = 0.67
# training_set, test_set = split_data(split_Ratio)
# prob_features,prob_features_given_yes,prob_features_given_no = probability_of_features(training_set)
# prob_result = prob_yes_or_no(training_set)
# fold_accuracy = test(test_set)

average_accuracy = sum(accuracy)/num_folds
print("\n\n\nAccuracy is: ",average_accuracy*100)