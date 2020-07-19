%div = divergence(dot(u,v),x)
%ku = v * curl(sin(u)) - u * curl(v)
n = 100;
x = linspace(0,1,n);
y = linspace(0,1,n);
z = linspace(0,1,n);
[X,Y,Z] = meshgrid(x,y,z);

dx = x(2) - x(1);
dy = y(2) - y(1);
dz = z(2) - z(1);

u = zeros(n,n);
v = zeros(n,n);


for i = 1:length(x)
    for j = 1:length(y)
        for k = 1:length(z)   
            u(i,j,k,1) = sin(x(i));
            u(i,j,k,2) = sin(2*x(k));
            u(i,j,k,3) = cos(2*x(j));
            v(i,j,k,1) = sin(3*x(k));
            v(i,j,k,2) = cos(x(i));
            v(i,j,k,3) = cos(x(j));
        end
    end
end

u_K_v = cross(u,v);
[curl_u(:,:,:,1),curl_u(:,:,:,2),curl_u(:,:,:,3),cav] = curl(X,Y,Z,u(:,:,:,1),u(:,:,:,2),u(:,:,:,3));
[curl_v(:,:,:,1),curl_v(:,:,:,2),curl_v(:,:,:,3),cav] = curl(X,Y,Z,v(:,:,:,1),v(:,:,:,2),v(:,:,:,3));

lhs = divergence(X,Y,Z,u_K_v(:,:,:,1),u_K_v(:,:,:,2),u_K_v(:,:,:,3));

rhs1 = dot(v,curl_u,4);
rhs2 = dot(u,curl_v,4);
rhs = rhs1-rhs2;

test = sqrt((lhs-rhs).^2);
abs = 10^-4; abs2 = 10^-1;
teller = 0; teller2 = 0;
for i = 1:n 
    for j = 1:n
        for k = 1:n
            if test(i,j,k) < abs
                teller = teller +1 ;
            end
            if test(i,j,k) < abs2
                teller2 = teller2 +1 ;
            end
        end
    end
end
 riktig = teller/1000000 * 100;
 riktig2 = teller2/1000000 * 100;
 fprintf('Dette gir %.2f %% riktig, med en abs = %.1e og \nDette gir %.2f %% riktig, med en abs = %.1e og \n',riktig,abs,riktig2,abs2)

 
