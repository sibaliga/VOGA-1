path_name = split(cd,filesep);
sub = strrep(path_name{contains(path_name,'MVI')&contains(path_name,'R')},'_','');
if contains(sub,{'MVI001','MVI002','MVI003','MVI004','MVI007','MVI009'})
    ear = 'L';
else
    ear = 'R';
end
visit = strrep(path_name{contains(path_name,'Visit')},' ','');
gog = 'LDVOG2';
ang = '-170';
all_files = extractfield(dir(cd),'name',find(~extractfield(dir(cd),'isdir')));
VOG_files = all_files(((contains(all_files,'SESSION')&contains(all_files,'.txt'))|contains(all_files,'.dat'))...
    &~contains(all_files,'-Notes.txt'));
types = {...
'SineAmp-LHRH';'SineAmp-LARP';'SineAmp-RALP';'SineAmp-X';'SineAmp-Y';...
'PFM-LHRH';'PFM-LARP';'PFM-RALP';'PAM-LHRH';'PAM-LARP';'PAM-RALP';...
'SineFreqLow-LHRH';'SineFreqLow-LARP';'SineFreqLow-RALP';'SineFreqLow-X';'SineFreqLow-Y';...
'65Vect1';'65Vect2';'65Vect3';'65Vect4';'65Vect5';...
};
%types = {'SineFreqLow-LHRH';'SineFreqLow-LARP';'SineFreqHigh-RALP';'SineFreqHigh-X';'SineFreqHigh-Y'};
% types = {'SineAmp-LHRH';'SineAmp-RALP';'SineAmp-LARP';'SineAmp-X';'SineAmp-Y';...
%     'PFM-LHRH';'PFM-RALP';'PFM-LARP';'PAM-LHRH';'PAM-RALP';'PAM-LARP';...
%     '65Vect1';'65Vect2';'65Vect3';'65Vect4';'65Vect5';...
%     'SineFreqLow-LHRH';'SineFreqHigh-LARP';'SineFreqHigh-RALP';'SineFreqHigh-X';'SineFreqHigh-Y'};
% types = {'SineFreqLow-LHRH';'SineFreqLow-RALP';'SineFreqLow-LARP';'SineFreqLow-X';'SineFreqLow-Y';...
%     'SineAmp-LHRH';'SineAmp-RALP';'SineAmp-LARP';'SineAmp-X';'SineAmp-Y';...
%     'PFM-LHRH';'PFM-RALP';'PFM-LARP';'PAM-LHRH';'PAM-RALP';'PAM-LARP';...
%     '65Vect1';'65Vect2';'65Vect3';'65Vect4';'65Vect5'};
% types = {'SineFreqLow-LHRH';'SineFreqLow-LARP';'SineFreqLow-RALP';'SineFreqLow-X';'SineFreqLow-Y';...
%     'SineAmp-LHRH';'SineAmp-LARP';'SineAmp-RALP';'SineAmp-X';'SineAmp-Y';...
%     'PFM-LHRH';'PFM-LARP';'PFM-RALP';'PAM-LHRH';'PAM-LARP';'PAM-RALP';...
%     '65Vect1';'65Vect2';'65Vect3';'65Vect4';'65Vect5'};

