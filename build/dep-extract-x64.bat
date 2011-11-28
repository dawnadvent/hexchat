@echo off
set PATH=%PATH%;%PROGRAMW6432%\7-Zip;c:\mozilla-build\gendef

cd ..\dep-x64
7z x -y *.rpm
7z x *.cpio
del *.cpio
xcopy /q /s /i usr\x86_64-w64-mingw32\sys-root\mingw\* .
rmdir /q /s usr
set OPATH=%PATH%
set PATH=%PATH%;c:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin\amd64
cd lib
for %%A in (..\bin\*.dll) do (
	gendef %%A
	lib /nologo /machine:x64 /def:%%~nA.def
)
cd ..
set PATH=%OPATH%
7z x *.7z
copy /y ..\build\glibconfig-x64.h lib\glib-2.0\include\glibconfig.h
cd share\locale
del /q /s gettext-tools.mo
del /q /s gettext-runtime.mo
pause
