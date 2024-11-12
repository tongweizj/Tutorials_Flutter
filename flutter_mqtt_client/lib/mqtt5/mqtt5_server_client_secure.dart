/*
 * Package : mqtt5_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 10/05/2020
 * Copyright :  S.Hamblett
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:typed_data/typed_data.dart' as typed;
import 'mqtt_cert.dart';

/// An annotated usage example for a secure mqtt5_server_client. Please read in conjunction
/// with the mqtt5_server_client.dart for a fuller explanation of the client configuration.
/// This example is runnable and uses a Mosquitto broker.
// Create and connect the client
const url = 'thermal.luci.ai'; // The google iot-core MQTT bridge server
const port = 8883; // You can also use 8883 if you so wish
// The client id is a path to your device, example given below, note this contravenes the 23 character client id length
// from the MQTT specification, the mqtt_client allows this, if exceeded and logging is turned on  a warning is given.
const clientId = 'max@luci.ai';
// User name is not used and can be set to anything, it is needed because the password field contains the encoded JWT token for the device
const username = 'max@luci.ai';
// Password contains the encoded JWT token, example below, the JWT token when generated should be encoded with the private key coresponding
// to the public key you have set for your device.
const password = '123456';

final client = MqttServerClient(url, '');
const pubTopic = 'luci';
bool topicNotified = false;
final builder = MqttPayloadBuilder();

class MyClient {
  Future<int> main() async {
    /// Set logging on if needed, defaults to off
    client.logging(on: false);

    /// Set secure working
    client.secure = true;

    // Set the port
    client.port =
        port; // Secure port number for mosquitto, no client certificate required

    /// Security context
    // final currDir = '${path.current}${path.separator}example${path.separator}';
    final context = SecurityContext.defaultContext;
    // context.setTrustedCertificates(
    //     currDir + path.join('pem', 'mosquitto.org.crt'));

    context.setTrustedCertificatesBytes(utf8.encode(cert_ca));
    context.useCertificateChainBytes(utf8.encode(cert_client_crt));
    context.usePrivateKeyBytes(utf8.encode(cert_client_key));

    /// If you intend to use a keep alive value in your connect message that is not the default(60s)
    /// you must set it here
    client.keepAlivePeriod = 20;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client.onConnected = onConnected;

    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    /// You can add these before connection or change them dynamically after connection if
    /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    /// can fail either because you have tried to subscribe to an invalid topic or the broker
    /// rejects the subscribe request.
    client.onSubscribed = onSubscribed;

    /// Set a ping received callback if needed, called whenever a ping response(pong) is received
    /// from the broker.
    client.pongCallback = pong;

    /// Set an on bad certificate callback, note that the parameter is needed.
    client.onBadCertificate = (dynamic a) => true;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password, the default keepalive interval(60s)
    /// and clean session, an example of a specific one below.
    final connMess = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean(); // Non persistent session for testing
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    try {
      await client.connect(username, password);
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    /// Ok, lets try a subscription
    print('EXAMPLE::Subscribing to the test/lol topic');
    const topic = 'luci'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atMostOnce);

    final buff = typed.Uint8Buffer(6);
    buff[0] = 'h'.codeUnitAt(0);
    buff[1] = 'i'.codeUnitAt(0);
    buff[2] = 'l'.codeUnitAt(0);
    buff[3] = 'u'.codeUnitAt(0);
    buff[4] = 'c'.codeUnitAt(0);
    buff[5] = 'i'.codeUnitAt(0);
    client.publishMessage(topic, MqttQos.exactlyOnce, buff);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final pt = MqttUtilities.bytesToStringAsString(recMess.payload.message);

      /// The above may seem a little convoluted for users only interested in the
      /// payload, some users however may be interested in the received publish message,
      /// lets not constrain ourselves yet until the package has been in the wild
      /// for a while.
      /// The payload is a byte buffer, this will be specific to the topic
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');

      /// Indicate the notification is correct
      if (c[0].topic == pubTopic) {
        topicNotified = true;
      }
    });

    /// If needed you can listen for published messages that have completed the publishing
    /// handshake which is Qos dependant. Any message received on this stream has completed its
    /// publishing handshake with the broker.
    client.published.listen((MqttPublishMessage message) {
      print(
          'EXAMPLE::Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
    });

    ///  Subscribe to our topic, we will publish to it in the onSubscribed callback.
    print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
    client.subscribe(pubTopic, MqttQos.exactlyOnce);

    /// Publish it
    print('EXAMPLE::Publishing our topic');
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);

    /// Ok, we will now sleep a while, in this gap you will see ping request/response
    /// messages being exchanged by the keep alive mechanism.
    print('EXAMPLE::Sleeping....');
    await MqttUtilities.asyncSleep(120);

    /// Finally, unsubscribe and exit gracefully
    print('EXAMPLE::Unsubscribing');
    client.unsubscribeStringTopic(topic);

    /// Wait for the unsubscribe message from the broker if you wish.
    await MqttUtilities.asyncSleep(2);
    print('EXAMPLE::Disconnecting');
    client.disconnect();
    return 0;
  }

  /// The subscribed callback
  void onSubscribed(MqttSubscription subscription) {
    print(
        'EXAMPLE::Subscription confirmed for topic ${subscription.topic.rawTopic}');

    /// Publish to our topic if it has been subscribed
    if (subscription.topic.rawTopic == pubTopic) {
      /// Use the payload builder rather than a raw buffer
      builder.addString('Hello from mqtt5_client');
      print('EXAMPLE::Publishing our topic now we are subscribed');
      client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);
    }
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      if (topicNotified) {
        print(
            'EXAMPLE::OnDisconnected callback is solicited, topic has been notified - this is correct');
      } else {
        print(
            'EXAMPLE::OnDisconnected callback is solicited, topic has NOT been notified - this is an ERROR');
      }
    }
    exit(-1);
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  /// Pong callback
  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }
}
