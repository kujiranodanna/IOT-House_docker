# IOT-House_docker
- [IOT-House_docker](https://github.com/kujiranodanna/IOT-House_docker) is a reconstruction of [IOT-House_old_pc](https://github.com/kujiranodanna/IOT-House_old_pc) based on amd64/ubuntu:24.04 amd64/ubuntu:22.04 or i386/ubuntu18.04. Ver:0.13 2025.4.9

- Requires docker privilege mode to use gpio's CP2112(Silicon Laboratories Single-Chip HID USB to SMBus Master Bridg)[Sunhayato MM-CP2112](https://amzn.to/3MhbeOd).
- Wireless GPIO[mono wireless TWELITE and MONOSTICK](https://amzn.to/3YYzDj4)
- Execute as follows.<br>
  docker run -itd --privileged --name iot-house_docker --device=/dev/ttyUSB0:/dev/ttyUSBTWE-Lite -p 8022:22 -p 80:80 -p 443:443 kujiranodanna/iot-house_docker:latest
- The Docker engine can only run on Linux. Windows and Mac won't work.
- It also works on Windows Docker Desktop, but it takes some time, but it's still a great challenge to be able to operate USB-connected devices directly from a container.
  --> As of August 10, 2024, operation has been confirmed on Windows 11.

  - Install the latest PowerShell 7.4.4 or later and usbipd-win_x.msi.

  - Then you need to bind and attach the USB device.
```
into PowerShell
PowerShell 7.4.4
usbipd list    
Connected:
BUSID  VID:PID    DEVICE                                                        STATE
.
2-1    10c4:ea90  USB input devices <-- cp2112                                  Not shared
2-2    0403:6001  USB Serial Converter <-- TWELITE                              Not shared
.
usbipd bind --busid 2-1
usbipd bind --busid 2-2
usbipd attach --wsl --busid 2-1
usbipd attach --wsl --busid 2-2
.
usbipd list    
connected:
BUSID  VID:PID    DEVICE                                                        STATE
.
2-1    10c4:ea90  USB input devices                                           Attached
2-2    0403:6001  USB Serial Converter                                        Attached
.
docker run -itd --privileged --name iot-house_docker --device=/dev/ttyUSB0:/dev/ttyUSBTWE-Lite -p 8022:22 -p 80:80 -p 443:443 kujiranodanna/iot-house_docker:latest
If you don't have TWELITE, follow the steps below
docker run -itd --privileged --name iot-house_docker -p 8022:22 -p 80:80 -p 443:443 kujiranodanna/iot-house_docker:ubuntu22.04-latest
```
- By the way, in the case of Windows, it can be started without a devices.
This allows you to remotely control the Raspberry Pis at IOT House, and is also useful when using voice commands and responses.Execute as follows.<br>
  docker run -itd --privileged --name iot-house_docker -p 8022:22 -p 80:80 -p 443:443 kujiranodanna/iot-house_docker:latest
- Before building the image, copy the contents of amd64_bin/* or i386_bin/* to the app-src/bin/ directory according to your environment.
- Related articles Related articles<br>
How about using Docker Desktop for Windows for your summer vacation research project?<br>
  https://www.youtube.com/shorts/8S-WZ3UvIUA<br>
  https://iot-house.jpn.org/wp/2024/08/10/%e5%a4%8f%e4%bc%91%e3%81%bf%e3%81%ae%e8%87%aa%e7%94%b1%e7%a0%94%e7%a9%b6%e3%81%abdocker%e3%81%af%e3%81%84%e3%81%8b%e3%81%8c%e3%80%80%e3%81%9d%e3%81%ae%ef%bc%91/
- https://hub.docker.com/r/kujiranodanna/iot-house_docker<img width="986" alt="sshot_iot-house_docker" src="https://user-images.githubusercontent.com/70492305/143548255-1ff3dd03-4130-466d-8f81-b4f95b112208.png">
