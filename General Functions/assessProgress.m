function tab = assessProgress(Path)
    folder_contents = extractfield(dir(Path),'name');
    %Make sure the needed folders are in the directory
    if ~any(ismember(folder_contents,'Segmented Files'))
        error('No "Segmented Files" folder in this directory')
    elseif ~any(ismember(folder_contents,'Cycle Averages'))
        error('No "Cycle Averages" folder in this directory')    
    end
    seg_files = extractfield(dir([Path,filesep,'Segmented Files',filesep,'*-*.mat']),'name');
    if isempty(seg_files)
        error('No segments present.')
    end  
    %Cyc Avg
    cyc_files = extractfield(dir([Path,filesep,'Cycle Averages',filesep,'*Cyc*Avg*.mat']),'name');
    if isempty(cyc_files)
        cyc_files = {''};
    end
    cyc_fi = strrep(strrep(strrep(cyc_files,'_CycleAvg',''),'CycAvg_',''),'NotAnalyzeable_','');   
    cyc = ismember(seg_files,cyc_fi);
    %Not Analyzeable
    na_files = extractfield(dir([Path,filesep,'Cycle Averages',filesep,'NotAnalyzeable_*.mat']),'name');
    if isempty(na_files)
        na_files = {''};
    end
    na_fi = strrep(strrep(strrep(na_files,'_CycleAvg',''),'CycAvg_',''),'NotAnalyzeable_',''); 
    na = ismember(seg_files,na_fi);    
    tab = [cell2table(seg_files),array2table([cyc,na])];
    %% Common Code
    tab.Properties.VariableNames = {'Segment','CycAvgFile','NotAnalyzeable'};      
    save([Path,filesep,'Progress.mat'],'tab')
end
