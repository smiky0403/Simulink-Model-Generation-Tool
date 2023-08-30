function create_cnst_gw(dir, names_blk, varargin)
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


%Syntax:create_subsystem(model name, block names, *block_positions)
%Example Run:  create_cnst_gw('test_mdl', {'a', 'b', 'c', 'd', 'e','f'})
%Example Run:  create_cnst_gw('test_mdl', {'a', 'b', 'c', 'd', 'e','f'}, [1,3,5,7,10,14])


% Patch, when need variant positions, e.g. have other blocks in the middle
if ~isempty(varargin)
    pos_idx = varargin{1};
else
    pos_idx = 1:1:length(names_blk);
end


pos_x_1 = 150;
pos_x_2 = 350;
pos_y_1 = 50;
pos_y_2 = 100;
pos_sys_y_div = 25 + pos_y_2 - pos_y_1; % Next block y distance to current
pos_sys = [pos_x_1, pos_y_1, pos_x_2, pos_y_2];

pos_x_5 = 750;
pos_x_6 = 800;
pos_port_out = [pos_x_5,70, pos_x_6, 90];

pos_x_7 = 0;
pos_x_8 = 50;
pos_port_in = [pos_x_7, 70, pos_x_8,90];



name_port_in = 'in';
name_port_out = 'out';

for i = 1: length(names_blk)
    
    input = names_blk{i};
    pos_i = pos_idx(i);
    cur_subsys_path = [dir,'/',input];
    add_block('built-in/SubSystem', cur_subsys_path, 'Position', pos_sys + ...
        [0, (pos_i - 1) * pos_sys_y_div, 0, (pos_i - 1) * pos_sys_y_div])    

    cur_outport_path = [cur_subsys_path,'/', name_port_out];
    add_block('built-in/Outport', cur_outport_path, 'Position', pos_port_out);

    cur_inport_path = [cur_subsys_path,'/', name_port_in];
    add_block('built-in/Inport', cur_inport_path, 'Position', pos_port_in);

    add_line(cur_subsys_path, [name_port_in, '/1'] , [name_port_out, '/1']);
end