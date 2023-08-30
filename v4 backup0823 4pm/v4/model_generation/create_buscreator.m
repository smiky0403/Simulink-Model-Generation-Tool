function create_buscreator(dir, name_bus, num_ports)
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

%Example run:  create_buscreator('test_mdl', 'bus_creator', 15)

pos_x_1 = 500;
pos_x_2 = 510;
pos_y_1 = 35 ;  % 20;
pos_sys_y_div = 25 + 50; % bus ports dividend = height of block + dividend between blocks
pos_y_2 = 35 + (num_ports - 1) * pos_sys_y_div + 70 ;  % 
pos_bus = [pos_x_1, pos_y_1, pos_x_2, pos_y_2];
    
%add Bus creator
cur_name_bus = name_bus;
cur_bus_path = [dir,'/',cur_name_bus];
if num_ports > 0
    h = add_block('built-in/BusCreator', cur_bus_path,'Position',pos_bus);
    set_param(h, 'Inputs',num2str(num_ports))
else
    return
end
