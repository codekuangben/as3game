@echo off

set base_dir=%~dp0
%base_dir:~0,2%
set browser="F:\Program Files (x86)\Internet Explorer\iexplore.exe"

pushd %base_dir%

cd ..

start "" %browser% "file:///%cd%/bin/index.html"
popd

exit