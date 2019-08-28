##PYTHON 2 CODE

import csv
import math

def train_and_test(train_set,attributes,test_set):

	####TRAINING###
	num_yes=0
	num_no=0

	for i in range(len(train_set)):
		if train_set[i][0]=="Yes":
			num_yes+=1
		if train_set[i][0]=="No":
			num_no+=1

	probability_Yes=float(num_yes)/len(train_set)
	probability_No=float(num_no)/len(train_set)

	prob_Class1_Yes=[0]*(len(attributes)-1)
	prob_Class1_No=[0]*(len(attributes)-1)
	prob_Class0_No=[0]*(len(attributes)-1)
	prob_Class0_Yes=[0]*(len(attributes)-1)

	for j in range(len(train_set)):
		for i in range(1,len(attributes)):
			if train_set[j][i]=='1' and train_set[j][0]=="Yes":
				prob_Class1_Yes[i-1]+=1
			if train_set[j][i]=='1' and train_set[j][0]=="No":
				prob_Class1_No[i-1]+=1
			if train_set[j][i]=='0' and train_set[j][0]=="Yes":
				prob_Class0_Yes[i-1]+=1
			if train_set[j][i]=='0' and train_set[j][0]=="No":
				prob_Class0_No[i-1]+=1
		
	for i in range(len(prob_Class1_No)):
		prob_Class1_No[i]=prob_Class1_No[i]/float(num_no)
	for i in range(len(prob_Class1_Yes)):
		prob_Class1_Yes[i]=prob_Class1_Yes[i]/float(num_yes)
	for i in range(len(prob_Class0_No)):
		prob_Class0_No[i]=prob_Class0_No[i]/float(num_no)
	for i in range(len(prob_Class0_Yes)):
		prob_Class0_Yes[i]=prob_Class0_Yes[i]/float(num_yes)
	
	###TESTING#####
	acc=0
	for j in range(len(test_set)):
		yes_p = probability_Yes
		no_p = probability_No
		for i in range(1,len(attributes)):
			if test_set[j][i]=='0':
				yes_p*=prob_Class0_Yes[i-1]
				no_p*=prob_Class0_No[i-1]
			elif test_set[j][i]=='1':
				yes_p*=prob_Class1_Yes[i-1]
				no_p*=prob_Class1_No[i-1]

		if yes_p>no_p:
			max_prob='Yes'
		else:
			max_prob='No'
		if test_set[j][0]==max_prob:
			acc+=1

	result=float(acc)/len(test_set)
	result*=100
	return result

def make_fold(dataset,fold_num,k):

	n = len(dataset)
	start_index_test=n*(fold_num-1)//k
	end_index_test=n*fold_num//k

	##DEAL WITH EDGE CASES##
	if start_index_test==0:
		start_index_train=end_index_test
		end_index_train=n
		return [dataset[start_index_train:end_index_train],dataset[start_index_test:end_index_test]]
	elif end_index_test==n:
		start_index_train=0
		end_index_train=start_index_test
		return [dataset[start_index_train:end_index_train],dataset[start_index_test:end_index_test]]
	else:
		start_index_train_first=0
		end_index_train_first=start_index_test
		start_index_train_second=end_index_test
		end_index_train_second=n
		new_dataset=[]		
		for i in range(start_index_test):
			new_dataset.append(dataset[i])
		for j in range(end_index_test,n):
			new_dataset.append(dataset[j])

		return [new_dataset,dataset[start_index_test:end_index_test]]

def main():
	filename="SPECT.csv"
	attributes=[]
	rows=[]
	with open(filename,'r') as csvfile:
		csvreader=csv.reader(csvfile)

		attributes=csvreader.next()
		for row in csvreader:
			rows.append(row)
	k=10
	fold_accuracy=[]
	avg_acc = 0.0

	for i in range(1,k+1):
		after_fold=make_fold(rows,i,k)
		train_set=after_fold[0]
		test_set=after_fold[1]
		acc=train_and_test(train_set,attributes,test_set)
		fold_accuracy.append(acc)
	print("The Accuracy for each fold is as follows : ")
	j = 0
	for i in fold_accuracy:
		j+=1
		print "Fold ",j
		print(math.ceil(i))
		avg_acc = avg_acc + float(math.ceil(i))
	avg_acc = avg_acc/10
	
	print("Average accuracy is " + str(avg_acc))

if __name__ == '__main__':
	main()