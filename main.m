clc;clear all
close all
%randstream(8)
%s = Randstream('mt19937ar','Seed',1);
iterations = 1000;
plist = 2:2:16;
nactions = length(plist);

sigma = 10^(-7);%noise power
alpha = 0.5; % learning rate
gamma = 0.9; % discounted parameter

Q = zeros(12,nactions);
QR = Q;
QM = zeros(6,nactions);

Qi =  zeros(12,nactions,iterations); % Q as a function of iterations
QRi = zeros(12,nactions,iterations); % Q as a function of iterations
QMi = zeros(6,nactions,iterations); % Q as a function of iterations

for tb = 10:10
    for ta = 1:1:5
        for yt = 2:2

            % calculate channel gains: Distance * pathloss
            g1f_i  = 10*10^(-4);   % gain btw FUE_i and its designated  FAP
            g1f_ij = 10*10^(-4);  % gain btw FUE_i and MBS (interference)
            gm_j   = 10*10^(-4);  % gain btw MUE & designated MBS
            gm_ij  = 10*10^(-4);  % gain btw MUE & FAP (interference)
            gf_r   = 10*10^(-4);   % gain btw FUE_r and FAP (interference)
            g1r_i  = 10*10^(-4);   % gain btw FUE_r and its designated  FAP
            
            % initial state
            prevstate = ceil(rand*12);   % femtouser
            prevstate_r = ceil(rand*12); % interfering femtouser
            prevstate_m = ceil(rand*6);  % macrouser
            
            for exp = 1:1
                for iter = 1:iterations
                    
                    % FUE action
                    I1 = randperm(nactions);
                    action_idx = I1(1);Pi_f  = plist(action_idx);
                    % Interfering FUE
                    I2 = randperm(nactions);
                    action_idx_r = I2(1);Pr_f  = plist(action_idx_r);
                    % MUE action
                    I3 = randperm(nactions);
                    action_idx_m = I3(1);Pj_m  = plist(action_idx_m);
                    
                    % compute SNR
                    yi = (Pi_f*g1f_i)/(Pj_m*gm_ij + Pr_f*gf_r + sigma^2);
                    ym = (Pj_m*gm_j)/(Pi_f*g1f_ij  + sigma^2);
                    yr = (Pr_f*g1r_i)/(Pj_m*gm_ij + sigma^2);
                    
                    [ next_state, next_reward_fi,next_reward_mi] = state_reward(ym,yi,yt,Pi_f,Pj_m,ta,tb );
                    [ next_stater, next_reward_fr,~] = state_reward( ym,yr,yt,Pr_f,Pj_m,ta,tb );
                    
                    % move to a random state
                    x =  ceil(rand*12);
                    xr = ceil(rand*12);
                    xm = ceil(rand*6);
                    
                    % get reward from action and state
                    rf_i = next_reward_fi;
                    rm_i = next_reward_mi;
                    rf_r = next_reward_fr;
                    
                    Q(prevstate,action_idx) =       Q(prevstate,action_idx)     + alpha *(rf_i+gamma*max(Q(x,:))   - Q(prevstate,action_idx));
                    QR(prevstate_r,action_idx_r) = QR(prevstate_r,action_idx_r) + alpha *(rf_r+gamma*max(QR(xr,:)) - QR(prevstate_r,action_idx_r));
                    QM(prevstate_m,action_idx_m) = QM(prevstate_m,action_idx_m) + alpha *(rm_i+gamma*max(QM(xm,:)) - QM(prevstate_m,action_idx_m));
                    
                    % Compute capacity
                    
                    % CapFi(:,iter) = log2(1+yi);
                    % CapFr(:,iter) = log2(1+yr);
                    % CapM(:,iter)  = log2(1+ym);
                    
                    % save the SINR
                    CapFi(:,iter) = yi;
                    CapFr(:,iter) = yr;
                    CapM(:,iter)  = ym;

                    prevstate = x;
                    prevstate_r = xr;
                    prevstate_m = xm;
                    PP(iter,:,:,:) = [next_state(1),next_state(2),next_state(3)];
                end
                
                
            end
            disp('Final state : ');disp(PP(iter,:,:,:))
            disp('Final Q matrix : ');disp(Q)
            [C,I]   = max(Q,[],2);
            disp('Final QR matrix : ');disp(QR)
            [Cr,Ir] = max(QR,[],2);
            disp('Final QM matrix : ');disp(QM)
            [Cm,Im] = max(QM,[],2);
            
            disp('Q(optimal):');disp(C);
            disp('QR(optimal):');disp(Cr);
            disp('QM(optimal):');disp(Cm);
            
            disp('Optimal Policy for FUE_I');disp('*');disp(plist(I));
            disp('Optimal Policy for FUE_R');disp('*');disp(plist(Ir));
            disp('Optimal Policy for MUE');disp('*');disp(plist(Im));
            
            disp('SINR MUE');disp('*');disp(ym);
            disp('SINR FUE');disp('*');disp(yi);
            
            figure;
            plot(1:iterations,CapFi,'-',1:iterations,CapM,'-');
            xlabel('Iterations');ylabel('SINR');
            legend('FUE','MUE');
            
        end
        
    end
    
end


%close all











