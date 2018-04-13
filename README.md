# nias_writing_extract_test
NIAS Writing Extract test: independent extraction of CSV from source XML for comparison

This software is intended to valdiate the Writing Extract report generated by [NIAS2](https://github.com/nsip/nias2). It does so by extracting three fields from the source XML (PSI, Participation Status, Writing Response); extracting the same information from the writing_extract.csv report generated by NIAS from the same source XML; and comparing the two files.

NIAS extracts information from XML by streaming the XML, parsing the stream one object at a time, and extracting information into Golang structs; information is joined between objects by traversing a graph database. This test software extracts information from XML through XSLT stylesheets; information is joined between objects by looking up common identifiers in the files via perl. Because of performance constraints around XSLT 1.0, the source XML is split into files of 5000 objects before processing.

This software runs on Unix (including Mac command line), and it uses xsltproc and perl. The perl script uses Text::CSV to 
parse the NIAS output; you will need to run `cpan` to install it:

````
$ cpan
> install Text::CSV
````

The software expects two files to be supplied in the directory it is run in:
* `sif.xml` is the source XML file output by the National Assessment platform. The file splitter assumes this is a file with a root `<sif>` tag, as is the case as of this writing.
* `writing_extract.csv` is the file output by NIAS as the Writing Extract report. The software expects the columns in the source file are in the order supplied by default: Test Year,Test level,Jurisdiction Id,ACARA ID,PSI,Local school student ID,TAA student ID,Participation Code,Item Response,Anonymised Id

Testing is run as follows:
* Download the NIAS2 tool from https://github.com/nsip/nias2/releases
* Copy the sif.xml file to the `naprrql/in` folder of the NIAS2 download, and remove the master_nap.xml.zip sample file already in `naprrql/in`
* For improved performance, you can zip the sif.xml file
* cd to `naprrql` and run `naprrql --ingest`; this reads the contents of the sif.xml (or sif.xml.zip) file into NIAS2
  * For a file with 50,000 students, the ingest takes 7 minutes on an i5 PC, 5 minutes on an i7 Quad Core Mac
* Run `naprrql --writingextract`; this outputs the CSV report writing_extract.csv to the out/writing_extract directory. 
  * For a file with 50,000 students, the output takes 3 minutes on an i5 PC, 2 minutes on an i7 Quad Core Mac
  * The CSV report contains a row for every student in the source file that was registered for a writing text in the source XML file, whether they have actually sat the test or not. Because the source XML does not track paper tests, there will be no entries for Year 3 students.
* Copy the sif.xml file to the directory that this software has been downloaded to
* Copy the writing_extract.csv file to the directory that this software has been downloaded to
* Run `writingextract.sh`. The script does the following:
  * Split sif.xml into chunks with 5000 objects each (102 files for a file with 50,000 students)
  * For each chunk, run four XSLT transforms to extract information about writing tests, student registrations for tests, and test results
 * Run a perl script to filter and join those four extracts into a single sorted CSV file, confirm_writing_extract.csv, containing three fields to check: the Platform Student Identifier for the student, their participation status for the writing test, and their response (if any) to the writing test, coded as HTML (as it is in the source XML).
 * Run a perl script to extract from the writing_extract.csv the same three fields, saved as test_writing_extract.csv
 * diff the two files; they should be identical, in which case diff will return no output
 * The script takes 7 minutes to run on an i7 Quad Core Mac
