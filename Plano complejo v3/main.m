function [map,itconverger]=main(f,fp,x_min,x_max,y_min,y_max,iteraciones,m,pc,check,colornoconver) 
%% ingrese los ceros de la ecuaci?n de la forma a+bi para complejos
% como ejemplo articular la ecuaci?n z^3-1 cuyos ceros se utilizaron en la forma
%cos((2*k*pi)/3)+i*sin((2*k*pi)/3) con k=0,1,2
%iteraciones=50;
%f=@(x,y)((x).^3)-1;
%fp=@(x,y)(3*(x).^2);
%pc=10^(-5);
%numero de puntos por graficar
%m=1000;
% l?mites de la gr?ficaci?n
%x_max =   2.5;
%x_min = - 2.5;
%y_max =   2.5;
%y_min = - 2.5;

% se crean la matriz de puntos por graficar
x=linspace(x_min,x_max,m);
y=linspace(y_min,y_max,m);
[X,Y]=meshgrid(x,y);

%% Se define una matriz que representa el plano complejo

C=complex(X,Y);
itconverger=zeros(m);
tolerancia=pc;
for k=1:iteraciones;
    convergencia=(f(C)./fp(C));
    % Me permite definir cuando un punto converge
    
    for i=1:m
        for j=1:m
            if 0==itconverger(i,j)
                itconverger(i,j)=int8(abs(convergencia(i,j))<tolerancia)*k;
            end
        end
    end
    %convergencia(isnan(convergencia))=0+0i;
    %convergencia=(f(C)./fp(C));
    C=C-convergencia;
    
    
end
% Funcion de escape, usada para colorear
% Funcion de escape, usada para colorear
X= real(roundn(C,-10));
Y= imag(roundn(C,-10));
C=complex(X,Y);
W=abs(f(C))<tolerancia;
ceros=[];
for i=1:m
    for j=1:m
        if W(i,j)==1
            if isempty(ceros)
                ceros=[ceros,C(i,j)];
                
            else
                bol=0;
                for k=1:length(ceros)
                    if (10^-3)>abs(C(i,j)-ceros(k))
                        bol=1;
                        itconverger(i,j)=((k-1)*iteraciones)+itconverger(i,j);
                        
                    end
                    
                end
                if bol==0
                    ceros=[ceros,C(i,j)];
                    itconverger(i,j)=(k*iteraciones)+itconverger(i,j);
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

%graficaci?n
%figure;
%colormap (map);
%pcolor(itconverger);
%shading flat;

%axis ('square','on');

end
