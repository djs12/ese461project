#Parse through images to create new input vectors

def main():

	#open the image vector files
	f1 = open("image1.txt", "r")
	f2 = open("image2.txt", "r")
	f3 = open("image3.txt", "r")
	f4 = open("image4.txt", "r")
	f5 = open("image5.txt", "r")
	f6 = open("image6.txt", "r")
	f7 = open("image7.txt", "r")
	f8 = open("image8.txt", "r")
	f9 = open("image9.txt", "r")
	f10 = open("image10.txt", "r")
	
	#Create a vectorList[v0.txt, v1.txt, ...]
	vectorList = []
	#Create a file object List [v0, v1, v2...]
	fileList = []
	for j in range(784):
		string = "v" + str(j) + ".txt"
		fileString = "v" + str(j)
		vectorList.append( string )
		#print(vectorList[i])
		#print(fileString)
		fileList.append( fileString )
		fileList[j] = open(vectorList[j], "w+")

	#read all the pixels in each image vector
	lines_1 = f1.readlines()
	lines_2 = f2.readlines()
	lines_3 = f3.readlines()
	lines_4 = f4.readlines()
	lines_5 = f5.readlines()
	lines_6 = f6.readlines()
	lines_7 = f7.readlines()
	lines_8 = f8.readlines()
	lines_9 = f9.readlines()
	lines_10 = f10.readlines()

	#Store one pixel from every vector into a v0, v1, ...
	for i in range(len(lines_1)):
		fileList[i].write(lines_1[i])
		fileList[i].write(lines_2[i])
		fileList[i].write(lines_3[i])
		fileList[i].write(lines_4[i])
		fileList[i].write(lines_5[i])
		fileList[i].write(lines_6[i])
		fileList[i].write(lines_7[i])
		fileList[i].write(lines_8[i])
		fileList[i].write(lines_9[i])
		fileList[i].write(lines_10[i])

	#Close all the files
	for k in range(len(fileList)):
		fileList[k].close()
	

	f1.close()
	f2.close()
	f3.close()
	f4.close()
	f5.close()
	f6.close()
	f7.close()
	f8.close()
	f9.close()
	f10.close()
	

main()