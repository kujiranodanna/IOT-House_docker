# IOT-House_docker
- [IOT-House_docker](https://github.com/kujiranodanna/IOT-House_docker) is a reconstruction of [IOT-House_old_pc](https://github.com/kujiranodanna/IOT-House_old_pc) based on amd64/ubuntu:20.04 or i386/ubuntu18.04. 
- Requires docker privilege mode to use gpio's [Sunhayato MM-CP2122A](https://www.sunhayato.co.jp/material2/ett09/item_1083).
- Execute as follows.<br>
  docker run -itd --privileged --name iot-house_docker --device=/dev/ttyUSB0:/dev/ttyUSBTWE-Lite -p 8022:22 -p 80:80 -p 443:443 kujiranodanna/iot-house_docker:latest
- The Docker engine can only run on Linux. Windows and Mac won't work.
- Before building the image, copy the contents of amd64_bin/* or i386_bin/* to the app-src/bin/ directory according to your environment.
- https://hub.docker.com/r/kujiranodanna/iot-house_docker<img width="986" alt="sshot_iot-house_docker" src="https://user-images.githubusercontent.com/70492305/143548255-1ff3dd03-4130-466d-8f81-b4f95b112208.png">
