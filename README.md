#打开infile/input
#准备POSCAR 放infile/input中
#第10，13,14为上层，请检查POSCAR
#vaspkit 生成KPOINTS INCAR POTCAR
#检查POTCAR是否对了 grep -i VRHFIN POTCAR
#修改inter.sh/inter1.sh
#sh inter.sh 生成不同的d到 poscar/hc中
#提交任务 sh sub
#sh getE.sh 得到new.dat的能量
#修改队列文件在infile/cmpt.sh中
#此扫描层序是zyj师姐的基础上改的 
