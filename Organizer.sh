documentsFolder="$HOME/Documents"
picsFolder="$HOME/Pictures"
vidFolder="$HOME/Videos"
musicFolder="$HOME/Music"

declare -A extensionsMap
extensionsMap=(
    [".txt"]="documentsFolder" 
    [".pdf"]="documentsFolder"
    [".doc"]="documentsFolder"
    [".docx"]="documentsFolder"
    [".jpg"]="picsFolder"
    [".jpeg"]="picsFolder"
    [".png"]="picsFolder"
    [".gif"]="picsFolder"
    [".bmp"]="picsFolder"
    [".mp4"]="vidFolder"
    [".avi"]="vidFolder"
    [".mkv"]="vidFolder"
    [".mov"]="vidFolder"
    [".mp3"]="musicFolder"
    [".wav"]="musicFolder"
    [".ogg"]="musicFolder"
    [".flac"]="musicFolder"
    [".aac"]="musicFolder"
    [".wma"]="musicFolder"
    [".jpg"]="picsFolder"
    [".tiff"]="picsFolder"
    [".svg"]="picsFolder"
    [".webp"]="picsFolder"
    [".zip"]="documentsFolder"
    [".rar"]="documentsFolder"
    [".tar"]="documentsFolder"
    [".gz"]="documentsFolder"
    [".xlsx"]="documentsFolder"
    [".pptx"]="documentsFolder"
    [".html"]="documentsFolder"
    [".csv"]="documentsFolder"
    [".psd"]="documentsFolder"
)


for downloadsFolder in "${directories[@]}"; do
  echo "Processing: $downloadsFolder"
  

  sourceFolderName=$(basename "$downloadsFolder")
  

  for src in "$downloadsFolder"/*; do
      srcbase=$(basename "$src")
      ext=".${srcbase##*.}"
      destFolderVar=${extensionsMap[$ext]}
  
      if [ -z "$destFolderVar" ]; then
          echo "Skipping: $src (unknown extension)"
          continue
      fi

    
      destFolder="${!destFolderVar}"
      

      if [ "$sourceFolderName" != "Downloads" ]; then
          destFolder="$documentsFolder/${sourceFolderName} ${destFolder}"
          mkdir -p "$destFolder"
      else
          mkdir -p "$destFolder"
      fi

      if [ ! -e "$src" ]; then
          echo "Error: $src does not exist"
          continue
      fi
      

      if [ "$src" == "$destFolder/$srcbase" ]; then
          echo "File already in destination folder: $src"
          continue
      fi


      if [ -e "$destFolder/$srcbase" ]; then
          echo "File already in its correct folder: $src"
          continue
      fi
  
      dest="$destFolder/$srcbase"
      mv "$src" "$dest"
  
      if [ $? -eq 0 ]; then
          echo "Moved: $src -> $dest"
      else
          echo "Failed to move: $src"
      fi
  done
done
