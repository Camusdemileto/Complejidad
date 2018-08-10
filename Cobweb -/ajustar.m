function saux = ajustar (f)

saux='';
bol=0;
trozo=0;
for i=1:length(f)
       
       
        
        if strcmp(f(i),'^') || strcmp(f(i),'*') || strcmp(f(i),'/')
            
         saux=strcat(saux,'.',f(i));
         
        elseif strcmp(f(i),',') && bol == 0
         saux = strcat(saux,'.*(');
         bol  = 1;
         trozo=1;
            elseif strcmp(f(i),',') && bol == 1
         saux=strcat(saux,')+');
          bol  = 0;
        else
         saux=strcat(saux,f(i));   
        
        end
       
end
if trozo
       saux=strcat(saux,')');
end


end