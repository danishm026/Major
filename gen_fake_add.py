from random import randint

HEX = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F']

def gen_ip():
	octet1 = randint(1,254);
	octet2 = randint(0,255);
	octet3 = randint(0,255);
	octet4 = randint(0,255);

	ip = str(octet1) + '.' + str(octet2) + '.' + str(octet3) + '.' + str(octet4)
	#ip = '192.168.1.' + str(octet1)
	return ip

def gen_mac():
	mac = ''
	for i in range(6):
		index1 = randint(0,15)
		hex1 = HEX[index1]
		index2 = randint(0,15)
		hex2 = HEX[index2]
		mac = mac + hex1 + hex2 + ':'

	return mac.strip(':')


if __name__ == '__main__':
	for i in range(2,255):
		for j in range (1,255):
			ip = '192.168.' + str(i) + '.' + str(j)
			mac = gen_mac()
			print(ip + ' ' + mac)
