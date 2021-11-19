function [ar]=newtonr(zo,ceros)
cercania=25;
orden=4;

    zn=zo-(f(zo)./fp(zo));      % metodo numerico Newton R
    orden=aproximar(zn,ceros); % permite ver a que cero se aproximó el nuevo z o si aun no converge
    if orden==4                % se encarga de terminar las iteraciones una vez que se converge
    else
         cercania=h;  
      
        break                   
    end
    zo=zn;
 end
 ar=[orden,cercania];
