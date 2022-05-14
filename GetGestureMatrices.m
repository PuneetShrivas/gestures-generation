result = GetGoogleSpreadsheet('1m2zBMtQ5n1pnKJZ5ZDGf6NTqNyQY7dyw-C5n1Mx8jP8');
cell_A = result(3:22,2:9);
mat_A = str2double(cell_A);
cell_B = result(3:22,14:21);
mat_B = str2double(cell_B);
cell_C = result(3:22,26:33);
mat_C = str2double(cell_C);