function create_fromblks(dir, names_blk, varargin)
%--------------------------------------------------------------------------
%------------------M-File Model Generation Block -------------------------------
%--------------------------------------------------------------------------
%
%Author:
%       Mingqi Shi, mingqis qti qm
%
%Created:
%       2023-08-21
%
%Last modified:
%       Mingqi Shi
%       2023-08-21
%
%Version:
%       0.3
%
%Description:
%       See Eample Run below and Demo document
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%Syntax: create_subsystem(model name, block names, *block_positions)
%Example Run: create_fromblks('test_mdl', {'x', 'y', 'z', 'u', 'v', 'w//s'})
%Example Run: create_fromblks('test_mdl', {'x', 'y', 'z', 'u', 'v', 'w//s'}, [1,3,5,7,10,14])
%Note: Force Block name and Goto Tag  with "_goto" and "_" suffix
%Note: Tag name cant contain special character

if(ischar(names_blk))
    names_blk = {names_blk};
end

if ~isempty(varargin)
    pos_idx = varargin{1};
else
    pos_idx = 1:1:length(names_blk);
end


pos_x_1 = 150 + 100; % add 100 offset to differnete with const blks
pos_x_2 = 200 + 100;   % add 100 offset to differnete with const blks
pos_y_1 = 50;
pos_y_2 = 100;
pos_cnst_y_div = 25 + 50; % Next block y distance to current
pos_cnst = [pos_x_1, pos_y_1, pos_x_2, pos_y_2];



for i = 1: length(names_blk)
    input = names_blk{i};
    pos_i = pos_idx(i);
    
    if isempty( regexp(input, '/', 'match')  )
        cur_cnst_path = [dir,'/',input];
        add_block('built-in/From', strcat(cur_cnst_path, '_from'), ...
            'Position',  pos_cnst + ...
        [0,(pos_i - 1)* pos_cnst_y_div, 0,(pos_i - 1)* pos_cnst_y_div])
        %To be modified  later
        %set values to 0

        %set_param(cur_cnst_path, 'Value', '0');



       set_param(gcb, 'GotoTag', strcat(input, '_'))




        %set values to dbc default

    else
       % --------Patch When name contain '/'---------------------
        cur_cnst_path = [dir,'/','Dummy_Slash'];
        h = add_block('built-in/From', strcat(cur_cnst_path, '_from'), ...
            'Position',  pos_cnst + ...
        [0,(pos_i - 1)* pos_cnst_y_div, 0,(pos_i - 1)* pos_cnst_y_div]);
        set_param(h, 'Name', input)
    end

end