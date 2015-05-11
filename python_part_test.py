

# import dxfgrabber

# dxf = dxfgrabber.readfile("test_part.dxf")

# print("DXF version: {}".format(dxf.dxfversion))
# header_var_count = len(dxf.header)
# layer_count = len(dxf.layers)
# block_definition_count = len(dxf.blocks)
# entity_count = len(dxf.entities)
# print "Header Variable Count: ", header_var_count
# print "Layer Count: ", layer_count
# print "Block Definition Count: ", block_definition_count
# print "Entity Count: ", entity_count

# print "\nEntity Info:"
# for e in dxf.entities:
# 	for p in e.points:
# 		print p[0]
# from OCC.Display.SimpleGui import init_display
# from OCC.BRepPrimAPI import BRepPrimAPI_MakeBox
 
# display, start_display, add_menu, add_function_to_menu = init_display()
# my_box = BRepPrimAPI_MakeBox(10., 10., 10.).Shape()
 
# display.DisplayShape(my_box, update=True)
# start_display()




import ezdxf
import csv

file_name = "example_part_top";

with open(file_name + '.csv', 'wb') as csvfile:
	# Create csv writer using commas as delimiter
	writer = csv.writer(csvfile, delimiter=',')

	# Put all start and end points of lines into csv file
	dwg = ezdxf.readfile(file_name + '.dxf')
	for entity in dwg.entities:
		if entity.dxftype() == 'LINE':
			print entity.dxf.start
			print entity.dxf.end
			print "\n"
			row = [entity.dxf.start[0], entity.dxf.start[1], entity.dxf.start[2],
				   entity.dxf.end[0], entity.dxf.end[1], entity.dxf.end[2]]
			writer.writerow(row)
		# if e.dxftype() == 'POLYLINE':
		# 	points = e.points()
		# 	for p in points:
		# 		print p

