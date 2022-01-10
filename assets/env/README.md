# HDR Environment Maps
source: [polyhaven.com/hdris](https://polyhaven.com/hdris)

## What are rgbd.png files?
When three.js loads a .hdr file, it first processes it for efficient rendering – it creates a mipchain of smaller resolutions and converts the 32-bit float data into 8-bit rgb and a scale factor in the alpha channel: [rgbd explained](https://lousodrome.net/blog/light/tag/rgbd/).

The resulting data is much smaller than the original hdr file. For faster load times I extract this data into pngs and load those instead, this saves load-time and processing-time without quality loss

You can see how to use these pngs here: [EnvironmentManager.hx](https://github.com/haxiomic/three-toolkit/blob/30a6b941beb033e28db800a0fd5a564bf1bcaa45/environment/EnvironmentManager.hx#L76)