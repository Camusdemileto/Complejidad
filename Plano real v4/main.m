function [map,itconverger]=main(f,g,var,x_min,x_max,y_min,y_max,iteraciones,m,pc,check,colornoconver,numceros) 
%% ingrese los ceros de la ecuación de la forma a+bi para complejos
% como ejemplo articular la ecuación z^3-1 cuyos ceros se utilizaron en la forma
%cos((2*k*pi)/3)+i*sin((2*k*pi)/3) con k=0,1,2
%check=1;
%iteraciones=50;
%f='x.^5-10.*x.^3.*y.^2+5*x.*y.^4';
%g='5*x.^4.*y-10.*x.^2.*y.^3+y.^3';
%var='@(x,y)';

%f='x.^3-3.*x.*y.^2-1';
%g='3*x.^2.*y-y.^3';
%var='@(x,y)';

%f='cos(x).*sin(y)';
%g='x.^2+y.^2.-9';
%var='@(x,y)';

%f='cos(x).*sin(3*y)';
%g='sin(x)+cos(y)';
%var='@(x,y)';

%f='x.^2+y.^2.-4';
%g='x.*y-1';
%var='@(x,y)';
%colornoconver=[0,0,0];
v=str2func(strcat(var,'[',f,',',g,']'));
f=str2func(strcat(var,f));
g=str2func(strcat(var,g));
%numero de puntos por graficar
%m=1000;
% límites de la gráficación
%x_max =   pi/2;
%x_min = - pi/2;
%y_max =   pi/2;
%y_min = - pi/2;
syms x y 



J=jacobian([v], [x, y]);
fpx=str2func(ajustar(strcat(var,char(J(1,1)))));
fpy=str2func(ajustar(strcat(var,char(J(1,2)))));
gpx=str2func(ajustar(strcat(var,char(J(2,1)))));
gpy=str2func(ajustar(strcat(var,char(J(2,2)))));
convergencia1=@(x,y)(1./((fpx(x,y).*gpy(x,y))-(fpy(x,y).*gpx(x,y)))).*((gpy(x,y).*f(x,y))-(fpy(x,y).*g(x,y)));
convergencia2=@(x,y)(1./((fpx(x,y).*gpy(x,y))-(fpy(x,y).*gpx(x,y)))).*((fpx(x,y).*g(x,y))-(gpx(x,y).*f(x,y)));



%pc=10^(-14);
% se crean la matriz de puntos por graficar
x = gpuArray.linspace(x_min, x_max, m);
y = gpuArray.linspace(y_min, y_max, m );
[X,Y] = meshgrid( x, y );


%% Se define una matriz que representa el plano complejo
%itconverger = zeros( size(X)*100, 'gpuArray' );
%X=[1,2,3,4]
%Y=[1,2,3,4]
%X=reshape(X,[1,1,m*m]);
%Y=reshape(Y,[1,1,m*m]);

itconverger= zeros( size(X));
tolerancia=pc; 
X1=gather( X );
Y1=gather( Y );
f1=gather( f(X,Y) );
g1=gather( g(X,Y) );

for  k=1:iteraciones
 
    itconverger=((itconverger~=0).*itconverger)+(((itconverger==0)*k).*(( convergencia1(X,Y).^2 + convergencia2(X,Y).^2).^(1/2)<tolerancia) );
   
  % itconverger=((itconverger~=0).*itconverger)+(((itconverger==0)*k).*(abs( f(X,Y) )<tolerancia & abs( g(X,Y))<tolerancia));
   
    X=X-convergencia1(X,Y);
    Y=Y-convergencia2(X,Y);
    %conv1=gather(convergencia1(X,Y));
    %conv2=gather(convergencia2(X,Y));
    %X1=gather( X );
    %Y1=gather( Y );
    %f1=gather( f(X,Y) );
    %g1=gather( g(X,Y) );
    %it=gather( itconverger );
  
    %k=k+1;
    %w1=Y(1:100,1:100);
    %w2=Y(900:1000,1:100);
    %w3=Y(1:100,900:1000);
    
    
