from psd_tools import PSDImage
psd = PSDImage.load('nar_vector.psd')
print("file has {} layers".format(len(psd.layers)))
