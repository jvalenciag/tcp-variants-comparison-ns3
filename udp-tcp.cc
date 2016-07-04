/*
#include <iostream>
#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/internet-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/netanim-module.h"
#include "ns3/applications-module.h"
#include "ns3/point-to-point-layout-module.h"
#include "ns3/ipv4-static-routing-helper.h"
#include "ns3/ipv4-list-routing-helper.h"
#include "ns3/flow-monitor.h"
#include "ns3/flow-monitor-helper.h"
#include "ns3/flow-monitor-module.h"

#include "ns3/drop-tail-queue.h"

using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("TCP-UDP-CM");

int main (int argc, char *argv[])
{
    Config::SetDefault ("ns3::OnOffApplication::PacketSize", UintegerValue
    (512));
    Config::SetDefault ("ns3::OnOffApplication::DataRate", StringValue
    ("1Mb/s"));

    ns3::PacketMetadata::Enable();
    std::string animFile = "Lab5-Anim.xml";

    std::string AC_BW ("10Mbps");
    std::string AC_Delay ("10ms");
    CommandLine cmd;
    cmd.AddValue ("AC_BW", "A-C Link Bandwidth", AC_BW);
    cmd.AddValue ("AC_Delay", "A-C Link Delay", AC_Delay);

    std::string tcpCong = "cubic";

    PointToPointHelper p2p;

    p2p.SetDeviceAttribute ("DataRate", StringValue ("BW_AC"));
    p2p.SetChannelAttribute ("Delay", StringValue ("DELAY_AC"));
    p2p.SetQueue ("ns3::DropTailQueue","MaxPackets", UintegerValue(140));

    NetDeviceContainer dAC = p2p.Install();

    InternetStackHelper internet;
    internet.Install (nodes);
    Ipv4AddressHelper ipv4;
    ipv4.SetBase ("10.1.1.0", "255.255.255.0");
    Ipv4InterfaceContainer iAC = ipv4.Assign (dAC);

    Ipv4GlobalRoutingHelper::PopulateRoutingTables ();

    uint16_t TCPport = 8080;
    uint16_t UDPport = 9;
    NodeContainer E = NodeContainer (nodes.Get (4));
    NodeContainer F = NodeContainer (nodes.Get (5));
    ApplicationContainer App;

    PacketSinkHelper TCPsink ("ns3::TcpSocketFactory", InetSocketAddress
    (Ipv4Address::GetAny (), TCPport));
    PacketSinkHelper UDPsink ("ns3::UdpSocketFactory", InetSocketAddress
    (Ipv4Address::GetAny (), UDPport));

    AplicationContainer App = UDPsink.Install (nodes.Get (4));
    App.Start (Seconds (0.0));
    App.Stop (Seconds (60.0));

    Address E_Address(InetSocketAddress(iBE.GetAddress (1), UDPport));

    OnOffHelper UDPsource ("ns3::UdpSocketFactory", E_Address);
    UDPsource.SetAttribute("OnTime", RandomVariableValue (ConstantVariable
    (1)));
    UDPsource.SetAttribute("OffTime", RandomVariableValue(ConstantVariable
    (0)));
    App = UDPsource.Install(nodes.Get(2));//Node C
    App.Start (Seconds (1.0));
    App.Stop (Seconds (60.0));


    App = TCPsink.Install (F); // Install sink app on node F
    App.Start (Seconds (0.0));
    App.Stop (Seconds (60.0));

    Address F_Address(InetSocketAddress(iBF.GetAddress (1), TCPport));

    OnOffHelper TCPsource ("ns3::TcpSocketFactory", F_Address);
    TCPsource.SetAttribute ("OnTime", RandomVariableValue
    (ConstantVariable (1)));
    TCPsource.SetAttribute ("OffTime", RandomVariableValue
    (ConstantVariable (0)));
    App = TCPsource.Install(nodes.Get(3));//Node D
    App.Start (Seconds (1.0));
    App.Stop (Seconds (60.0));

    AnimationInterface anim (animFile);
    Ptr<Node> n = nodes.Get (0);
    anim.SetConstantPosition (n, 200, 200);
    n = nodes.Get (1);
    anim.SetConstantPosition (n, 300, 200);
    n = nodes.Get (2);
    anim.SetConstantPosition (n, 100, 100);

    n = nodes.Get (3);
    anim.SetConstantPosition (n, 100, 300);
    n = nodes.Get (4);
    anim.SetConstantPosition (n, 400, 100);
    n = nodes.Get (5);
    anim.SetConstantPosition (n, 400, 300);

    AsciiTraceHelper ascii;
    p2p.EnableAsciiAll (ascii.CreateFileStream ("Lab5.tr"));

    std::cout << "Running the simulation" << std::endl;
    Simulator::Run ();
    std::cout << "Destroying the simulation" << std::endl;
    Simulator::Destroy ();
    return 0;

}
*/
