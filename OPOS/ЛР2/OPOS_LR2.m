clc
clear
close all
%% ЛАБОРАТОРНАЯ РАБОТА №2
U_0 = 1.2;
f_s = 485E3;
m = 0.5;
F_m = 12E3;
f_p = 100E3;
     % Супергетеродин
f_g_v = f_p + f_s
f_g_n = f_s - f_p
Delta_f_AM = 2*F_m
P_kFT = 1.5*Delta_f_AM

f_0 = f_p;
L_kFT_sup = 1.5E-3
C_kFT_sup = 1/(L_kFT_sup*(2*pi*f_0)^2)
R_kFT_sup = 1/(2*pi*P_kFT*C_kFT_sup)
K_ITUN_sup = 1/R_kFT_sup
     % Инфрадин
f_p_inf = f_s + f_g_v
f_0 = f_p_inf;

L_kFT_inf = 150E-6;
C_kFT_inf = 1/(L_kFT_inf*(2*pi*f_0)^2)
R_kFT_inf = 1/(2*pi*P_kFT*C_kFT_inf)
K_ITUN_inf = 1/R_kFT_inf
    % Гомодин
f_v_FNH = 6*F_m
R_FNH_gom = 3E3;
C_FNH_gom = 1/(2*pi*f_v_FNH*R_FNH_gom)

