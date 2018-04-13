# expects: source sif.xml, writing_extract.csv
rm -f sif-*.xml
perl splitter.pl < sif.xml
echo "" > writing_tests.csv
echo "" > no_rsp_events.csv
echo "" > rsp_events.csv
echo "" > responses.csv
for filename in ./sif-*.xml; do
xsltproc writing0.xslt $filename >> writing_tests.csv &
xsltproc writing1.xslt $filename >> no_rsp_events.csv &
xsltproc writing2.xslt $filename >> rsp_events.csv &
xsltproc writing3.xslt $filename >> responses.csv &
wait
done
perl writing.pl > confirm_writing_extract.csv
perl extract_columns.pl < writing_extract.csv
diff test_writing_extract.csv confirm_writing_extract.csv
