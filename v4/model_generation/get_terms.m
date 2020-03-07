function names_blk = get_terms(dir)
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


names_all = get_param(dir, 'Blocks');
names_all = regexprep(names_all, '/', '//');%PATCH

paths_all = strcat(dir, '/', names_all);

types_all = get_param(paths_all, 'BlockType');

names_blk = names_all(strcmp(types_all, 'Terminator') );
names_blk = regexprep(names_blk, '//', '/');  %Patch '/'


end