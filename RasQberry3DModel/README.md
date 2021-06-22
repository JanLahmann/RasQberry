## 3D model
An enclosure (3D model) of the IBM Q System One can be used for RasQberry. STL files are available at https://github.com/JanLahmann/RasQberry_enclosure (original source: https://github.com/BAndiT1983/RasQberry_enclosure). This is based on an idea of Andy Stanford-Clark (https://github.com/andysc/IBM-Q-System-One-3D-model). Additional instructions for assembling the enclosure and all components (Raspberry Pi, 4'' touchscreen display, battery pack inside the enclosure, etc) will be provided later.

![](../Artwork/RasQberry-3D-Model.png)

[![](http://img.youtube.com/vi/QkLW0Yw_pmg/0.jpg)](http://www.youtube.com/watch?v=QkLW0Yw_pmg "RasQberry 3D model draft")

## Bil of Material
We will provide a more detailed BOM later. The following list should help to get you started:
1. 3D Model: see the above description and STL files. The 3D model is optional and not required for running Qiskit on the Raspberry Pi.
1. Raspberry Pi: we recommend a [model 4](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/). For the currently existing demos, 2 GB RAM are sufficient. The Qiskit install procedure has also been tested sucesfully on a model Zero (precisely a model "Zero WH" for WLAN and GPIO connectivity), but a model 4 is much more responsive.
1. Micro SD card with at least 8GB. We recommend 16 GB.
1. Touch display. The following touch screen fits exactly into backplane of the current 3D model: [Miuzei Raspberry Pi 4 Touchscreen, 4 inch](http://www.miuzeipro.com/product/miuzei-raspberry-pi-4-touch-screen-with-case-fan-4-inch-ips-full-angle-game-display-800x480-pixel-support-hdmi-input-with-touch-pen-4-pcs-heatsinks-support-raspbian-kali-by-miuzei/). We plan to provide more flexibility in the future to support other types as well.
1. As an alternative to the touch screen, some of our demos can (only) be used with a [SenseHAT](https://www.raspberrypi.org/products/sense-hat/). The "closed backplane" of the 3D model can be modified to nicely fit the SenseHAT.
1. Some additional cables to connect the components, a power supply (optionally a battery pack that fits inside the 3D model), acrylic glass, LED ring, etc are needed for a complete model.

