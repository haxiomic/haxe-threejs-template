package objects;

import three.Float32BufferAttribute;
import three.BufferAttribute;
import js.lib.Uint32Array;
import js.lib.Float32Array;
import three.BufferGeometry;

/**
	- Faster initialization than three.js plane
	- Doesn't use per-vertex normals – these should be set with vertexAttrib3f
**/
class XZPlaneBufferGeometry extends BufferGeometry {

	public function new(width: Float, height: Float, widthSegments: Int, heightSegments: Int) {
		super();
		var indexCount = widthSegments * heightSegments * 2 * 3; // 2 triangles per cell, 3 indices per triangle
		var vertexCount = (widthSegments + 1) * (heightSegments + 1);
		var wSpacing = width / widthSegments;
		var hSpacing = height / heightSegments;

		var vertices = new Float32Array(3 * vertexCount);
		var uvs = new Float32Array(2 * vertexCount);

		inline function vertexIndex(column, row) return row * (widthSegments + 1) + column;

		for (vertexRow in 0...(heightSegments + 1)) {
			for (vertexColumn in 0...(widthSegments + 1)) {
				var i = vertexIndex(vertexColumn, vertexRow);
				
				var vi = i * 3;
				vertices[vi + 0] = wSpacing * vertexColumn - width * 0.5;
				vertices[vi + 1] = 0;
				vertices[vi + 2] = hSpacing * vertexRow - height * 0.5;

				var ui = i * 2;
				uvs[ui + 0] = vertexColumn / widthSegments;
				uvs[ui + 1] = vertexRow / widthSegments;
			}
		}

		var indices = new Uint32Array(indexCount);
		var indexOffset = 0;
		for (vertexRow in 0...(heightSegments)) {
			for (vertexColumn in 0...(widthSegments)) {
				var tl = vertexIndex(vertexColumn, vertexRow);
				var tr = vertexIndex(vertexColumn + 1, vertexRow);
				var bl = vertexIndex(vertexColumn, vertexRow + 1);
				var br = vertexIndex(vertexColumn + 1, vertexRow + 1);

				var i = indexOffset;
				indices[i + 0] = tl;
				indices[i + 1] = bl;
				indices[i + 2] = br;
				
				indices[i + 3] = tl;
				indices[i + 4] = br;
				indices[i + 5] = tr;

				indexOffset += 6;
			}
		}

		this.setIndex(new BufferAttribute(indices, 1));
		this.setAttribute( 'position', new Float32BufferAttribute(vertices, 3) );
		// normal set by material
		// this.setAttribute( 'normal', new Float32BufferAttribute( normals, 3 ) );
		this.setAttribute( 'uv', new Float32BufferAttribute(uvs, 2) );
	}

}