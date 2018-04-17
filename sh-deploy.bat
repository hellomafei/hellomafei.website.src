@echo off
echo ------start clean--------
CALL hexo clean
echo ------start generate--------
CALL hexo g
echo ------start deploy--------
CALL hexo d -g
pause