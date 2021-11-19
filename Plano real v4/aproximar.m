function [orden]=aproximar(z,ceros)
orden=4;
for(h=1:length(ceros))

 if((10^-3)>abs(z-ceros(h))) %%se define una tolerancia para limitar el numero de iteraciones
  orden =h;
  h=length(ceros)+1;
 
 end
     
end


end