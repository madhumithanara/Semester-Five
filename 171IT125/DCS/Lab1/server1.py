import socket 
import threading
import sys
import bss
import time

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) 
sock.bind(("127.0.0.1",5009))
flag = [1,1,1]
IP = [5008,5009,5010]
d = {5009 : "giri" , 5010 : "hari"}

def receiver(threadname,x):
	global sock
	while True:
		data , add = sock.recvfrom(1024)
		if not bss.check(data, add, flag):
			break
	sock.close()	

bss.initialise(3,1)

UDP_IP = "127.0.0.1"
thread = threading.Thread(target = receiver , args = ("Receive" ,0 ))
thread.start()
print("Enter data to be sent. Enter \"exit\" to exit")
message=input()
while message!="exit":
	bss.update()
	message = message.replace(" " ,"~")
	message += " "
	for i in bss.timestamp:
		message += str(i) + ","
	message += " " + str(bss.my_index)
	message=message.encode('utf-8')
	
	for i in range(len(flag)):
		if i != bss.my_index and flag[i] == 1:
			sock.sendto(message,(UDP_IP,IP[i]))
	message = input()
message += " "
bss.update()
for i in bss.timestamp:
	message += str(i) + ","
message += " " + str(bss.my_index)
message=message.encode('utf-8')
for i in range(len(flag)):
	if i!=bss.my_index and flag[i]:
		sock.sendto(message,(UDP_IP,IP[i]))	
sock.close()
sys.exit(0)
print("system exit")