b = [1 2 0.2i
     1 4 0.25i
     2 3 0.3i
     2 4 0.4i
     3 4 0.15i];
s = [1 0.1i
     2 0.1i];
Z = Zbus(b,s);
Y = Ybus(b,s);
disp(abs(Z-inv(Y))>1e-3)