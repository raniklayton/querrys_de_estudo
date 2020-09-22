execute block
returns (texto varchar (100))
as
declare  variable vInt integer;
begin
vInt= 1;
while (vInt <= 10) do
begin
texto = '8*'||vInt||'='||(vInt*8) ;
vInt =  vInt+1;
suspend;
end
end