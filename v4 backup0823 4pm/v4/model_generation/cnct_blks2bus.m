function cnct_blks2bus(dir, names_blk, name_bus, varargin)
%--------------------------------------------------------------------------
%------------------M-File Model Generation Block -------------------------------
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



%connect blocks to bus consts / subsystem with - out_port
   
%Example Run: cnct_blks2bus('test_mdl',{'x', 'y', 'z', 'u', 'v', 'w'}, 'bus_creator')
%Example Run: cnct_blks2bus('test_mdl', {'x', 'y', 'z', 'u', 'v', 'w'}, 'bus_creator', [1,3,5,7,10,14])
%dir = bdroot;
%names_blk = {'a', 'b', 'c', 'd', 'e', 'f'};

if ~isempty(varargin)
    pos_idx = varargin{1};
else
    pos_idx = 1:1:length(names_blk);
end


for i = 1: length(names_blk)
    
    try 
        blk_i = names_blk{i};
        
        
        input = [blk_i, '/1'];
        pos_i = pos_idx(i);
        output = [name_bus, '/', num2str(pos_i)];
        h = add_line(dir, input, output);
        name_label = blk_i;
        set_param(h, 'Name', name_label);
    catch
        disp(['Block : ', blk_i, ' not connected'])
    end
end
        

