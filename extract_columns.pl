use Text::CSV;
my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
  or die "Cannot use CSV: ".Text::CSV->error_diag ();
open my $fh, "<:encoding(utf8)", "writing_extract.csv" or die "writing_extract.csv: $!";
 my @hdr = $csv->header ($fh);
while ( my $row = $csv->getline( $fh ) ) {
  # Test Year,Test level,Jurisdiction Id,ACARA ID,PSI,Local school student ID,TAA student ID,Participation Code,Item Response,Anonymised Id,Test Id
  # to: PSI,Participation Code,Item Response
  #$row->[8] = '"' . $row->[8] . '"' if $row->[8];
  push @rows, [$row->[4], $row->[7], $row->[10], $row->[8] ];
}
$csv->eof or $csv->error_diag();
 close $fh;
$csv->eol ("\n");
@rows = sort {$$a[0] cmp $$b[0] } @rows;

 open $fh, ">:encoding(utf8)", "test_writing_extract.csv" or die "test_writing_extract.csv: $!";
 $csv->print ($fh, $_) for @rows;
 close $fh or die "new.csv: $!";

