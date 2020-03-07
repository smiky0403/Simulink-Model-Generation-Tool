function struct2mdl_out(dir, trgt, varargin)
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


%Example Run: struct2mdl_out(gcs, trgt)
%Example Run: struct2mdl_out(gcs, trgt, 'gw')
%Example Run: struct2mdl_out(gcs, trgt, 'ni')
%Example Run: struct2mdl_out('test_mdl/ECM_Diesel', trgt.FD1_CAN_P702_GASD_MY21_DCV_V06.ECM_Diesel)
%Example Run: struct2mdl_out('test_mdl/ECM_Diesel/EffDrvModeData', trgt.FD1_CAN_P702_GASD_MY21_DCV_V06.ECM_Diesel.EffDrvModeData)
%Example Run: struct2mdl_out('test_mdl/ECM_Diesel', trgt.FD1_CAN_P702_GASD_MY21_DCV_V06.ECM_Diesel, 'gw')
disp(['Now Creating Blocks under : ', dir])
%prepare inputs to generate models - Step 1

%tokens = regexp(dir, '/','split');
tokens = regexp(gcs, '(?<!/)/(?!/)','split') ;  %Patch for blocks has '/',to reserve '//'

name_parent = tokens{end};

names_child = fieldnames(trgt); %host layer
idx_all = 1:1:length(names_child);
idx_struct = idx_all(structfun(@isstruct,trgt));
idx_cnst = idx_all(~structfun(@isstruct,trgt));
names_subsys_marked = names_child(idx_struct);   %May contain marks such as 
names_cnst = names_child(idx_cnst);

names_child = replc_mark(names_child, 'back');
names_subsys = replc_mark(names_subsys_marked, 'back');
names_cnst = replc_mark(names_cnst, 'back');
%Patch Note for Slash '/': creating model accept '/'; path or connect model accept '//'

names_cnst_dbl = regexprep(names_cnst, '/', '//'); %Patch model name has '/'
names_subsys_dbl = regexprep(names_subsys, '/', '//'); %Pacth model name has '/'

name_bus= 'bus_selector';
name_port = 'in_port';
name_label = name_parent;
num_child = length(names_child);
 

%Generate models skeleton
create_busselector(dir, name_bus, num_child);
setnames_busselector(dir, name_bus, names_child); 
create_inport( dir,name_port, num_child);
cnnt_inport2bus(dir, name_port, name_bus, name_label);

if ( ~isempty(varargin) ) && strcmpi( varargin{1},'gw')
    create_cnst_gw(dir, names_cnst, idx_cnst);    
elseif ( ~isempty(varargin) ) && strcmpi( varargin{1},'ni')  %TBD  NI blocks
    create_NI_out(dir, names_cnst, idx_cnst);    
else
    create_term(dir, names_cnst, idx_cnst);   
end
 cnnt_bus2blks(dir, name_bus, names_cnst_dbl, idx_cnst);

% Generate blocks which has subsystem - by self_call
create_subsystem(dir, names_subsys, idx_struct);
for i = 1: length(names_subsys)
    name_subsys_marked = names_subsys_marked{i};
    name_subsys_dbl = names_subsys_dbl{i};
    sub_dir = [dir, '/',name_subsys_dbl];
    sub_trgt =  trgt.(name_subsys_marked);
    % iterate all through the model
    
    % -----SELF CALL -----------
    if ( ~isempty(varargin) ) && strcmpi( varargin{1},'gw')
        struct2mdl_out(sub_dir, sub_trgt,'gw');
    elseif ( ~isempty(varargin) ) && strcmpi( varargin{1},'ni')
        struct2mdl_out(sub_dir, sub_trgt,'ni');
    else
        struct2mdl_out(sub_dir, sub_trgt);
    end
    % -----SELF CALL -----------
end

cnnt_bus2blks(dir, name_bus, names_subsys_dbl, idx_struct);
