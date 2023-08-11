#CompileMod.sh
#
#Used to compile mod into .pk3 zip files
#usage: Put the bash file at the same directory the mod folder is installed at

MODDIR='PK3'
MODNAME='MicroTank_Stable'

#First pass
cd "./$MODDIR"
zip -r2 ../$MODNAME.pk3 .

#Second pass, because shit like smutty horses renames the damn file. 
cd ..
zip $MODNAME.zip $MODNAME.pk3
rm $MODNAME.pk3

