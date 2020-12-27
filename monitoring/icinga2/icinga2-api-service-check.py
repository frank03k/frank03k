#!/usr/bin/env python
import requests, json, time, commands
from collections import namedtuple

# deactivate ssl warnings for url requests
import urllib3
urllib3.disable_warnings()

#<========= variables ==============>
# vars for icinga2 api
icinga_user=''
icinga_password=''
icinga_url=''
# vars for server connection
fs_username=''
fs_password=''
# var for output
state_file='./health.html'

#<========= functions ==============>
def mount_fileshare(host, mountpoint):
	"""mount fileshare for the output file"""
	commands.getstatusoutput('mount -t cifs -o user='+fs_username+',password='+fs_password+' //'+host+'/state '+mountpoint)

def umount_fileshare(mountpoint):
	"""umount fileshare after process"""
	commands.getstatusoutput('umount '+mountpoint)

def get_check_information(object, service_state, downtime_state, ack_state):
	"""the value have to be a string - also "1" """
	"""get service information:					"""
	"""	object			= service || host		"""
	"""	service_state 	= 0 || 1 || 2 || 3		"""
	"""	downtime_state 	= 0 || 1				"""
	"""	ack_state 		= 0 || 1 || 2			"""
	requests_url = 'https://'+icinga_url+':5665/v1/objects/'+object+'s'
	headers = {'Accept': 'application/json', 'X-HTTP-Method-Override': 'GET'}
	data = { "attrs": [ "__name", "state", "downtime_depth", "acknowledgement" ], "filter": ""+object+".state == "+service_state+" && "+object+".downtime_depth == "+downtime_state+" && "+object+".acknowledgement == "+ack_state }
	response = requests.get(requests_url, headers = headers, auth=(icinga_user,icinga_password), json=data, verify=False).json()
	print(response)
	if len(response["results"])==0:
		y = 0
	else:
		y = len(response['results'])
	value_list.append(y)

def write_output_file(value1, value2, value3):
	fout=open(state_file,"w")
	t = time.time()
	fout.write(str(t))
	fout.write("\nWert 1: ")
	fout.write(value1)
	fout.write("\nWert 2: ")
	fout.write(value2)
	fout.write("\nWert 3: ")
	fout.write(value3)
	fout.close()

#<========= process ==============>
mount_fileshare("<host>", "<mount>")
value_list = []
# unhandled service warnings
get_check_information("service", "1", "0", "1")
# unhandled service criticals
get_check_information("service", "2", "0", "0")
# unhandled host critical
get_check_information("host", "1", "0", "0")
write_output_file(str(value_list[0]), str(value_list[1]), str(value_list[2]))
umount_fileshare("<mount>")
