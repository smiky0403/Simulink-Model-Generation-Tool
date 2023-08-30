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

%Syntax: cnct_blks2bus(dir,names of blocks, dst block, *port, *label)
%Varargin 1: port number in vector, if desire port num sequence not 1:end
%Varargin 2:  
%Example Run: cnct_blks2bus('test_mdl',{'x', 'y', 'z', 'u', 'v', 'w'}, 'bus_creator')
%Example Run: cnct_blks2bus('test_mdl', {'x', 'y', 'z', 'u', 'v', 'w'}, 'bus_creator', [1,3,5,7,10,14])
%Example Run: cnct_blks2bus('test_mdl', {'x', 'y', 'z', 'u', 'v', 'w'}, ...
%'bus_creator', [1,3,5,7,10,14], {'x1', 'y2', 'z3', 'u4', 'v5', 'w6'} )
%dir = bdroot;
%names_blk = {'a', 'b', 'c', 'd', 'e', 'f'};


if(ischar(names_blk))
    names_blk = {names_blk};
end

if ~isempty(varargin)
    pos_idx = varargin{1};
else
    pos_idx = 1:1:length(names_blk);
end

if nargin >= 5  %i.e varagin =2,  port position  and  labels desired
    if(ischar(varargin{2} ))
        desired_names_labels = {varargin{2}  };
    else
        desired_names_labels = varargin{2} ; %cell type
    end
end

for i = 1: length(names_blk)
    
    try 
        blk_i = names_blk{i};
        
        input = [blk_i, '/1'];
        pos_i = pos_idx(i);
        output = [name_bus, '/', num2str(pos_i)];
        h = add_line(dir, input, output);

        name_label = blk_i;
        if nargin >= 4
            100
           set_param(h, 'Name', desired_names_labels{i});
        else
            200
            set_param(h, 'Name', name_label);  %default label = input block name
        end

    catch
        disp(['Block : ', blk_i, ' not connected'])
    end
end
        

