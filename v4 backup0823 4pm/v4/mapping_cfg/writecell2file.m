function writecell2file(file_name, input_cell) 
%--------------------------------------------------------------------------
%------------------M-File CAN Mapping Script Block --------------------------
%--------------------------------------------------------------------------
%
%Author:
%       Mingqi Shi, mshi15
%
%Created:
%       2019-08-21
%
%Last modified:
%       Mingqi Shi
%       2019-08-21
%
%Version:
%       0.3
%
%Description:
%       See Eample Run below and Demo document
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


%Example Run: writecell2file('test_write_01.m', texts) 
%file_name = 'test_write_01.m';
%writecell2file('testMapping_NI.m', texts_NI) 
fid=fopen(file_name, 'w');


n = length(input_cell);  % give large enough number - # of lines

for i = 1 : n
    
 % cell{i}
  fprintf(fid, [input_cell{i}, '\n']);
  
 end

fclose(fid);
