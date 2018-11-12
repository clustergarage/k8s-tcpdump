# k8s-tcpdump

Wrapper around `tcpdump` to monitor network traffic of pods selected by label.

## Usage

```
sudo ./pod_tcpdump.sh label=value
```

## Examples

Monitor gRPC communication between [fim-k8s](https://github.com/clustergarage/fim-k8s)
daemon<-->controller.

```
sudo ./pod_tcpdump.sh daemon=fimd
```

### Example output

```
Performing 'tcpdump' on veth9b6621e
 * container: 1282bac1ce997e24ed5f83f18e932e940a2379af7b7dcab114a42b982e7a8307
 * net interface idx: 1879
 * veth interface: /sys/class/net/veth9b6621e/ifindex
tcpdump: listening on veth9b6621e, link-type EN10MB (Ethernet), capture size 2048 bytes

...

12:06:44.400718 IP (tos 0x0, ttl 64, id 53858, offset 0, flags [DF], proto TCP (6), length 317)
    172.17.0.11.47132 > 172.17.0.6.50051: Flags [P.], seq 827475042:827475307, ack 1875167098, win 237, options [nop,nop,TS val 89787680 ecr 4269612175], length 265
        0x0000:  4500 013d d262 4000 4006 0f25 ac11 000b  E..=.b@.@..%....
        0x0010:  ac11 0006 b81c c383 3152 4462 6fc4 c77a  ........1RDbo..z
        0x0020:  8018 00ed 5963 0000 0101 080a 055a 0d20  ....Yc.......Z..
        0x0030:  fe7d 1c8f 0000 0f01 0400 0000 1983 86bf  .}..............
        0x0040:  c3c2 c1c0 7e86 69f7 df7d d7ed 0000 e800  ....~.i..}......
        0x0050:  0100 0000 1900 0000 00e3 0a09 6c6f 6361  ............loca
        0x0060:  6c68 6f73 7412 0f6a 656e 6b69 6e73 2d31  lhost..jenkins-1
        0x0070:  2d77 7a39 7436 2249 646f 636b 6572 3a2f  -wz9t6"Idocker:/
        0x0080:  2f38 3239 3339 3235 3261 3337 6331 3431  /82939252a37c141
        0x0090:  6636 3265 3864 3662 3933 3435 3734 3333  f62e8d6b93457433
        0x00a0:  3661 3133 3136 3230 6233 6162 6161 3266  6a131620b3abaa2f
        0x00b0:  6133 3833 3161 6439 3662 6536 3530 3763  a3831ad96be6507c
        0x00c0:  3922 4964 6f63 6b65 723a 2f2f 6232 3538  9"Idocker://b258
        0x00d0:  6364 6461 6662 3530 3462 3263 3232 3437  cddafb504b2c2247
        0x00e0:  6434 3532 6366 3134 3930 6364 3763 3264  d452cf1490cd7c2d
        0x00f0:  3664 3137 3034 6162 6136 6466 3032 6637  6d1704aba6df02f7
        0x0100:  6239 6564 3735 3964 6161 3834 2a2f 0a15  b9ed759daa84*/..
        0x0110:  2f76 6172 2f6c 6962 2f6a 656e 6b69 6e73  /var/lib/jenkins
        0x0120:  2f6c 6f67 730a 0e2f 7661 722f 6c6f 672f  /logs../var/log/
        0x0130:  6e67 696e 7812 066d 6f64 6966 79         nginx..modify
```
