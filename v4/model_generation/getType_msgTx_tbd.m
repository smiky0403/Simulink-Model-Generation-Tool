function type = getType_msgTx( msg, db_obj)
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
%       TBD
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


idx = find()




end


function type_vetr = translate_TxType(type_mlb)


switch type_mlb
    
    case 'NoMsgSendType'
        type_vetr = 'Cyclic';
    case 'FixedPeriodic'
        type_vetr = 'Cyclic';
    case 'Event'
        type_vetr = 'Event Triggered';
    case 'EventPeriodic'
        type_vetr = 'EventPeriodic';
end
end