function [order_name_blks, valid, idx] = sort_blks (dir, varargin)

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



% Sort order of blocks based on their middle - vertical location (y1 + y2)/2
% Block is by current system or user selected
% varargin is user input block names 
%Example Run:   [order_names, ~, ~] = sort_blks (gcs)
%Example Run:   [order_names, valid, idx] = sort_blks ('test_mdl_gw/ABS_AutoSar_NetworkMgt', {'c', 'ABS_GWNMProxy', 'ABS_GWOnBoardTester', 'ABS_AutoSarNMControl'})
%Example Run:   [order_names, valid, idx] = sort_blks ('test_mdl_gw/ABS_AutoSar_NetworkMgt', {'c','d' 'ABS_GWNMProxy', 'ABS_AutoSarNMControl', 'bus_creator'})
 % Note: valid shows validity of output not input

 
if isempty(varargin)
    name_blks = get_param(dir, 'Blocks');
else
    if ischar(varargin{1})  
        name_blks = {varargin{1}};  %To be improve for tokens such as 'a, b, c'
    else  %cell format, by default
        name_blks = varargin{1};
    end
end


types = {'SubSystem', 'Constant', 'Terminator', 'NIVeriStand In1', 'NIVeriStand Out1', 'Goto', 'From'}; 
exist_blks = get_param(dir, 'Blocks');
name_blks_dbl = regexprep(name_blks, '/', '//'); %Patch for '/'
path_blks = strcat(dir, '/', name_blks_dbl);

pos_blks_ymean = NaN(length(path_blks), 1);
valid = false(length(path_blks), 1);

for i = 1: length(pos_blks_ymean)
    
    
    valid_exist = ismember(name_blks{i}, exist_blks);
    if ~valid_exist
        disp([ '''', name_blks{i}, '''', ' does not exist in current directory' ] )
        continue
    end
    type_blk = get_param(path_blks{i}, 'BlockType');
    valid_type = ismember(type_blk, types);

    
    if ~valid_type
        continue
    end 
    
    valid(i) = true;
    
    pos_blk_i = get_param(path_blks{i}, 'Position');
    pos_blks_ymean_i = ( pos_blk_i(2) + pos_blk_i(4))/2;
    pos_blks_ymean(i) = pos_blks_ymean_i;

end


[~, idx] = sort(pos_blks_ymean);
order_name_blks = name_blks(idx);
valid = valid(idx);

   
   
   