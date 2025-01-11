# This script exports a SCALED DENSE depth map, after MESH stage has been completed, and a scale has been entered.
# If no scale is entered, depth maps have relative scale.
# Exported depth maps are the same size as the original images in the chunk, but compressed. This level of compression does not affect the accuracy needed for color correciton.
# Derya Akkaynak

import Metashape
import sys
import os

# Output path is read from 'Arguments' Dialogue in Metashape
path = sys.argv[1]

# Select active chunk
chunk = Metashape.app.document.chunk 

# Is the model scaled? If not assign scale of 1
if chunk.transform.scale is None:
    scale = 1
else:
	scale = chunk.transform.scale
		
# Export depth maps for all aligned cameras in chunk		
for camera in chunk.cameras:
	# First check if the camera is aligned
	if camera.transform:
		depth = chunk.model.renderDepth(camera.transform, camera.sensor.calibration)
		depth = depth * scale
		depth = depth.convert(" ","F16")
		compr = Metashape.ImageCompression()
		compr.tiff_compression = Metashape.ImageCompression().TiffCompressionDeflate

		depth.save(path + os.sep + camera.label + ".tif", compression = compr)