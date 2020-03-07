function cell_out = create_mdl2NI_CANcfg(cell_in, trgt_dbc)
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



%E%Note: cell in: cell formate input based on iterated model or structure, n * 1
%trgts_dbc: must have suffix,structure format, user provided dbc inputs

%Example Run: cell_out = create_NICAN_cfg(list_model_NI, trgt_dbc_merged);
%Example Run: cell_out = create_NICAN_cfg(list_model_NI, {trgt1.mrr, trgt2.pcm});



%list_model_NI = iterateModel(gcs, 'term');
%cell_in = list_model_NI;
%trgts_dbc = trgt_dbc_merged;
%list_NI_map = create_mdl2NI_CANcfg(cell_in, trgts_dbc);

%trgt_dbc  = trgt_suffix;

% if isstruct(trgts_dbc)
%     trgt_dbc = trgts_dbc;
% else
%     disp('Not able to create, provide proper dbc structure')
%     return
% end
% 
% trgt_dbc = trgts_dbc;
% 
% trgt1 = trgt_suffix.FD1_CAN_P702_GASD_MY21_DCV_V06;
% trgt2 = trgt_mrr_suffix.MRR_PCAN_Core_v07_02;
% trgt_dbc = mergeStructs(trgt1, trgt2);
%trgt_dbc_merged = trgt_dbc;

list_dbc = iterateStruct(trgt_dbc);   %dbc structure must be suffix converted
list_dbc_tokens = cellfun(@(x) strsplit(x, '.'), list_dbc, ...
    'UniformOutput', 0 ); % each cell length > 2
dbc_msg = cellfun(@(x) x{end - 1}, list_dbc_tokens, 'UniformOutput', 0);
dbc_sig = cellfun(@(x) x{end}, list_dbc_tokens, 'UniformOutput', 0);
dbc_node = cellfun(@(x) x{end - 2}, list_dbc_tokens, 'UniformOutput', 0);
idx_gwm = contains(dbc_node, 'GWM');

%process dbc structure
dbc_msg_tokens = cellfun(@(x) strsplit(x, '_Ox'), dbc_msg, ...
    'UniformOutput', 0 ); 
dbc_msg_tokens_front= cellfun(@(x)  x{1}, dbc_msg_tokens, ...
    'UniformOutput', 0 ); 
dbc_msg_tokens_suffix = cellfun(@(x)  [' (', num2str(hex2dec(x{2})), ')'], dbc_msg_tokens, ...
    'UniformOutput', 0 ); 
expr_dbc_msg_sig = strcat(dbc_msg_tokens_front, dbc_msg_tokens_suffix, '/',dbc_sig ) ;


%-----------TBD & Modified ------------------
%Hard code expressions
path_ctrlr = 'Targets/Controller/Simulation Models/Models';
name_model = 'P702_NI_SoftECU';
dir_port_out = 'Outports';  
ctrlr_chassis_path = 'Targets/Controller/Hardware/Chassis/NI-XNET/CAN';
%-----------TBD & Modified End ---------------



cell_in_tokens  = regexp(cell_in, '(?<!/)/(?!/)','split') ;  %Patch for blocks has '/',reserve '//'
cell_in_wo_root = cellfun(@(x) strjoin(x(2:end), '/'), cell_in_tokens, 'UniformOutput', 0);
model_msg = cellfun(@(x) x{end - 1}, cell_in_tokens, 'UniformOutput', 0); % use to judge under which bus

cell_out = cell(size(cell_in)); 

for i = 1: size(cell_out , 1)
    cur_path_blk = cell_in_wo_root{i};  
    expr_left = ...
        strjoin(...
        {path_ctrlr , ...
        name_model,...
        dir_port_out,...
        cur_path_blk},...
        '/');
    
    
    
    %-----------TBD & Modified ------------------
    %Hard code expressions
    cur_msg = model_msg{i};  
    if contains(lower(cur_msg), 'mrr_det')
        name_cur_bus = 'ADAS_MRR ';
    elseif contains(lower(cur_msg), 'srr_det')
        name_cur_bus = 'ADAS_SRR ';
    else
        name_cur_bus = 'FDCAN1';
    end
   %-----------------------------------------------
   %Hard code transmit logic
    if idx_gwm(i)    
        type_CAN_tx = 'Outgoing/Event Triggered';
    else
        type_CAN_tx = 'Outgoing/Cyclic';
    end
     %-----------TBD & Modified End ---------------
    
    
     expr_right = ...
         strjoin(...
         {ctrlr_chassis_path ,...
         name_cur_bus, ...
         type_CAN_tx,...
         expr_dbc_msg_sig{i}},...
        '/');

    cell_out{i} = sprintf([expr_left,  '\t', expr_right]);
    
end