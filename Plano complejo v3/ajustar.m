function saux = ajustar (f)

saux='';

for i=1:length(f)
    
        
        if strcmp(f(i),'^') || strcmp(f(i),'*') || strcmp(f(i),'/')
            
         saux=strcat(saux,'.',f(i));
        else
         saux=strcat(saux,f(i));   
        
        end
       
end

end