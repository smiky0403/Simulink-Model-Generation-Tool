function cnnt_inport2bus(dir, name_port, name_bus, varargin)

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

%Example Run: cnnt_inport2bus('test_mdl/FD1_CAN_P702_GASD_MY21_DCV_V06', 'in_port', 'bus_selector')


try
    h = add_line(dir,  [name_port, '/1'], [name_bus, '/1']);
catch
    disp([dir, ' : Not able to connect port to bus'])
    return
end


if ~isempty(varargin)
    name_label = varargin{1};
    try
        set_param(h, 'Name', name_label);
    catch
        disp(dir)
        disp('Not able to set Label for inport coonecting to bus')
    end
else
    
end



end