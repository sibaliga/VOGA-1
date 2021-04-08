%% Make Cycle Average Struct
function CycAvg = MakeCycAvg__makeStruct(LE_V,RE_V,keep_tr,Data,Fs,t_snip,stims,info,filt,In_FileName)
    CycAvg.old_Fs = Data.Fs;
    CycAvg.Fs = Fs;    
    CycAvg.t = t_snip;
    if contains(info.goggle_ver,'GNO')       
        CycAvg.head_cyc = stims(:,keep_tr);
        CycAvg.head_cycavg = mean(stims(:,keep_tr),2)';
        CycAvg.head_cycstd = std(stims(:,keep_tr),0,2)';
        CycAvg.eye_cyc = RE_V(:,keep_tr);
        CycAvg.eye_cycavg = mean(RE_V(:,keep_tr),2)';
        CycAvg.eye_cycstd = std(RE_V(:,keep_tr),0,2)';
        %Raw data too
        CycAvg.raw_Data = Data;
        %Other relevant items
        CycAvg.info = info;
        CycAvg.name = ['CycAvg_',In_FileName];
        CycAvg.filt = filt;
        CycAvg.cyclist = find(keep_tr);
    else
        CycAvg.stim = stims';
        %Calculate means
        CycAvg.lz_cycavg = mean(LE_V.LHRH(:,keep_tr),2)';
        CycAvg.ll_cycavg = mean(LE_V.LARP(:,keep_tr),2)';
        CycAvg.lr_cycavg = mean(LE_V.RALP(:,keep_tr),2)';
        CycAvg.lx_cycavg = mean(LE_V.X(:,keep_tr),2)';
        CycAvg.ly_cycavg = mean(LE_V.Y(:,keep_tr),2)';
        CycAvg.rz_cycavg = mean(RE_V.LHRH(:,keep_tr),2)';
        CycAvg.rl_cycavg = mean(RE_V.LARP(:,keep_tr),2)';
        CycAvg.rr_cycavg = mean(RE_V.RALP(:,keep_tr),2)';
        CycAvg.rx_cycavg = mean(RE_V.X(:,keep_tr),2)';
        CycAvg.ry_cycavg = mean(RE_V.Y(:,keep_tr),2)';
        %Make standard deviations
        CycAvg.lz_cycstd = std(LE_V.LHRH(:,keep_tr),0,2)';
        CycAvg.ll_cycstd = std(LE_V.LARP(:,keep_tr),0,2)';
        CycAvg.lr_cycstd = std(LE_V.RALP(:,keep_tr),0,2)';
        CycAvg.lx_cycstd = std(LE_V.X(:,keep_tr),0,2)';
        CycAvg.ly_cycstd = std(LE_V.Y(:,keep_tr),0,2)';
        CycAvg.rz_cycstd = std(RE_V.LHRH(:,keep_tr),0,2)';
        CycAvg.rl_cycstd = std(RE_V.LARP(:,keep_tr),0,2)';
        CycAvg.rr_cycstd = std(RE_V.RALP(:,keep_tr),0,2)';
        CycAvg.rx_cycstd = std(RE_V.X(:,keep_tr),0,2)';
        CycAvg.ry_cycstd = std(RE_V.Y(:,keep_tr),0,2)';
        %All cycles
        CycAvg.lz_cyc = LE_V.LHRH(:,keep_tr)';
        CycAvg.rz_cyc = RE_V.LHRH(:,keep_tr)';
        CycAvg.ll_cyc = LE_V.LARP(:,keep_tr)';
        CycAvg.rl_cyc = RE_V.LARP(:,keep_tr)';
        CycAvg.lr_cyc = LE_V.RALP(:,keep_tr)';
        CycAvg.rr_cyc = RE_V.RALP(:,keep_tr)';
        CycAvg.lx_cyc = LE_V.X(:,keep_tr)';
        CycAvg.rx_cyc = RE_V.X(:,keep_tr)';
        CycAvg.ly_cyc = LE_V.Y(:,keep_tr)';
        CycAvg.ry_cyc = RE_V.Y(:,keep_tr)';
        %Raw data too
        CycAvg.raw_Data = Data;
        %Other relevant items
        CycAvg.info = info;
        CycAvg.name = ['CycAvg_',In_FileName];
        CycAvg.filt = filt;
        CycAvg.cyclist = find(keep_tr);
    end
end