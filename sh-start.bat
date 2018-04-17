@echo off
echo ------start clean--------
CALL hexo clean
echo ------start generate--------
CALL hexo g
echo ------start server--------
CALL hexo s
pause