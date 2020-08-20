import CoreWLAN

var networks: Set<CWNetwork> = []

if let interface = CWWiFiClient.shared().interface() {
    print("Working with interface \(interface.interfaceName ?? "?")")
    do {
        networks = try interface.scanForNetworks(withSSID: nil)
        let arguments = CommandLine.arguments
        if arguments.count != 3 {
            print("Specify a WIFI network to connect to, from:")
            for network in networks {
                print("  \(network.ssid!)")
            }
            exit(1)
        }

        for network in networks {
            if network.ssid! == arguments[1] {
                print("Switching WIFI to \(network.ssid!)")
                try interface.associate(to: network, password: arguments[2])
            }
        }
    } catch {
        print(error.localizedDescription)
    }
}
