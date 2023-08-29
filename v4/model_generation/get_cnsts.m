function [names_blk, varargout] = get_cnsts(varargin)
%--------------------------------------------------------------------------
%------------------M-File Model Generation Block -------------------------------
%--------------------------------------------------------------------------
%
%Author:
%       Mingqi Shi, mingqis qti  QM
%
%Created:
%       202308-21
%
%Last modified:
%       Mingqi Shi
%       2023-08-23
%
%Version:
%       0.3
%
%Description:
%       See Eample Run below and Demo document, get ystem of current
%       Get consts, NOT include const inside a subsystem if iput args < 2
%         or opt = 0
%       if opt = 1 as 2nd arg, get all sub models names
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Example Run: get_cnsts()
%Example Run: get_cnsts('test_mdl/adc') or get_cnsts('gcs') 
%Example Run: get_cnsts('test_mdl/adc',1])


if(nargin == 0)
    dir = gcs;
elseif(nargin >= 1)
    dir = varargin{1};
end

names_all = get_param(dir, 'Blocks');
names_all = regexprep(names_all, '/', '//');%PATCH

paths_all = strcat(dir, '/', names_all);

types_all = get_param(paths_all, 'BlockType');

names_blk = names_all(strcmp(types_all, 'Constant') );
names_blk = regexprep(names_blk, '//', '/');  %Patch '/'




names_all = get_param(dir, 'Blocks');
names_all = regexprep(names_all, '/', '//'); %Patch '/'

paths_all = strcat(dir, '/', names_all);

types_all = get_param(paths_all, 'BlockType');

paths_subsystems = paths_all(strcmp(types_all, 'SubSystem') );
paths_cnst = paths_all(strcmp(types_all, 'Constant') ); %

names_blk = names_all(strcmp(types_all, 'Constant') );

names_blk = regexprep(names_blk, '//', '/');  %Patch '/'

varargout{1} = paths_cnst ;
%varargout{2} = paths_cnst ;



if(nargin == 2 )
    
    opt = varargin{2};

    if(opt == 0)
        % Do Nothing, i.e. only check current layer
    elseif (opt == 1)
        % Recursive, i.e. check all sub-layer
        for i = 1: length(paths_subsystems)
            dir = paths_subsystems{i};
            [names_sub, paths_sub] = get_cnsts(dir, 1);
            names_blk = [names_blk; names_sub];
            varargout{1} = [varargout{1}; paths_sub ];
        end

    end 

end

end