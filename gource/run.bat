gource --hide dirnames,filenames --seconds-per-day 0.1 --auto-skip-seconds 1 -1280x720 -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 gource.mp4
ffmpeg -i gource.mp4 -i song.mp3 -map 0:v -map 1:a -c:v copy -shortest output.mp4
ffmpeg -i output.mp4 -vcodec libx264 -acodec aac output_e.mp4
