$i = 0;
open F, sprintf(">sif-%03d.xml", $i);
while(<>) {
  if(m/<sif>/){
    s#<sif>#<sif xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sifassociation.org/datamodel/au/3.4">#;
    last;
  }
}
print F $_;
while(<>){
  s/<\/?SchoolInfos[^>]*>|<\/?StudentPersonals[^>*>]|<\/?NAPTests[^>]*>|<\/?NAPTestlets[^>]*>|<\/?NAPTestItems[^>]*>|<\/?NAPEventStudentLinks[^>]*>|<\/?NAPTestScoreSummarys[^>]*>|<\/?NAPStudentResponseSets[^>]*>//g;
  if(/<SchoolInfo[ >]|<StudentPersonal[ >]|<NAPTest[ >]|<NAPTestlet[ >]|<NAPTestItem[ >]|<NAPEventStudentLink[ >]|<NAPTestScoreSummary[ >]|<NAPStudentResponseSet[ >]/) {
    $n++;
    ($m) = /(<\/SchoolInfo>|<\/StudentPersonal>|<\/NAPTest>|<\/NAPTestlet>|<\/NAPTestItem>|<\/NAPEventStudentLink>|<\/NAPTestScoreSummary>|<\/NAPStudentResponseSet>)/;
    if($m) {
      print F $m, "\n";
      s/(<\/SchoolInfo>|<\/StudentPersonal>|<\/NAPTest>|<\/NAPTestlet>|<\/NAPTestItem>|<\/NAPEventStudentLink>|<\/NAPTestScoreSummary>|<\/NAPStudentResponseSet>)//;
    }
  }
  if ($n == 5000) {
    $n = 0;
    print F "</sif>\n";
    close F;
    open F, sprintf(">sif-%03d.xml", ++$i);
    print F '<sif xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sifassociation.org/datamodel/au/3.4">' . "\n";
  }
  print F $_;
}
close F;
