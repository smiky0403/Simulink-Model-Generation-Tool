 function trgt = dbc2struct(dbc_file, varargin)
 
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

 
%Example Run: trgt = dbc2struct('FD1_CAN_P702_GASD_MY21_DCV_V06.dbc');
%Example Run: trgt_prefix = dbc2struct('FD1_CAN_P702_GASD_MY21_DCV_V06.dbc', 'prefix');
%Example Run: trgt_suffix = dbc2struct('FD1_CAN_P702_GASD_MY21_DCV_V06.dbc', 'suffix');

%varargin = options 
if isempty(varargin)
    opt = 'none';
else 
    opt = varargin{1};    
    %opt = 'none';
    %opt = 'prefix hex';
    %opt = 'suffix'
    %opt = 'prefix bracket'
    %opt = 'suffix bracket'
end
    

 trgt = struct();


%-----------dbc > node---------------
% dbc_file = 'FD1_CAN_P702_GASD_MY21_DCV_V06.dbc'; 


db = canDatabase(dbc_file);
dbc_name = dbc_file(1:end -4 );

%assign dbc to struct
trgt.(dbc_name) =  [];


%-----------node > msg---------------  
nodes = {db.MessageInfo(:).TxNodes};
nodes = unique(cat(1,nodes{:})); 
% nodes = nodes(~cellfun(@isempty, nodes));%Patch remove empty
% nodes =  nodes(cellfun(@ischar, nodes)); %Patch remove NaN and no string



%assign nodes to struct
for i  = 1: length(nodes)
    node = nodes{i};
    trgt.(dbc_name).(node) = [];

end

%-----------msg > signal---------------  
    
% cell_TxNodes = {db.MessageInfo(:).TxNodes};
messages = {db.MessageInfo(:).Name};
messages_id = {db.MessageInfo(:).ID};
% idx_valid = ~cellfun(@isempty, mesages) & cellfun(@ischar,mesages); %Patch remove empty, no string and NaN
% mesages = mesages(idx_valid);
% mesages_id =  mesages_id(idx_valid);



    switch lower(opt)   %Patch append ID information to CAN message       
        case 'none'
            messages_str = messages;
        case 'prefix'
            messages_id = cellfun(@(x) dec2hex(x) , messages_id, 'UniformOutput', 0);
            messages_str = strcat('Ox', messages_id, '_', messages);
        case 'suffix'
            messages_id = cellfun(@(x) dec2hex(x) , messages_id, 'UniformOutput', 0);
            messages_str = strcat(messages,  '_', 'Ox', messages_id);
        otherwise
            messages_str = messages;
    end 


    

for m  = 1: length(messages)
    
    %assign messages to struct
    message_str = messages_str{m};     
    nodes_m = db.MessageInfo(m).TxNodes;   
    signals = {db.MessageInfo(m).SignalInfo(:).Name};
    

    for n = 1: length(nodes_m)  %For each msg, its Tx node may > 1, e.g. HPCM/PCM
         node = nodes_m{n};
         %trgt.(dbc_name).(node).(mesage) = [];   %Patch 4 empty msg
         for s = 1 : length(signals)
             signal = signals{s};
             sig_val = 0;
             %sig_raw = db.MessageInfo(m).SignalInfo(s).AttributeInfo(6).Value ;%TBD
             trgt.(dbc_name).(node).(message_str).(signal) = sig_val;
         end
         %trgt.(dbc_name).(node).(mesage) = []; 
    end
    
    %assign signals to struct

end
