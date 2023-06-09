import paho.mqtt.client as mqttclient
import time
import random

connected = False

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("client is connected")
        global connected
        connected = True
    else:
        print("client is not connected")


def on_message(client, userdata, message):
    print("Message recieved : " + str(message.payload.decode("utf-8")))
    print("message topic : " + str(message.topic))


broker_address = "192.168.217.82"  #172.16.26.63# ip address of broker
port = 1883 # port number in integer
user = ""
password = ""

client = mqttclient.Client("MQTT_Pub")

client.username_pw_set(user, password=password)

client.on_connect = on_connect

client.on_message = on_message

client.connect(broker_address,port=port)

client.loop_start()

while connected != True:
    time.sleep(0.2)

try:
    while True:
        value = input('Enter the message:')
        client.publish("esp32/value1",value)
 
except KeyboardInterrupt:
    client.disconnect()
    client.loop_stop()