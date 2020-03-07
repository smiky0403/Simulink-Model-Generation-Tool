function new_strings = replc_mark(old_strings, varargin)
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


%expressions can be char or cell
%see code line tokens & replcs for varargin inputs
%Note: Do not modify path, modify namae only - due to slash issue
%Example Run: new_strings = replc_mark( '[abc(def)_sdgs]')
%Example Run: new_strings = replc_mark( {'L_Brkt_abcL_Paren_def_R_Pren_sdgs_R_Brkt'}, 'back')



if isempty(varargin)
   opt = 'forward';    %'forward', 'fwd', 'front'
else
   opt = varargin{1};    % +++ : 'backward', 'bwd', 'back', 'reset'
end

if ischar(old_strings)
    expressions = {old_strings}; 
else
    expressions = old_strings; 
end


tokens = {'[', ']', ...
    '(', ')',...
    '[|]', ...
    '/',...
	'%', ...
	'\$', ...
    ' '};
replcs = {'L_Brkt_', '_R_Brkt', ...
    'L_Paren_', '_R_Pren',...
    '_Perp_',...
    '_Slsh_',...
	'Per',...
	'Dol',...
    '_SPC_'}; % To be udpate further   

%Prefer same as before
tokens_back = {'[', ']', ...
    '(', ')',...
    '|', ...
    '/',...
	'%',...
	'$',...
    ' '};

% tokens_back = {'[', ']', ...
%     '(', ')',...
%     '|', ...
%     '//',...
%     ' '};


new_strings = cell(length(expressions), 1);
for i = 1: length(expressions)
    expression = expressions{i};
    
    for j = 1 : length(tokens)
        if ismember(lower(opt), {'forward', 'fwd', 'front'})
            expression
            tokens{j}
            expression  = regexprep(expression , tokens{j}, replcs{j});
        elseif ismember(lower(opt), {'backward', 'bwd', 'back', 'reset'})
            expression  = regexprep(expression, replcs{j} , tokens_back{j});
        else
            disp('Wrong user options, expression keep unchanged')
        end
    end
    
    new_strings{i} = expression;
end

if ischar(old_strings)
    new_strings = new_strings{1}; 
end