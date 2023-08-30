function create_in_archtcr(dir)
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
name_subsystem_blks = get_subsystems(dir);

names_cnst_blk = get_cnsts(dir);

name_blks_all = cat(1, name_subsystem_blks, names_cnst_blk);


% Deal subsystem without inport First >> Connect & Create Bus/Inport/Blks
idx_with_inport = has_inport(dir, name_subsystem_blks);
idx_with_subsystem = has_subsystem(dir, name_subsystem_blks);
list_sub_blks = name_subsystem_blks(~idx_with_inport & idx_with_subsystem);
list_sub_blks_dbl = regexprep(list_sub_blks, '/', '//'); % Patch for blocks contain '/'
list_sub_paths = strcat(dir, '/', list_sub_blks_dbl); 

for i  = 1: length(list_sub_paths)
    sub_dir = list_sub_paths{i};
    create_in_archtcr(sub_dir);
end


% Connect & Create Bus/Inport/Blks
name_bus = 'bus_selector';
name_port = 'in';

[name_blks_all, valid_sort, ~] = sort_blks (dir, name_blks_all); % valid should be all true here

name_blks_all = name_blks_all(valid_sort);

num_ports = length(name_blks_all);

create_busselector(dir, name_bus, num_ports);

setnames_busselector(dir, name_bus, name_blks_all)

name_blks_all_dbl = regexprep(name_blks_all, '/', '//'); %Patch for '/'
cnnt_bus2blks(dir, name_bus, name_blks_all_dbl)  

create_inport(dir, name_port, num_ports)

cnnt_inport2bus(dir, name_port, name_bus)


end