%fname = 'SESSION-2019Apr02-140113.txt';
%type = 'SineFreqLow-LHRH';
%%
for j = 1:length(VOG_files)
    fname = VOG_files{j};
    fparts = split(fname,'-');
    date = datestr(datetime(fparts{2},'InputFormat','yyyyMMMdd'),'yyyymmdd'); %Get date from the file name
    type = types{j};
    if contains(type,'PFM')
        %rate = [20,50,100,200,300,400]; 
        rate = [0,20,50,150,200,300,400];
        %rate = [0,20,50,100,175,200,250,350,450]; %MVI 2, 3, 4, 5, 6 PFM all channels
        base_curr = [599,699,448]; %MVI1
        %base_curr = [349,599,599]; %MVI2
        %base_curr = [623,401,599]; %MVI3
        %base_curr = [321,548,406]; %MVI4
        %base_curr = [472,401,330]; %MVI5
        %base_curr = [581,326,500]; %MVI6
        if contains(type,'LHRH')
            curr = base_curr(1)*ones(1,length(rate)); 
        elseif contains(type,'LARP')
            curr = base_curr(2)*ones(1,length(rate));
        elseif contains(type,'RALP')
            curr = base_curr(3)*ones(1,length(rate));
        end
    elseif contains(type,'PAM')
        if contains(type,'LHRH')
            curr = [623,581,642,562,661,538,680,519,699,500];%MVI1
            %curr = [391,312,430,269,472,231,510,191,552,151]; %MVI2
            %curr = [642,623,651,623,670,614,680,614,699,614]; %MVI3
            %curr = [359,302,392,283,430,262,467,243,500,224]; %MVI4
            %curr = [496,415,519,362,543,307,566,255,590,201]; %MVI5;
            %curr = [604,557,623,529,651,500,680,477,699,448]; %MVI6
        elseif contains(type,'LARP')
            curr = [680,661,632,614,599]; %MVI1
            %curr = [623,581,642,562,661,538,680,519,699,500]; %MVI2
            %curr = [406,401,411,401,415,396,420,396,425,396]; %MVI3
            %curr = [557,481,566,420,576,354,585,290,599,224]; %MVI4
            %curr = [439,340,481,281,519,222,557,160,599,100]; %MVI5;
            %curr = [401,290,477,255,548,222,623,186,699,151]; %MVI6
        elseif contains(type,'RALP')
            curr = [463,430,491,406,510,382,529,368,548,349]; %MVI1
            %curr = [623,581,642,562,661,538,680,519,699,500]; %MVI2
            %curr = 599*ones(1,10); %MVI3
            %curr = [425,349,444,293,463,236,481,182,500,124]; %MVI4
            %curr = [406,283,477,238,552,191,623,146,699,100]; %MVI5;
            %curr = [538,453,581,401,623,349,661,300,699,250]; %MVI6
        end 
        rate = 100*ones(1,length(curr)); %MVI 3, 4, 5, 6 PAM all channels
    end
    notes = {['Subject ',sub];...
             ['Ear ',ear];...
             ['Visit ',visit];...
             ['Date ',date];...
             ['Goggle ',gog];...
             ['Angle ',ang]};
    if contains(type,'-')
        parts = split(type,'-');
        canal = parts{2};
        type = parts{1};
    end
    switch type
        case 'SineFreqLow'     
    %% Sine Freq Low to High
    exp_notes = {['Experiment eeVOR-Sine-',canal,'-0.1Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-0.2Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-0.5Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-1Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-2Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-5Hz-100dps']};
        case 'SineFreqHigh'
    %% Sine Freq High to Low
    exp_notes = {['Experiment eeVOR-Sine-',canal,'-5Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-2Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-1Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-0.5Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-0.2Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-0.1Hz-100dps']};
        case 'SineAmp'
    %% Sine Amp
    exp_notes = {['Experiment eeVOR-Sine-',canal,'-2Hz-20dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-2Hz-50dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-2Hz-100dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-2Hz-200dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-2Hz-300dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-2Hz-400dps'];...
                 ['Experiment eeVOR-Sine-',canal,'-2Hz-500dps']};  
    %% 65 Vect File 1
        case '65Vect1'
    exp_notes = {'Experiment eeVOR-MultiVector-[0.707,0.707,0.000]';...
                 'Experiment eeVOR-MultiVector-[0.383,0.924,0.000]';...
                 'Experiment eeVOR-MultiVector-[0.000,1.000,0.000]';...
                 'Experiment eeVOR-MultiVector-[-0.383,0.924,0.000]';...
                 'Experiment eeVOR-MultiVector-[-0.707,0.707,0.000]';...
                 'Experiment eeVOR-MultiVector-[-0.924,0.383,0.000]';...
                 'Experiment eeVOR-MultiVector-[-1.000,0.000,0.000]';...
                 'Experiment eeVOR-MultiVector-[-0.924,-0.383,0.000]';...
                 'Experiment eeVOR-MultiVector-[-0.707,-0.707,0.000]';...
                 'Experiment eeVOR-MultiVector-[0.924,0.383,0.000]';...
                 'Experiment eeVOR-MultiVector-[1.000,0.000,0.000]';...
                 'Experiment eeVOR-MultiVector-[0.924,-0.383,0.000]';...
                 'Experiment eeVOR-MultiVector-[0.707,-0.707,0.000]'};
        case '65Vect2'
    %% 65 Vect File 2
    exp_notes = {'Experiment eeVOR-MultiVector-[0.383,-0.924,0.000]';...
                 'Experiment eeVOR-MultiVector-[0.000,-1.000,0.000]';...
                 'Experiment eeVOR-MultiVector-[-0.383,-0.924,0.000]';...
                 'Experiment eeVOR-MultiVector-[0.653,0.653,0.383]';...
                 'Experiment eeVOR-MultiVector-[0.354,0.854,0.383]';...
                 'Experiment eeVOR-MultiVector-[0.000,0.923,0.383]';...
                 'Experiment eeVOR-MultiVector-[-0.354,0.854,0.383]';...
                 'Experiment eeVOR-MultiVector-[-0.653,0.653,0.383]';...
                 'Experiment eeVOR-MultiVector-[-0.854,0.354,0.383]';...
                 'Experiment eeVOR-MultiVector-[-0.923,0.000,0.383]';...
                 'Experiment eeVOR-MultiVector-[-0.854,-0.354,0.383]';...
                 'Experiment eeVOR-MultiVector-[-0.653,-0.653,0.383]';...
                 'Experiment eeVOR-MultiVector-[0.854,0.354,0.383]'};  
        case '65Vect3'
    %% 65 Vect File 3
    exp_notes = {'Experiment eeVOR-MultiVector-[0.923,0.000,0.383]';...
                 'Experiment eeVOR-MultiVector-[0.854,-0.354,0.383]';...
                 'Experiment eeVOR-MultiVector-[0.653,-0.653,0.383]';...
                 'Experiment eeVOR-MultiVector-[0.354,-0.854,0.383]';...
                 'Experiment eeVOR-MultiVector-[0.000,-0.923,0.383]';...
                 'Experiment eeVOR-MultiVector-[-0.354,-0.854,0.383]';...
                 'Experiment eeVOR-MultiVector-[0.500,0.500,0.707]';...
                 'Experiment eeVOR-MultiVector-[0.270,0.653,0.707]';...
                 'Experiment eeVOR-MultiVector-[0.000,0.707,0.707]';...
                 'Experiment eeVOR-MultiVector-[-0.270,0.653,0.707]';...
                 'Experiment eeVOR-MultiVector-[-0.500,0.500,0.707]';...
                 'Experiment eeVOR-MultiVector-[-0.653,0.270,0.707]';...
                 'Experiment eeVOR-MultiVector-[-0.707,0.000,0.707]'};
        case '65Vect4'
    %% 65 Vect File 4
    exp_notes = {'Experiment eeVOR-MultiVector-[-0.653,-0.270,0.707]';...
                 'Experiment eeVOR-MultiVector-[-0.500,-0.500,0.707]';...
                 'Experiment eeVOR-MultiVector-[0.653,0.270,0.707]';...
                 'Experiment eeVOR-MultiVector-[0.707,0.000,0.707]';...
                 'Experiment eeVOR-MultiVector-[0.653,-0.270,0.707]';...
                 'Experiment eeVOR-MultiVector-[0.500,-0.500,0.707]';...
                 'Experiment eeVOR-MultiVector-[0.270,-0.653,0.707]';...
                 'Experiment eeVOR-MultiVector-[0.000,-0.707,0.707]';...
                 'Experiment eeVOR-MultiVector-[-0.270,-0.653,0.707]';...
                 'Experiment eeVOR-MultiVector-[0.271,0.271,0.924]';...
                 'Experiment eeVOR-MultiVector-[0.147,0.354,0.924]';...
                 'Experiment eeVOR-MultiVector-[0.000,0.383,0.924]';...
                 'Experiment eeVOR-MultiVector-[-0.147,0.354,0.924]'}; 
        case '65Vect5'
    %% 65 Vect File 5
    exp_notes = {'Experiment eeVOR-MultiVector-[-0.271,0.271,0.924]';...
                 'Experiment eeVOR-MultiVector-[-0.354,0.147,0.924]';...
                 'Experiment eeVOR-MultiVector-[-0.383,0.000,0.924]';...
                 'Experiment eeVOR-MultiVector-[-0.354,-0.147,0.924]';...
                 'Experiment eeVOR-MultiVector-[-0.271,-0.271,0.924]';...
                 'Experiment eeVOR-MultiVector-[0.354,0.147,0.924]';...
                 'Experiment eeVOR-MultiVector-[0.383,0.000,0.924]';...
                 'Experiment eeVOR-MultiVector-[0.354,-0.147,0.924]';...
                 'Experiment eeVOR-MultiVector-[0.271,-0.271,0.924]';...
                 'Experiment eeVOR-MultiVector-[0.147,-0.354,0.924]';...
                 'Experiment eeVOR-MultiVector-[0.000,-0.383,0.924]';...
                 'Experiment eeVOR-MultiVector-[-0.147,-0.354,0.924]';...
                 'Experiment eeVOR-MultiVector-[0.000,0.000,1.000]'};
        case '40Vect1'
    %% 40 Vect LEFT/RIGHT File 1
    exp_notes = {'Experiment eeVOR-MultiVector-[0.000,0.000,1.000]';...
                'Experiment eeVOR-MultiVector-[0.000,0.000,-1.000]';...
                'Experiment eeVOR-MultiVector-[1.000,0.000,0.000]';...
                'Experiment eeVOR-MultiVector-[-1.000,0.000,0.000]';...
                'Experiment eeVOR-MultiVector-[0.000,-1.000,0.000]';...
                'Experiment eeVOR-MultiVector-[0.000,1.000,0.000]';...
                'Experiment eeVOR-MultiVector-[-0.707,-0.707,0.000]';...
                'Experiment eeVOR-MultiVector-[0.707,0.707,0.000]';...
                'Experiment eeVOR-MultiVector-[-0.707,0.707,0.000]';...
                'Experiment eeVOR-MultiVector-[0.707,-0.707,0.000]'};
        case '40Vect2L'
    %% 40 Vect LEFT File 2
    exp_notes = {'Experiment eeVOR-MultiVector-[-0.707,0.000,-0.707]';...
                'Experiment eeVOR-MultiVector-[-0.500,-0.500,-0.707]';...
                'Experiment eeVOR-MultiVector-[-0.500,0.500,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.000,-0.707,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.000,0.707,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.500,-0.500,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.500,0.500,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.707,0.000,-0.707]';...
                'Experiment eeVOR-MultiVector-[-0.924,-0.383,0.000]';...
                'Experiment eeVOR-MultiVector-[-0.383,-0.924,0.000]'};
        case '40Vect3L'
    %% 40 Vect LEFT File 3
    exp_notes = {'Experiment eeVOR-MultiVector-[-0.924,0.000,0.383]';...
                'Experiment eeVOR-MultiVector-[-0.854,-0.354,0.383]';...
                'Experiment eeVOR-MultiVector-[-0.653,-0.653,0.383]';...
                'Experiment eeVOR-MultiVector-[-0.354,-0.854,0.383]';...
                'Experiment eeVOR-MultiVector-[0.000,-0.924,0.383]';...
                'Experiment eeVOR-MultiVector-[-0.707,0.000,0.707]';...
                'Experiment eeVOR-MultiVector-[-0.500,-0.500,0.707]';...
                'Experiment eeVOR-MultiVector-[-0.500,0.500,0.707]';...
                'Experiment eeVOR-MultiVector-[0.000,-0.707,0.707]';...
                'Experiment eeVOR-MultiVector-[0.000,0.707,0.707]'};
        case '40Vect4L'
            %% 40 Vect LEFT File 4
    exp_notes = {'Experiment eeVOR-MultiVector-[0.500,-0.500,0.707]';...
                'Experiment eeVOR-MultiVector-[0.500,0.500,0.707]';...
                'Experiment eeVOR-MultiVector-[0.707,0.000,0.707]';...
                'Experiment eeVOR-MultiVector-[-0.653,-0.271,0.707]';...
                'Experiment eeVOR-MultiVector-[-0.271,-0.653,0.707]';...
                'Experiment eeVOR-MultiVector-[-0.383,0.000,0.924]';...
                'Experiment eeVOR-MultiVector-[-0.354,-0.146,0.924]';...
                'Experiment eeVOR-MultiVector-[-0.271,-0.271,0.924]';...
                'Experiment eeVOR-MultiVector-[-0.146,-0.354,0.924]';...
                'Experiment eeVOR-MultiVector-[0.000,-0.383,0.924]'};
        case '40Vect2R'
            %% 40 Vect RIGHT File 2
    exp_notes = {'Experiment eeVOR-MultiVector-[0.000,0.383,-0.924]';...
                'Experiment eeVOR-MultiVector-[0.146,0.354,-0.924]';...
                'Experiment eeVOR-MultiVector-[0.271,0.271,-0.924]';...
                'Experiment eeVOR-MultiVector-[0.354,0.146,-0.924]';...
                'Experiment eeVOR-MultiVector-[0.383,0.000,-0.924]';...
                'Experiment eeVOR-MultiVector-[-0.707,0.000,-0.707]';...
                'Experiment eeVOR-MultiVector-[-0.500,-0.500,-0.707]';...
                'Experiment eeVOR-MultiVector-[-0.500,0.500,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.000,-0.707,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.000,0.707,-0.707]'};
         case '40Vect3R'
    %% 40 Vect RIGHT File 3
    exp_notes = {'Experiment eeVOR-MultiVector-[0.500,-0.500,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.500,0.500,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.707,0.000,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.271,0.653,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.653,0.271,-0.707]';...
                'Experiment eeVOR-MultiVector-[0.000,0.924,-0.383]';...
                'Experiment eeVOR-MultiVector-[0.354,0.854,-0.383]';...
                'Experiment eeVOR-MultiVector-[0.653,0.653,-0.383]';...
                'Experiment eeVOR-MultiVector-[0.854,0.354,-0.383]';...
                'Experiment eeVOR-MultiVector-[0.924,0.000,-0.383]'};
         case '40Vect4R'
    %% 40 Vect RIGHT File 4
    exp_notes = {'Experiment eeVOR-MultiVector-[0.383,0.924,0.000]';...
                'Experiment eeVOR-MultiVector-[0.924,0.383,0.000]';...
                'Experiment eeVOR-MultiVector-[-0.707,0.000,0.707]';...
                'Experiment eeVOR-MultiVector-[-0.500,-0.500,0.707]';...
                'Experiment eeVOR-MultiVector-[-0.500,0.500,0.707]';...
                'Experiment eeVOR-MultiVector-[0.000,-0.707,0.707]';...
                'Experiment eeVOR-MultiVector-[0.000,0.707,0.707]';...
                'Experiment eeVOR-MultiVector-[0.500,-0.500,0.707]';...
                'Experiment eeVOR-MultiVector-[0.500,0.500,0.707]';...
                'Experiment eeVOR-MultiVector-[0.707,0.000,0.707]'};
        case 'PFM'  
    %% PFM
    exp_notes = cell(length(rate),1);
    for i = 1:length(exp_notes)
        exp_notes{i} = ['Experiment eeVOR-PulseTrain-PFM_',canal,'-',num2str(rate(i)),'pps-',num2str(curr(i)),'uA'];
    end
        case 'PAM'
    %% PAM
    exp_notes = cell(length(curr),1);
    for i = 1:length(exp_notes)
        exp_notes{i} = ['Experiment eeVOR-PulseTrain-PAM_',canal,'-',num2str(rate(i)),'pps-',num2str(curr(i)),'uA'];
    end
    end
    % Check
    w_notes = [notes;exp_notes];
    %disp(fname)
    %disp(w_notes)
    % Save
    filePh = fopen([fname(1:end-4),'-Notes.txt'],'w');
    fprintf(filePh,'%s\n',w_notes{:});
    fclose(filePh); 
end