package tool;

import three.Color;
import three.Mesh;
import three.MeshStandardMaterial;
import three.Object3D;
import three.SphereGeometry;

#if (three >= "0.133.0")
private typedef Object3D = three.Object3D<three.Event>;
#end

class LightingDebugProbes extends Object3D {

	public function new() {
		super();
		var probeGeom = new SphereGeometry(1, 20, 20);
		var nProbes = 4;
		var width = 2;
		for ( i in 0...nProbes) {
			for (j in 0...nProbes) {
				for (k in 0...nProbes) {
					var u = nProbes == 1 ? 0 : i / (nProbes - 1);
					var v = nProbes == 1 ? 0 : j / (nProbes - 1);
					var w = nProbes == 1 ? 0 : k / (nProbes - 1);
					var probeMat = new MeshStandardMaterial({
						color: new Color(Math.pow(u, 2.2), Math.pow(u, 2.2), Math.pow(u, 2.2)),
						metalness: w,
						roughness: v,
						fog: true,
						blending: NoBlending,
					});
					var probe = new Mesh(probeGeom, probeMat);
					probe.layers.enable(DepthPrepass);
					probe.scale.setScalar(0.1);
					probe.position.x = u * width - width * 0.5;
					probe.position.y = v * width - width * 0.5;
					probe.position.z = w * width - width * 0.5;
					this.add(probe);
				}
			}
		}
	}
	
}