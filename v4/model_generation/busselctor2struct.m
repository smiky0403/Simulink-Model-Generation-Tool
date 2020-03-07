function  trgt = busselctor2struct (dir)

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

% This is a wild car version of busselctor2struct_wild: handling
% un_accetpable components to _name string
%Example Run: hit a bus selector
% trgt_bus = busselctor2struct (gcb)
objs = get_param(dir, 'InputSignals');
trgt = struct();
trgt = update_trgt(trgt, objs);

end


function sub_trgt = update_trgt(sub_trgt, objs)

    for i = 1: size(objs, 1)
        obj_i = objs{i};
        
        %
        if ischar(obj_i) 
            name = obj_i;
            name_wild = replc_mark(name); %Wild card here
            sub_trgt.(name_wild) = [];
        elseif iscell(obj_i) %(size(obj_i, 2) == 2)
            name = obj_i{1};
            name_wild = replc_mark(name);  %Wild card here
            sub_objs = obj_i{2};
            sub_trgt.(name_wild) = [];
            sub_trgt.(name_wild) = update_trgt(sub_trgt.(name_wild), sub_objs);
        else
             disp(3)
        end
 
    end

end

%i = 1
%name = ports{i}{1};
