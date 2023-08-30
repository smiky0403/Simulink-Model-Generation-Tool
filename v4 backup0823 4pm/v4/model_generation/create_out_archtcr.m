function create_out_archtcr(dir)
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

names_term_blk = get_terms(dir);   % Or NI out-port

name_blks_all = cat(1, name_subsystem_blks, names_term_blk);


% Deal subsystem without inport First >> Connect & Create Bus/Inport/Blks
idx_with_outport = has_outport(dir, name_subsystem_blks);
idx_with_subsystem = has_subsystem(dir, name_subsystem_blks);
list_sub_blks = name_subsystem_blks(~idx_with_outport & idx_with_subsystem);
list_sub_blks_dbl = regexprep(list_sub_blks, '/', '//'); % Patch for blocks contain '/'
list_sub_paths = strcat(dir, '/', list_sub_blks_dbl); 

for i  = 1: length(list_sub_paths)
    sub_dir = list_sub_paths{i};
    create_out_archtcr(sub_dir);
end


% Connect & Create Bus/Inport/Blks
name_bus = 'bus_creator';
name_port = 'out';

[name_blks_all, valid_sort, ~] = sort_blks (dir, name_blks_all); % valid should be all true here

name_blks_all = name_blks_all(valid_sort);

num_ports = length(name_blks_all);

create_buscreator(dir, name_bus, num_ports);

%setnames_busselector(dir, name_bus, name_blks_all)

name_blks_all_dbl = regexprep(name_blks_all, '/', '//'); %Patch for '/'
cnct_blks2bus(dir, name_blks_all_dbl, name_bus)  

create_outport(dir, name_port, num_ports)

cnct_bus2port(dir, name_bus, name_port)


end