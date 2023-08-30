function create_outport(dir, name_port, port_pos)
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

%Syntax: create_outport( model name, port name,  port position based on bus creator ports)
%Example Run: create_outport( 'test_mdl','port', 6)

num_ports_bus = port_pos;

% bus creator blocks
pos_y_1_bus = 35 ;  % 20;
pos_sys_y_div = 25 + 50; % bus ports dividend = height of block + dividend between blocks
pos_y_2_bus = 35 + (num_ports_bus- 1) * pos_sys_y_div + 70 ;  % 

%add_port
pos_x_1 = 750;
pos_x_2 = 800;
pos_y_1 = (pos_y_1_bus + pos_y_2_bus)/2 - 10;
pos_y_2 = (pos_y_1_bus + pos_y_2_bus)/2 + 10;
pos_port = [pos_x_1, pos_y_1, pos_x_2, pos_y_2];




%% Need switch, if root layer, create terminator instead of port
cur_name_port = name_port;
cur_port_path = [dir,'/', cur_name_port];
add_block('built-in/Outport', cur_port_path, 'Position', pos_port);

end