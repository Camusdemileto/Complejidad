

z=0:0.1:1
y=4*z.*(1-z); % mapa logistico, a los operadores * y / se les coloca un punto antes .* y ./
F=figure
plot(z,y)
hold on
plot(z,z)
z=0.1;
aux=0;
f=@(z)4*z.*(1-z);   % mapa logistico, a los operadores * y / se les coloca un punto antes .* y ./ 4 es el parametro
fin=200; %Cantidad de Iteraciones
while (aux~=z ) 
   aux=z;

plot( [z z], [z f(z)], 'k') %linea vertical

plot( [z f(z)], [f(z) f(z)], 'k--') 

z=f(z);
fin=fin-1;
if fin==0
break;
end

end
s='cobweb.m';
w=which(s);
w=w(1:end-length(s));



xlabel('Eje x'),ylabel('Eje y');
saveas(F,strcat(w,'cobweb.jpg')) % Direccion donde se guarda la imagen del mapa



