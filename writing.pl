use Text::CSV;
open F, "<:encoding(UTF-8)", "writing_tests.csv";
while(<F>) {
  chomp;
  next unless /\S/;
  ($id, $localid) = split /,/, $_;
  $writingtest{$id} = $localid;
}
close F;
@out = ();
%out1 = ();
open F, "<no_rsp_events.csv";
while(<F>) {
  chomp;
  next unless /\S/;
  ($id, $participation, $psi) = split /,/, $_;
  next unless $writingtest{$id};
  push @out, [$psi, $participation, $writingtest{$id}, ""];
}
close F;
open F, "<rsp_events.csv";
while(<F>){
  chomp;
  ($id, $participation, $psi) = split /,/, $_;
  next unless $writingtest{$id};
  next unless /\S/;
  $out1{$psi} = ();
  $out1{$psi}{"participation"} = $participation;
  $out1{$psi}{"test_id"} = $writingtest{$id};
}
close F;
open F, "<:encoding(UTF-8)", "responses.csv";
while(<F>) {
  chomp;
  next unless /\S/;
  ($id, $psi, $response) = /^([^,]+),([^,]+),(.*)$/;
  next unless $writingtest{$id};
  # to match output from perl csv manipulation
  $out1{$psi}{"response"} = $response;
}
foreach $psi (keys %out1) {
  push @out, [$psi, $out1{$psi}{"participation"}, $out1{$psi}{"test_id"}, $out1{$psi}{"response"}];
}
@out = sort @out;


my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
  or die "Cannot use CSV: ".Text::CSV->error_diag ();
$csv->eol ("\n");
@out = sort {$$a[0] cmp $$b[0] } @out;

 open $fh, ">:encoding(utf8)", "confirm_writing_extract.csv" or die "confirm_writing_extract.csv: $!";
 $csv->print ($fh, $_) for @out;
 close $fh or die "new.csv: $!";



