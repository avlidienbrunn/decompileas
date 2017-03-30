count=$(ls -l ./*.swf |wc -l)
ffdec="/Users/avlidienbrunn/hax/ffdec/ffdec.jar"
for file in ./*.swf
do
   count=$(($count-1))
   echo "$count files left"
   java -jar $ffdec -export script "./$file-scripts" "$file" 1>/dev/null
done
grep -r --include "*.as" -i -E "geturl\((['\"]j|\w)|xml\.load|loadvars\.(load|send)|loadmovie(num)?|loadvariables|externalinterface.call|security.allowdomain|navigatetourl|htmltext\s*=" . | cut -d ":" -f1 | cut -d "/" -f 2 | sed 's/-scripts//g' | uniq -c | sort -r | sed 's/^[ ]*//g'
read -p "Print suspicious files/lines? (y/n): " -n 1 choice
case "$choice" in 
  y|Y ) grep -r --include "*.as" -i -E "geturl\((['\"]j|\w)|xml\.load|loadvars\.(load|send)|loadmovie(num)?|loadvariables|externalinterface.call|security.allowdomain|navigatetourl|htmltext\s*=" .;;
  n|N ) echo "";;
  * ) echo "";;
esac
