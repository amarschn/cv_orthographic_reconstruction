import ezdxf
import csv
import sys

'''
Turn dxf file into csv file of vertices
'''
def dxf2csv(file_name):

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




if __name__ == '__main__':
	if len(sys.argv) != 2:
		sys.exit("Need one argument: input file")
	dxf2csv(sys.argv[1])
