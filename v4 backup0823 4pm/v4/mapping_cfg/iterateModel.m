function output = iterateModel(dir, varargin)

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


%Function iterate through model and get paths of chosen type blocks
%varargin{1} - type to iterate / varargin{1} - include comment block or not
%Example Run: iterate_model = iiterateModel(gcs);  
%Example Run: list_model = iterateModel(gcs, 'all');  
%Example Run: list_model = iterateModel(gcs, 'cnst');  
%Example Run: list_model_NI = iterateModel(gcs, 'term');
%Example Run: list_model_NI = iterateModel(gcs, 'NI output');
%Example Run: list_model_NI = iterateModel(gcs, 'NI output', 'On');
%Example Run: list_model_NI = iterateModel(gcs, 'all', '1');

if ~isempty(varargin)
    type_itr = varargin{1};  % Constant, 'NI', 'SubSystem' , 'BusSelector','Terminator' etc.
    
else
    type_itr = 'all';
end


if length(varargin) == 2
    comment_opt = varargin{2};
    comment_opt = regexprep(comment_opt, ' ', '');
    comment_opt = regexprep(comment_opt, '_', '');
    comment_opt = lower(comment_opt);
    if ismember(comment_opt, {'on', 'comment', 'commenton', '1', 'enable', 'EN', 'y', 'yes'})
        include_commend = 1;
    else
        include_commend = 0;
    end
else
    include_commend = 0;
end


%names = fieldnames(trgt);
names_child = get_param(dir, 'Blocks');
names_child_dbl = regexprep(names_child, '/', '//');  %Patch for block name contain '/'
paths_child = strcat(dir, '/', names_child_dbl);

types_child = get_param(paths_child, 'BlockType');

idx_all = 1:1:length(names_child);
idx_subsystem = idx_all(strcmp(types_child, 'SubSystem'));

%get_param(path_child,'commented')
if include_commend
    idx_comment = [];
else
    [~, idx_comment] = get_comment_blks(dir);
    idx_comment = idx_all(idx_comment);
end 


%-------------------------------------------------------------
type_itr = regexprep(type_itr, 'input', 'in');
type_itr = regexprep(type_itr, 'output', 'out');
type_itr = regexprep(type_itr, ' ', '');
type_itr = regexprep(type_itr, '_', '');

switch lower(type_itr)
    case {'term', 't', 'terminator'}   
        idx_types_itr = idx_all(strcmp(types_child, 'Terminator'));
    case {'constant', 'cnst', 'constants'}   
        idx_types_itr = idx_all(strcmp(types_child, 'Constant'));
    case {'subsystem','subsystems','subsys'} % Note: Siwtch down the line to out-put cell
        idx_types_itr = idx_all(strcmp(types_child, 'SubSystem'));  
    case 'niin'     
        idx_types_itr = idx_all(strcmp(types_child, 'NIVeriStand In1'));
    case 'niout'       
        idx_types_itr = idx_all(strcmp(types_child, 'NIVeriStand Out1'));
    case {'ni', 'nationalinstrument'}
        idx_types_itr = idx_all(strcmp(types_child, 'NIVeriStand In1') | ...
            strcmp(types_child, 'NIVeriStand Out1'));
    case { 'busselectors','busselector', 'busin'}  
        idx_types_itr = idx_all(strcmp(types_child, 'BusSelector'));
    case { 'buscreators', 'buscreator', 'busout'}
        idx_types_itr = idx_all(strcmp(types_child, 'BusCreator'));
    case {'bus', 'buses'}
        idx_types_itr = idx_all(strcmp(types_child, 'BusSelector') | ...
            strcmp(types_child, 'BusCreator'));
    case {'inports','inport', 'in'}
        idx_types_itr = idx_all(strcmp(types_child, 'Inport' ));
    case {'outports','outport', 'out'}
        idx_types_itr = idx_all(strcmp(types_child, 'Outport'));
    case {'ports', 'port'}
        idx_types_itr = idx_all(strcmp(types_child, 'Inport' ) | ...
           strcmp(types_child, 'Outport' ) );
    case 'all'
        idx_types_itr = idx_all;
    otherwise
        disp('Please select proper block types to iterate, currently select all')
        idx_types_itr = idx_all;   
end

%-------------------------------------------------------------

output = {};

for i = 1 : length(names_child)
    
    name = names_child_dbl{i};  % Patch for blocks contains '/'
    if length(varargin) < 2
        cur_sub_line = name;
    else
        cur_line = varargin{2};
        cur_sub_line = [cur_line, '/', name];
    end
    
    if ismember(i, idx_comment)
        continue
    end
    
    if ~ismember(i, idx_types_itr) && ~ismember(i, idx_subsystem)
        continue
    end
    
    if ismember(i, idx_subsystem)
        sub_dir = strcat(dir, '/', name);
        output_cur_name = iterateModel(sub_dir, type_itr, sub_dir); 
        
        if ~isempty(output_cur_name)
             output = cat(1,output, output_cur_name);
        else               %Patch: when search type of subsystems and reach bottom, provide to output
            if ismember(i, idx_types_itr)
                output = cat(1, output, {cur_sub_line});
            end
        end
    else
        output = cat(1, output, {cur_sub_line});  %Place here to include only-top-tree 
    end
   
        %output = cat(1, output, {cur_sub_line});  %Place here to include all root
    
end
