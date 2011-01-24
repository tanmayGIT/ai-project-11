data = open('GT_FILE.txt', 'r') 
data.seek(0)  

output = open('newfile.txt', 'w')

numericalArray = []
lineno = 0

for line in data:
	
    sentence = line.split()
    if ((len(sentence) < 10) & (len(sentence[8]) > 1)) & (sentence[8][0] != '\'') & (sentence[8][0] != '+') & (sentence[8][0] != '-') & (sentence[8][0] != '*') & (sentence[8][0] != '.') & (sentence[8][0] != '0') & (sentence[8][0] != '1') & (sentence[8][0] != '2') & (sentence[8][0] != '3') & (sentence[8][0] !='4') & (sentence[8][0] != '5') & (sentence[8][0] != '6') & (sentence[8][0] != '7') & (sentence[8][0] !='8') & (sentence[8][0] !='9') & (sentence[8] !='A.')  : 
     	output.write((sentence[0] + ' ' + sentence[8]))
     	output.write('\n')
    else:
  	lineno += 1