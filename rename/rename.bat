@echo off  
@echo  �޸� star_0001.png Ϊ 1.png
@echo ϵͳ�Դ�����Ȼ���1��ʼ��������
@echo ֻ��� png �����jpg��Ҫ�ʵ��޸Ľű�
set /a j=1
setlocal enabledelayedexpansion
for %%i in (*.png) do (
ren "%%i" !j!.png
set /a j+= 1
)
pause  