end

W=(abs(gather( f(X,Y) ))<tolerancia & abs(gather( g(X,Y) ))<tolerancia);
% Funcion de escape, usada para colorear
% Funcion de escape, usada para colorear
X= gather( X );
Y= gather( Y );
C=complex(roundn(X,-4),roundn(Y,-4));
ceros=[];
%numceros=5;
itconverger=gather( itconverger );
if numceros ~=0 
tolerancia=10^(-3)
indices=find((abs( f(X,Y) )<tolerancia & abs(  g(X,Y) )<tolerancia));
uaux=unique(C(indices));
uaux=unique(uaux);

largo=length(uaux);
uaux=[uaux,zeros(size(uaux))];  
for i=1:largo
uaux(i,2)=length(find(C==uaux(i,1)));
end
[d1,d2] = sort(uaux(:,2),'descend');

uaux=uaux(d2,1);
ceros=uaux(1:numceros)';

largo=length(ceros);
for k=1:largo
    indices=find((10^-1)>abs(C-ceros(k)));
itconverger(indices)=((k-1)*iteraciones)+itconverger(indices);
end

else
%C= gather( C );
%W= gather( W );


ceros=[];
for i=1:m
    for j=1:m
        if W(i,j)==1
            if isempty(ceros)
                ceros=[ceros,C(i,j)];
                
            else
                bol=0;
                for k=1:length(ceros)
                    if (10^-1)>abs(C(i,j)-ceros(k)) 
                        bol=1;
                        itconverger(i,j)=((k-1)*iteraciones)+itconverger(i,j);
                        
                    end
                    
                end
               %% abs(C(i,j)-ceros(k))
                if bol==0
                    ceros=[ceros,C(i,j)];
                    itconverger(i,j)=(k*iteraciones)+itconverger(i,j);
                end
            end
        end
    end
end



end
coloresceros=[];
if check==1
v=1
s=1
cs=s*v;
ms=v-cs;

haux=floor(360/length(ceros));
h=0;

for i=1:length(ceros)
  xs=cs*(1-abs(mod(h/60,2)-1))
  r=0;g=0;b=0;
    if (0<=h) & (h<60)
        cs=0.5;
        r=cs;g=xs;
    elseif (60<=h) & (h<120)
         cs=0.6;
        r=xs;g=cs;
    elseif (120<=h)& (h<180)
         cs=0.5;
        g=cs;b=xs;
    elseif (180<=h)& (h<240)
         cs=0.8;
        g=xs;b=cs;
    elseif (240<=h)& (h<300)
        cs=0.7;
        r=xs;b=cs;
    elseif (300<=h)& (h<360)
        cs=0.8;
        r=cs;b=xs;
   
    end
 
 coloresceros=[coloresceros;[(r+ms)*255,(g+ms)*255,(b+ms)*255]];
 h=h+haux;
end

else
    
for i=1:length(ceros)
    coloresceros=[coloresceros;uisetcolor( strcat('Color ',num2str(i),' de ',num2str(length(ceros))))*255];
end
end
coloresceros=[coloresceros;colornoconver];
aux=[]
tam=size(coloresceros);
  % Es el numero de iteraciones al que se va someter el metodo
for(i=1:tam(1))
    aux=[aux; [floor((255-coloresceros(i,1))/iteraciones),floor((255-coloresceros(i,2))/iteraciones),floor((255-coloresceros(i,3))/iteraciones)]];
    
end
deg=0;
map=[]; 

for(i=1:tam(1)-1)  
   for(j=iteraciones:-1:1)
    map=[map;[(coloresceros(i,1)+(aux(i,1)*j))/255,(coloresceros(i,2)+(aux(i,2)*j))/255,(coloresceros(i,3)+(aux(i,3)*j))/255]];
    end
end
map=[coloresceros(tam(1),:);map]

%graficación
%figure;
%colormap (map);
%pcolor(itconverger);
%shading flat;

%axis ('square','on');

end
