#!/bin/env python2
import socket
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-a", dest="eth_iface", help="Ethernet interface to bind with")
parser.add_argument("-p", dest="udp_port", help="UDP port to listen to")
args = parser.parse_args()

eth_iface = None
if args.eth_iface:
    eth_iface = args.eth_iface
else:
    eth_iface = str(socket.INADDR_ANY)

udp_port = None
if args.udp_port:
    udp_port = int(args.udp_port)
else:
    udp_port = 4242

print("Receiving on {0}:{1}".format(eth_iface, udp_port))

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((eth_iface, udp_port))

while True:
    data, addr = sock.recvfrom(1024) # buffer size is 1024 bytes
    print "received message:", data

