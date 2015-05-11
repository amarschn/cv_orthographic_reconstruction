References:
===========

https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CB4QFjAA&url=http%3A%2F%2Fwww.researchgate.net%2Fprofile%2FRocco_Furferi%2Fpublication%2F45601976_From_2D_Orthographic_views_to_3D_Pseudo-Wireframe_An_Automatic_Procedure%2Flinks%2F02e7e514ae48d8890a000000.pdf&ei=tmcdVYiFEcWjgwTn0IGYAg&usg=AFQjCNE5g8JoU-vTqPaLzGqURg3KzLGUlQ&sig2=ZoiChV8erS6avR_Za9U5jg&bvm=bv.89744112,d.eXY

http://ieeexplore.ieee.org/xpl/articleDetails.jsp?arnumber=4271722

http://cgcad.thss.tsinghua.edu.cn/shixia/publications/matrixreconstruction/paper.pdf

Difference between paper:


Problems:
=========
- What about parts with "floating" features that do not fit within connected components algorithm? Would need user input to determine parts
- Use PNGs as well as DXFs
- Set the size of the object based on user input (i.e. ask for dimension of single line)


Ideas:
======

Get pseudo wireframe of test part.

- get csv of all vertices
- get csv of all edges

Create a few more parts to do tests on.
Fin?