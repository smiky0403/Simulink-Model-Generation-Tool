function merged_struct = mergeStructs(varargin)
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


%Varargins = {struct_a, struct_b, ....}
%Example Run: trgt_dbc = MergeStructs(trgt1, trgt2);
%%if one of the structres is empty do not merge

for i = 1:length(varargin)
    cur_struct = varargin{i};
    f = fieldnames(cur_struct);
    for j=1:length(f)
        merged_struct.(f{j}) = cur_struct.(f{j});
        
    end
end

end
