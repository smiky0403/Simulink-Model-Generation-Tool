%connect blocks to bus
function cnct_bus2port(dir, names_bus, names_port, varargin)

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



%Example Run: cnct_bus2port(dir,'Bus_1', 'port')
%Example Run: cnct_bus2port(dir,'Bus_1', 'port', 'abc')

if ~isempty(varargin)
    name_label = varargin{1}; 
else
    name_label = names_bus;  
end

   h = add_line(dir, [names_bus, '/1'],  [names_port, '/1']);
   set_param(h, 'Name', name_label);
   
 
end
