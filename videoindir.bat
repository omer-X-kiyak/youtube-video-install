@echo off
chcp 65001 >nul
cls
color 2

:menu
echo ===================================
echo       yt-dlp Video İndirme Menü  Edit: By KIYAK omer-x-kiyak
echo ===================================
echo.
echo 1. Video İndir
echo 2. Farklı Dosya Adı ile Video İndir
echo 3. Belirli Format ile Video İndir
echo 4. Müzik veya Video Formatını Seç
echo 5. Playlist Video İndir
echo 6. Video Bilgisi Al
echo 7. Bütün Videoları İndir (Playlist)
echo 8. Çıkış
echo ===================================
set /p choice=Bir seçim yapın (1-8): 

if "%choice%"=="1" goto download
if "%choice%"=="2" goto custom_name
if "%choice%"=="3" goto format_download
if "%choice%"=="4" goto media_type
if "%choice%"=="5" goto playlist_download
if "%choice%"=="6" goto info
if "%choice%"=="7" goto all_videos
if "%choice%"=="8" exit

:download
cls
echo.
echo Video indirmek için URL girin:
set /p url=URL: 
echo Dosya adı (girilmezse varsayılan kullanılır):
set /p filename=Dosya Adı (boş bırakılabilir): 
echo Kaydedileceği dizini girin (boş bırakılabilir):
set /p savepath=Kaydetme Yolu (örnek: /1 veya C:\Downloads\):
if "%savepath%"=="" (
    set savepath="C:/Downloads"
) else if not exist "%savepath%" (
    mkdir "%savepath%"
)

if "%filename%"=="" (
    yt-dlp -o "%savepath%/%(title)s.%(ext)s" %url%
) else (
    yt-dlp -o "%savepath%/%filename%.%(ext)s" %url%
)
pause
goto menu

:custom_name
cls
echo.
echo Farklı dosya adı ile video indirmek için URL girin:
set /p url=URL: 
echo Dosya adı girin:
set /p filename=Dosya Adı: 
echo Kaydedileceği dizini girin (boş bırakılabilir):
set /p savepath=Kaydetme Yolu (örnek: /1 veya C:\Downloads\):
if "%savepath%"=="" (
    set savepath="C:/Downloads"
) else if not exist "%savepath%" (
    mkdir "%savepath%"
)

yt-dlp -o "%savepath%/%filename%.%(ext)s" %url%
pause
goto menu

:format_download
cls
echo.
echo Belirli bir formatla video indirmek için URL girin:
set /p url=URL: 
yt-dlp -F %url% > formats.txt
echo Aşağıdaki formatlardan birini seçin:
for /f "tokens=1,2 delims= " %%a in ('findstr /r "^ *[0-9]" formats.txt') do (
    echo %%a. %%b
)
set /p format=Seçim yapın (ID numarası): 
echo Kaydedileceği dizini girin (boş bırakılabilir):
set /p savepath=Kaydetme Yolu (örnek: /1 veya C:\Downloads\):
if "%savepath%"=="" (
    set savepath="C:/Downloads"
) else if not exist "%savepath%" (
    mkdir "%savepath%"
)

yt-dlp -f %format% -o "%savepath%/%(title)s.%(ext)s" %url%
pause
goto menu

:media_type
cls
echo.
echo URL'yi girin ve formatları listeleyelim.
set /p url=URL: 
yt-dlp -F %url% > formats.txt
echo Aşağıdaki formatlardan birini seçin:
for /f "tokens=1,2 delims= " %%a in ('findstr /r "^ *[0-9]" formats.txt') do (
    echo %%a. %%b
)
set /p format=Seçim yapın (ID numarası): 
echo İndirilecek dosya tipi seçin:
echo 1. Müzik (Ses)
echo 2. Video (Ses ve Görüntü)
set /p mediatype=Seçim yapın (1 veya 2): 
echo Kaydedileceği dizini girin (boş bırakılabilir):
set /p savepath=Kaydetme Yolu (örnek: /1 veya C:\Downloads\):
if "%savepath%"=="" (
    set savepath="C:/Downloads"
) else if not exist "%savepath%" (
    mkdir "%savepath%"
)

if "%mediatype%"=="1" (
    yt-dlp -x --audio-format mp3 -o "%savepath%/%(title)s.%(ext)s" %url%
) else if "%mediatype%"=="2" (
    yt-dlp -f %format% -o "%savepath%/%(title)s.%(ext)s" %url%
)
pause
goto menu

:playlist_download
cls
echo.
echo Playlist video indirmek için URL girin:
set /p url=Playlist URL: 
echo Kaydedileceği dizini girin (boş bırakılabilir):
set /p savepath=Kaydetme Yolu (örnek: /1 veya C:\Downloads\):
if "%savepath%"=="" (
    set savepath="C:/Downloads"
) else if not exist "%savepath%" (
    mkdir "%savepath%"
)

yt-dlp --yes-playlist -o "%savepath%/%(playlist)s/%(title)s.%(ext)s" %url%
pause
goto menu

:all_videos
cls
echo.
echo Bütün videoları indirmek için Playlist URL girin:
set /p url=URL: 
echo Kaydedileceği dizini girin (boş bırakılabilir):
set /p savepath=Kaydetme Yolu (örnek: /1 veya C:\Downloads\):
if "%savepath%"=="" (
    set savepath="C:/Downloads"
) else if not exist "%savepath%" (
    mkdir "%savepath%"
)

yt-dlp -o "%savepath%/%(playlist)s/%(title)s.%(ext)s" %url%
pause
goto menu

:info
cls
echo.
echo Video bilgisi almak için URL girin:
set /p url=URL: 
yt-dlp -F %url%
pause
goto menu
