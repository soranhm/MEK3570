% Beviser 1.94 numerisk: (tester med 100 random matriser)
teller3 = 0;
teller4 = 0;
for s = 1:100
    abs = 10^-15;
    I = eye(3);
    A = rand(3,3);
    B = trace(A);
    C = sum(dot(I,A));
    D = sum(dot(A,I));

    if B ~= C || C ~= D || B ~= D
        if (B-C) < abs
            teller4 = teller4 +1;
        end
        teller3 = teller3 + 1;
    end
end
fprintf('1.94: %i%% av %i%% feil er pga avrunnings feil \n',teller4,teller3)

% Beviser 1.96 numerisk: (tester med 100 random matriser)
teller = 0;
teller2 = 0;
for s = 1:100
    abs = 10^-10;
    u = rand(1,3);
    v = rand(3,1);
    w = kron(u,v);
    A2 = rand(3,3);
    w2 = transpose(w);
    B = A2*v;

    C1 = sum(dot(A2,w2));
    C2 = dot(u,B);
    C3 = sum(dot(w2,A2));
    
    if C1 ~= C2 || C1 ~= C3 || C2 ~= C3
        if (C2-C1) < abs || (C1-C3) < abs || (C2-C3) < abs
            teller2 = teller2 +1;
        end
        teller = teller + 1;
    end  
end
fprintf('1.96: %i%% av %i%% feil er pga avrunnings feil \n',teller2,teller)


