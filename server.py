from twisted.internet import reactor
from twisted.internet.protocol import Factory, Protocol
 
class IphoneChat(Protocol):
    def connectionMade(self):
        self.factory.clients.append(self)
        print "Clients are ", self.factory.clients

    def connectionLost(self, reason):
        self.factory.clients.remove(self)
    
    def dataReceived(self, data):
        a = data.split(':')
        print a
        if len(a) > 1:
            commond = a[0]
            content = a[1]

        msg = ""
        if commond == "iam":
            self.name = content
            msg = self.name + "has joined" 

        elif commond == "msg":
            msg = self.name + ": "  + content
            print msg

        for c in self.factory.clients:
            c.message(msg)

    def message(self, message):
        self.transport.write(message + '\n')


factory = Factory()
factory.clients = []
name = ""
factory.protocol = IphoneChat
reactor.listenTCP(80, factory)
print "Iphone chat server started"

reactor.run()

