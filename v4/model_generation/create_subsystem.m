function create_subsystem(dir, names_blk, varargin)
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
%Example Run:  create_subsystem('test_mdl', {'a', 'b', 'c', 'd', 'e','f'})
%Example Run:  create_subsystem('test_mdl', {'a', 'b', 'c', 'd', 'e','f'}, [1,3,5,7,10,14])


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


for i = 1: length(names_blk)
    input = names_blk{i};
    pos_i = pos_idx(i);
   
    if isempty( regexp(input, '/', 'match')  )
        cur_subsys_path = [dir,'/',input];
        add_block('built-in/SubSystem', cur_subsys_path, 'Position', pos_sys + ...
        [0, (pos_i - 1) * pos_sys_y_div, 0, (pos_i - 1) * pos_sys_y_div])
    else
        
         % --------Patch When name contain '/'---------------------
         % CAN NOT add block inside, to be improved further
         % Almost never beem caleed, currently most '/' are '|'
         cur_subsys_path = [dir,'/','Dummy_Slash'];
         h = add_block('built-in/SubSystem', cur_subsys_path, 'Position', pos_sys + ...
        [0, (pos_i - 1) * pos_sys_y_div, 0, (pos_i - 1) * pos_sys_y_div]);
        set_param(h, 'Name', input)
         
    end
end




