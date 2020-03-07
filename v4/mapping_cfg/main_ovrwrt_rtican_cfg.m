function main_ovrwrt_rtican_cfg(varargin)

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


%Logic: In model: take select bus selector or its generate structure > from it: over write the configuration file of rticanmm
%Example Run: main_ovrwrt_rtican_cfg(strct_bus);
%Example Run: main_ovrwrt_rtican_cfg();  %Make sure pre-select bus selector

addpath(genpath(pwd))
    
if isempty(varargin)
    
    bus_trgt = busselctor2struct (gcb);
    
elseif isstruct(varargin{1})
    
    bus_trgt = varargin{1};
    
elseif ischar(varargin{1})
      
       path_bus = varargin{1};
       bus_trgt = busselctor2struct (path_bus);
    
end


file_in = uigetfile( pwd, '*.m');

texts = readfile2cell (file_in);

new_texts = ovrwrt_rtican_cfg(texts, bus_trgt);

file_out = uiputfile('*.m');

writecell2file(file_out, new_texts);
 

end