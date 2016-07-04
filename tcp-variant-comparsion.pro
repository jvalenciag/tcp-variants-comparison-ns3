TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp \
    tcp-cubic.cc \
    udp-tcp.cc

INCLUDEPATH += /home/josev/workspace/mestrado/redes/build/include/ns3.24.1
LIBS += -L/home/josev/workspace/mestrado/redes/build/lib
LIBS += -lns3.24.1-core-debug -lns3.24.1-network-debug -lns3.24.1-internet-debug \
        -lns3.24.1-point-to-point-debug -lns3.24.1-applications-debug \
        -lns3.24.1-stats-debug -lns3.24.1-bridge-debug -lns3.24.1-mpi-debug \
        -lns3.24.1-flow-monitor-debug

#-lns3.24.1-traffic-control-debug
#-lapplication

HEADERS += \
    tcp-cubic.h

