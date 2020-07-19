start = 0;
slutt = 1;
n = 100;
h = (slutt-start)/n; % step
x = start:h:slutt;
y = start:h:slutt;
u = zeros(n,n);
v = zeros(n,n);

for i = 1:n
    for j = 1:n
        u(i,j) = sin(x(j));
        v(i,j) = cos(x(j));
   end 
end
uv = u.*v;
[dudx,dudy] = gradient(u,h,h);
[dvdx,dvdy] = gradient(v,h,h);
[duvdx,duvdy] = gradient(uv,h,h);
dudx = dudx(21:80,21:80);
duvdx = duvdx(21:80,21:80);
dvdx = dvdx(21:80,21:80);
v = v(21:80,21:80);
u = u(21:80,21:80);
dudy = dudy(21:80,21:80);
duvdy = duvdy(21:80,21:80);
dvdy = dvdy(21:80,21:80);


% grad(u*v) = grad(u) * v + u * grad(v)

lhsi = sqrt((duvdx - v.*dudx - u.*dvdx).^2);
lhsj = sqrt((duvdy - v.*dudy - u.*dvdy).^2);
abs = 10^-4; teller = 0; abs2 = 10^-6; teller2 = 0;
for i = 1:60
    for j = 1:60   
        if lhsi(i,j) < abs && lhsj(i,j) < abs
            teller = teller + 1;
        end
        if lhsi(i,j) < abs2 && lhsj(i,j) < abs2
            teller2 = teller2 + 1;
        end
    end
end
riktig = (teller/(60*60)) * 100;
riktig2 = (teller2/(60*60)) * 100;

fprintf('Dette gir %.2f %% riktig, med en abs = %.1e og \nDette gir %.2f%% riktig, med en abs = %.1e og \n',riktig,abs,riktig2,abs2)

%  || grad(u*v) - grad(u) * v - u * grad(v)||













