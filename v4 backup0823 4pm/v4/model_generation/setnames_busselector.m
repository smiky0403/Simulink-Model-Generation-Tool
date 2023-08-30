function setnames_busselector(dir, name_bus, varargin)
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




%Example Run: setnames_busselector('test_mdl/FD1_CAN_P702_GASD_MY21_DCV_V06', 'bus_selector')
%Example Run: setnames_busselector(gcs, 'bus_selector', {'a', 'c', 'e', 'f'})

try
    h = get_param([dir, '/', name_bus] , 'Handle');
catch
    return  % no bus selector with this name at all
end

if isempty(varargin)
    names_blk = get(h, 'InputSignals');  
else
    names_blk = varargin{1};  
end


names_blk_expr = strjoin( names_blk, ',');

if ~isempty(names_blk_expr)
    set(h, 'OutputSignals', names_blk_expr)
else
    set(h, 'OutputSignals', 'dummy')
end


end