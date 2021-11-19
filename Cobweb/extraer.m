function saux = extraer (f)
saux=[];
for i=1:length(f)
    
      if strcmp(f(i),'(')  || strcmp(f(i),')') || strcmp(f(i),',')
          
          if strcmp(f(i),',') 
              [num, status] = str2num(f(i-1))
              if  status
             saux=cat(2,saux,[f(i)]);
              end
          end
          
      else
         
          saux=cat(2,saux,[f(i)]);
          
      end
    
    
end


end