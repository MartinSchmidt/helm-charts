# services-ntp

This service is responsible for synchronisation of the system clock on the nodes. Under the hood it uses [`chrony`](https://chrony.tuxfamily.org/index.html) as server and client.

## Diagram
```
                       +---------------------+
                       | pool.ntp.org        |
                       |                     |
                       | pool of NTP servers |
                       +----------^----------+
                                  |
                      +-----------+-----------+
                      |                       |
           +----------+----------+ +----------+----------+
           | Pod from Deployment | | Pod from Deployment |
           |                     | |                     |
           | chrony NTP server   | | chrony NTP server   |
           +---------^-----------+ +---------^-----------+
                     |                       |
                     |                       |
          +----------+-----------+-----------+----------+
          |                      |                      |
          |                      |                      |
+---------+----------+ +---------+----------+ +---------+----------+
| Pod from DaemonSet | | Pod from DaemonSet | | Pod from DaemonSet |
|                    | |                    | |                    |
| chrony NTP client  | | chrony NTP client  | | chrony NTP client  |
+--------------------+ +--------------------+ +--------------------+
```

The DaemonSet runs the NTP client on every node and they are in charge of synchronizing the system clock. The Deployment runs the NTP servers and they use the NTP servers from the [pool.ntp.org project](https://www.ntppool.org) if possible, if not they run in [local](https://chrony.tuxfamily.org/doc/4.0/chrony.conf.html#local) mode.

## Links

The configuration format for `chrony.conf` is documented [here](https://chrony.tuxfamily.org/doc/4.0/chrony.conf.html).
