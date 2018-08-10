function saux = extraerlimites (f)
saux=[];
i=1;
while (i<length(f))
  
      if strcmp(f(i),'(')
         i=i+1;
          saux=cat(2,saux,[str2num(f(i))+0.01])
            
            i
      elseif strcmp(f(i+1),')') 
          
          
          saux=cat(2,saux,[str2num(f(i))-0.01]);
          break
      elseif  strcmp(f(i),'[') || strcmp(f(i),']') || strcmp(f(i),',')
        
      else
         i
          saux=cat(2,saux,str2num([f(i)]));
          
      end
    
    i=i+1;
end



end