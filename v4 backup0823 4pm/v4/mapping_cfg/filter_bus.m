function new_list = filter_bus(list_bus)
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

%Note: Purpose of this is to avoid replicated path name contain ---/msg/signal
%Example Run: list_MIL = filter_keepMILbus(list_bus);

 %strct_bus = busselctor2struct (gcb);
 %list_bus = iterateStruct(strct_bus);  
 
 
 % Remove Likely Original Mapping
 tokens = cellfun(@(x) strsplit(x, '.'), list_bus, 'UniformOutput', 0 );
 
 too_long = cellfun(@length, tokens) >= 5;
 
 too_short = cellfun(@length, tokens) < 3;
 
 has_protocol = ~cellfun(@isempty, regexp(list_bus, 'ToProtocols') );
 
 
 
 %% ---------- MAKE YOUR OWN CHOICE ---------------
 %new_list = list_bus( ~has_protocol & ~ too_short & ~too_long); 
 %new_list = list_bus( ~has_protocol & ~ too_short);
 new_list = list_bus( ~ too_short);
 
% Invalid Message/Signal name

  %% ---------- MAKE YOUR OWN CHOICE ---------------
end