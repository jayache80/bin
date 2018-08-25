#!/bin/env python
import socket
import argparse
import time

parser = argparse.ArgumentParser()
parser.add_argument("-a", dest="dest_address", help="Destination ip address or hostname")
parser.add_argument("-p", dest="udp_port", help="UDP port")
parser.add_argument("-s", dest="sleep_time", help="Time to sleep between messages")
parser.add_argument("-c", dest="count", help="Total number of messages to send.")
parser.add_argument("-m", dest="message", help="String to send as message payload (ASCII)")
args = parser.parse_args()

dest_addr = None
if args.dest_address:
    dest_addr = args.dest_address
else:
    dest_addr = "localhost"

udp_port = None
if args.udp_port:
    udp_port = int(args.udp_port)
else:
    udp_port = 4242

sleep_time = None
if args.sleep_time:
    sleep_time = float(args.sleep_time)
else:
    sleep_time = 0.1

count = None
continuous = False
if args.count:
    count = int(args.count)
else:
    count = -1
    continuous = True

message = None
if args.message:
    message = args.message
else:
    message = "Hello, world!"

print("UDP target IP: {0}".format(dest_addr))
print("UDP target port: {0}".format(udp_port))
print("message: {0}".format(message))

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
packets_sent = 0

print("\nSending...\n(Press Ctrl+C to halt)")
while continuous or packets_sent < count:
    try:
        time.sleep(sleep_time)
        sock.sendto(message, (dest_addr, udp_port))
        packets_sent += 1
    except KeyboardInterrupt:
        print("Ctrl+C detected")
        break

print("Packets sent: {0}".format(packets_sent))
