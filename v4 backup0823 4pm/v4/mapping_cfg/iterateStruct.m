function output = iterateStruct(trgt, varargin)
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


% trgt i structure; cur_line is in str format;  output in cell format, n * 1 dimension
% Alway leave second input empty; it's for internal loop only
%Example run : list_bus = iterateStruct(strct_bus);   
names = fieldnames(trgt); 
output = {};

for i = 1 : length(names)
    name = names{i};
    if isempty(varargin)
        cur_sub_line = name;
    else
        cur_line = varargin{1};
        cur_sub_line = [cur_line, '.', name];
    end
    
    if isstruct(trgt.(name))
        sub_trgt = trgt.(name);
        output_cur_name = iterateStruct(sub_trgt, cur_sub_line);
        output = cat(1,output, output_cur_name);
    else
        output = cat(1, output, {cur_sub_line}); %Place here to include only-top-tree 
    end
        %output = cat(1, output, {cur_sub_line});  %Place here to include all root
end



